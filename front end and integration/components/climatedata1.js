import Head from 'next/head';
import { useState, useEffect } from 'react';
import AOS from 'aos';
import 'aos/dist/aos.css';
import axios from 'axios';
import Link from "next/link";

export default function ClimateData1(){
  const [location, setLocation] = useState(null);
  const [longitude, setLongitude] = useState(null);
  const [latitude, setLatitude] = useState(null);
  const [temperature, setTemperature] = useState(null);
  const [humidity, setHumidity] = useState(null);
  const [weather, setWeather] = useState(null);
  const [pressure, setPressure] = useState(null);
  const [windspeed, setWindspeed] = useState(null);
 
  

    const fetchClimateData1 = async () => {
      try {
        const response = await axios.get(
          'https://api.openweathermap.org/data/2.5/weather?q=nigeria&appid=2e6fc6d24b084dba01ab9a4c67f555f1'
        );
        console.log('Weather Data:', response.data);
        // Extract relevant climate information from the response
        setLocation(response.data.name);
        setLongitude(response.data.coord.lon);
        setLatitude(response.data.coord.lat);
        setHumidity(response.data.main.humidity);
        setTemperature(response.data.main.temp);
        setWeather(response.data.weather[0].description);
        setPressure(response.data.main.pressure);
        setWindspeed(response.data.wind.speed);

      } catch (error) {
        console.error('Error fetching data:', error.message);
      }
    };
   
     useEffect(() => {
      fetchClimateData1();
    AOS.init();
  }, []);  

  return (
      
        <div className='bg-[#ccc] p-[5%] rounded-xl' style={{boxShadow:"2px 2px 5px 2px rgba(0,0,0,0.5)"}}>
        <div><iframe className='w-[100%] h-[5cm]' src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d4035000.8351819906!2d6.03636285224305!3d9.024434517051265!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x104e0baf7da48d0d%3A0x99a8fe4168c50bc8!2sNigeria!5e0!3m2!1sen!2sng!4v1701192949168!5m2!1sen!2sng" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe></div>
        <div className='mt-[0.3cm]'><span className='font-[600]'>Location: </span><span>{location}</span></div>
        <div className='mt-[0.3cm]'><span className='font-[600]'>Longitude & Latitude: </span><span>{longitude} deg, {latitude} deg</span></div>
        <div className='mt-[0.3cm]'><span className='font-[600]'>Temperature: </span><span>{temperature} K</span></div>
        <div className='mt-[0.3cm]'><span className='font-[600]'>Humidity: </span><span>{humidity} %</span></div>
        <div className='mt-[0.3cm]'><span className='font-[600]'>Weather: </span><span>{weather}</span></div>
        <div className='mt-[0.3cm]'><span className='font-[600]'>Pressure: </span><span>{pressure} hPa</span></div>
        <div className='mt-[0.3cm]'><span className='font-[600]'>Wind speed: </span><span>{windspeed} mph</span></div>
        </div>
  );
};
