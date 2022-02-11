import React, { useState, useRef, useEffect } from 'react';

const WorldMap = () => {
  const [data, setData ] = useState([]);

  const canvasRef = useRef<HTMLCanvasElement>(null);
    
  useEffect(() => {
    if (canvasRef.current) {
      const canvas = canvasRef.current;
      const context = canvas.getContext('2d');
      if (context) {
        context.beginPath();
        context.arc(50, 50, 50, 0, 2 * Math.PI);
        context.fill();
      }
    }       
  },[]);

  useEffect(() => {
    async function fetchRecent() {
      const resp = await fetch("http://localhost:4000/recent_postings", {
        method: "GET",
        headers: {'Content-Type': 'application/json',
                  'Accept': 'application/json'},
      })
      const recentData = await resp.json();
      setData(recentData);
    }
    fetchRecent()
    /* console.log(data);     */
  }, [setData])

  return (
    <canvas ref={canvasRef} />
  )

}

export default WorldMap;
