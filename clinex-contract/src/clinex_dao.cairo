    use starknet::ContractAddress; 
    use array::ArrayTrait;

    #[derive(Drop, starknet::Store)]
    struct Proposal {
        proposal_id: u128,
        vote_count: u128,
        name: felt252,
        description: felt252,
        deadline: u256,
        is_proposed: bool,
    }

    #[derive(Drop, starknet::Store)]
    struct Member {
        proposal_id: u128,
        vote_count: u128,
        name: felt252,
        description: felt252,
        deadline: u256,
        is_proposed: bool,
    }

#[starknet::interface]
trait IDAO<TContractState> {
    fn join_dao(ref self: TContractState ) -> u128;
    fn access(self: @TContractState) -> bool;
    fn member_list(self: @TContractState) -> ArrayTrait;
    fn view_proposals(self: @TContractState) -> ArrayTrait;
    fn create_proposal(ref self: TContractState) -> u128;
    fn vote(ref self: TContractState, proposal_id: u128) -> bool;
    fn execute_proposal(ref self: TContractState, proposal_id: u128) -> bool;
    fn rejected_proposals(self: @TContractState) -> ArrayTrait;
}

#[starknet::contract]
mod ClinexDao {
    use clinex::clinex_token::{get_balance_of_user, transfer};
    use starknet::{get_caller_address, get_contract_address, get_block_timestamp};
    use super::{ITokenDispatcher, ITokenDispatcherTrait};

    #[storage]
    struct Storage {
        proposals: usize,
        proposal_count: u128,
        members_count: u128,
        member_list: usize,
        is_member: LegacyMap::<ContractAddress,bool>,
        rejected_proposals: usize,
        is_voted: LegacyMap::<(Proposal, get_caller_address), bool>,
        member_id: u128,
        token: ContractAddress
    }

    #[constructor]
    fn constructor(ref self: ContractState) {
        let token: ContractAddress = 0x01cb296d5ae3f94e244b4332b99033fb22987d9e46252414f905fece3032b23f.try_into().unwrap();
        self.token.write(token);
    }

    #[external(v0)]
    impl IDaoImpl of clinex::clinex_dao::IDAO<ContractState>{
        fn join_dao(ref self: ContractState ) -> u128 {
            // let token = ITokenDispatcher {self.token.read()};
            assert(self.is_member.read(get_caller_address()) == false, 'Already a Member');
            assert(ITokenDispatcher {self.token.read()}.get_balance_of_user(get_caller_address()) >= 1000, 'Insufficient Tokens');
            transfer(get_contract_address, 1000);
            self.member_list.append(get_caller_address());
            self.is_member.write(true);
            self.members_count.write(self.members_count.read() + 1);
            self.member_id.write(self.members_count.read());
            
        }
        fn access(self: @TContractState) -> bool{
            assert(self.is_member.read(get_caller_address()) == true, 'Not a member');
        }
        fn member_list(self: @ContractStatre) -> ArrayTrait {
            self.access();
            self.member_list.read()   
        }
        fn view_proposals(self: @ContractState) -> ArrayTrait {
            self.access();
            self.proposals.read()
        }
        fn create_proposal(ref self: ContractState, title: felt252, desc: felt252, deadline: u128) -> u128 {
            self.access();
            let new_proposal = Proposal {
                proposal_id: proposal_id + 1, 
                name: title, 
                description: desc, 
                deadline: deadline, 
                is_proposed: true
            };
            self.proposals.append(new_proposal);
            self.proposal_count.write(self.proposal_count.read() + 1);
            new_proposal.proposal_id
        }
        fn vote(ref self: ContractState, proposal_id: u128) -> bool {
            self.access();
            let proposal = Proposal {
                proposal_id: proposal_id,
            };
            assert(proposal.is_proposed == true, 'Proposal does not exist' );
            proposal.vote_count + 1;
            self.is_voted.write((proposal, get_caller_address()), true)

        }
        fn execute_propostl(ref self: ContractState, proposal_id: u128) -> bool {
            self.access();
            let proposal = Proposal;
            assert(proposal.is_proposed == true, 'Not exist');
            assert(proposal.deadline <= get_block_timestamp(), 'Not deadline');
            if (proposal.vote_count == 0 || proposal.vote_count < self.members_count / 3) {
                self.rejected_proposals.append(proposal)
            }

        }
        fn rejected_proposals(self: @ContractState) -> ArrayTrait {
            self.access();
            self.rejected_proposals.read()
        }
    }
}