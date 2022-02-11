import React, { useState } from 'react';

const Homepage = () => {
  const [mood, setMood] = useState("");

  const handleChange = (event: any) => {
    setMood(event.target.value);
  };

  const onSubmit = (event: any) => {
    console.log(mood);
    event.preventDefault();
    if (mood.indexOf(' ') >= 0 || mood.length > 12) {
      console.log("Can't post this, too long or isn't one word")
    }
    else {
      fetch("http://localhost:4000", {
        method: "POST",
        headers: {'Content-Type': 'application/json'},
        body: mood
      }).then(res=>{
        console.log("Request complete! Response:", res);
      })
    };
  };
    
  return (
    <div>
      hi there
      <form onSubmit={(event)=>onSubmit(event)}>
        <label>
          How are you feeling?
          <input type="text" onChange={(event)=>handleChange(event)} />
        </label>
        <input type="submit" value="submit" />
      </form>
    </div>
  )
};

export default Homepage
