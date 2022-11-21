# Apex EL setup HIMB summer 2022

The end goal of this setup is to have 2 large blue tubs as high temperature treatments and 2 large blue tubs where temperature is not controlled, just monitored at ambient levels. The high temperature tubs should have their temperatures fluctuate in tandem with the ambient daily fluctuations. The fluctuating temperature of a tank is controlled by 8 virtual outlets that turn heaters ON/OFF based on time of day and desired temperature range. 

##### Materials

To accomplish this we need:

- 4 500W heaters (2 per high temperature tank, [max amp draw from energy bar (EB)](https://forum.neptunesystems.com/showthread.php?20-Read-this-first-Energy-Bars-and-outlets) is 15Amps, and 7Amps per outlet)
- 1 Apex energy bar
- 1 Apex EL (controller/brain)
- 3 Apex PM1/2 modules
- 4 Apex temperature probes

##### 	Acronyms & Definitions

- Energy Bar - EB

- Probe Module 1/2 - PM
- Virtual Outlets - VOs

### 7-AUG-2022

#### Intro to Apex

Before unboxing the Apex, I watched [this intro video](https://www.youtube.com/watch?v=zJrIb41ZFIU) to setting up the Apex system.

I started by unboxing the Apex EL brain, energy bar (EB), 4 PM1 modules (PM), and 4 temperature probes!

I then opened my Chrome browser and navigated to the Apex 'Get Started' guide https://www.neptunesystems.com/getstarted/apexel/ for the Apex EL, and followed the guide using options for WiFi and my Android smartphone. 

During the initial setup I downloaded the Apex Fusion app on my phone, and made an account that I can access/login to from my phone app or on the [Apex Fusion](https://apexfusion.com/apex) web account. 

Once through the initial setup, the brain and energy bar both had solid orange lights. The solid orange light indicates

#### Link up PMs

Then I referenced Ariana Huffmyer and Jill Ashey's GitHub posts from [10JUN22](https://github.com/urol-e5/urol-e5.github.io/blob/master/_posts/2022-06-10-Daily-Fieldwork-Hawaii.md) and [11JUN22](https://github.com/urol-e5/urol-e5.github.io/blob/master/_posts/2022-06-11-Daily-Fieldwork-Hawaii.md) which shared the following:

- Using aquabus cables *(USB-A to USB-A)*, connect EB to first PM. Check that PM light is green once connected
- Click refresh on Apex Fusion page. The new PM should now show up as active
- Link another PM to the first PM using another aquabus cable and check that it is active online. Repeat this process for each PM, adding them one at a time and daisy-chaining them to one another

I completed three PM additions successfully, and connected one temp probe to each PM, making three temp probes visible in my dashboard. However the fourth PM continued to flash orange and did not establish a connection with the brain, and did not turn a solid green. I left the setup plugged in overnight, to see if the PM would establish a connection on its own. 

### 8-AUG-2022

The Apex unit disconnected from the network WiFi multiple times overnight. I returned to the HIMB wetlab and found that the fourth PM was still flashing yellow, and the Apex unit was not connecting to WiFi. In the Apex troubleshooting guide it indicated I needed to reboot the Apex to reconnect it to WiFi. This [YouTube video](https://www.youtube.com/watch?v=LYUs25OiKZg&t=52s) shows you how to use a small pin to press the reboot pinhole on the brain for 10 seconds, and release once the light turns blue. After rebooting and waiting a few minutes, the Apex reconnected to the WiFi and showed up on my Apex Fusion app again. I then updated the AOS Version to 5.10 8A22 (latest as of 08AUG2022). 

I made a small attempt at troubleshooting the PM that was flashing yellow, but in the interest of time I disconnected the PM that wasn't working, and moved the 4th temp probe to the temp port on the brain. 

#### Name PMs &  Temp Probes

From Ariana Huffmyer and Jill Ashey's post on [11JUN22](https://github.com/urol-e5/urol-e5.github.io/blob/master/_posts/2022-06-11-Daily-Fieldwork-Hawaii.md) : "When the PMs appear on fusion, they will have names/numbers. Record these so it is known which PM is associated with which probe/treatment (EB only has 8 outlets so can only handle 8 PMs. If more PMs are needed, add another EB)."

Between the brain and 3 PM's I can control 4 temp probes, the names and tank treatments I assigned them to are as follows:

- HIGH-1 : Brain, TMP

- HIGH-2 : PM1_3, TMPX3

- AMBIENT-1: PM1_4, TMPX4

- AMBIENT-2: PM1_5, TMPX5

#### Intro to Virtual Outlets (VO)

I first watched this [neptune systems youtube video](https://www.youtube.com/watch?v=xCx0qiKzu44) on how to add virtual outlets.

You can add virtual outlets by clicking on the icon shaped like an outlet, and then clicking the gear and "+ Virtual Output" option. 

I added 16 VOs named:

- vo-high1-1
- vo-high1-2
- vo-high1-3
- vo-high1-4
- vo-high1-5
- vo-high1-6
- vo-high1-7
- vo-high1-8
- vo-high2-1
- vo-high2-2
- vo-high2-3
- vo-high2-4
- vo-high2-5
- vo-high2-6
- vo-high2-7

For each VO, I originally copied code from Ariana Huffmeyer's post [11JUN22](https://github.com/urol-e5/urol-e5.github.io/blob/master/_posts/2022-06-11-Daily-Fieldwork-Hawaii.md) and pasted it to the configuration for each VO. However I later edited the code, and finalized it on 12-AUG-2022 *(see this in [final code section for virtual outlets!](####virtual-outlets))

**Once I added the virtual outlets, I went back to the dashboard, clicked the lock icon, and dragged the newly made virtual outlet tiles into my dashboard.**

#### Program (Real!) Outlets

I copied the following code to the configuration for outlet_1 and outlet_2, where I will have heaters going into tub HIGH-1 with temp probe HIGH-1

```
Fallback OFF
Set OFF 
If Outlet vo-high1-1 = ON Then ON 
If Outlet vo-high1-2 = ON Then ON 
If Outlet vo-high1-3 = ON Then ON 
If Outlet vo-high1-4 = ON Then ON 
If Outlet vo-high1-5 = ON Then ON 
If Outlet vo-high1-6 = ON Then ON 
If Outlet vo-high1-7 = ON Then ON 
If Outlet vo-high1-8 = ON Then ON
```

Similarly, I put this code in configuration for outlet_3 and outlet_4, where I will have heaters running to tub HIGH-2, controlled through these virtual outlets through temp probe HIGH-2

```
Fallback OFF
Set OFF 
If Outlet vo-high2-1 = ON Then ON 
If Outlet vo-high2-2 = ON Then ON 
If Outlet vo-high2-3 = ON Then ON 
If Outlet vo-high2-4 = ON Then ON 
If Outlet vo-high2-5 = ON Then ON 
If Outlet vo-high2-6 = ON Then ON 
If Outlet vo-high2-7 = ON Then ON 
If Outlet vo-high2-8 = ON Then ON
```

### 09-AUG-2022

#### Troubleshooting

### 12-AUG-2022

I received the new Apex EL brain! It was delivered around 3pm, I walked from HIMB back to the AirBnB, collected the package, made a quesadilla and a cup of coffee and returned to HIMB by 1630. 



I wanted to make sure I was setting the temperature regime to as close to +2$\degree$C above ambient temperature as possible, so I used a HOBO Pendant MX Temp/Light logger attached to the bottom of a floating 20mL vial to track tank temperature from 03-AUG-2022 to 12-AUG-2022. I then found average temperatures by hour of the day across all 10 days of logging. To break 24 hours up into 8 time-steps, I just had to group the timesteps into 3-hour blocks. I averaged the hourly temps in each 3-hour block, and added 2$\degree$C to get the following:

- 0000 - 0259 : 29.7$\degree$C
- 0300 - 0559 : 29.6$\degree$C
- 0600 - 0859 : 29.5$\degree$C
- 0900 - 1159 : 29.8$\degree$C
- 1200 - 1459 : 30.6$\degree$C
- 1500 - 1759 : 30.3$\degree$C
- 1800 - 2059 : 29.9$\degree$C
- 2100 - 2359 : 29.8$\degree$C

I therefore modified the code I copied from Ariana Huffmyer and Jill Ashey to reflect the desired temperature regime *(see this in [final code section for virtual outlets!](####virtual-outlets))

#### Connecting the new Apex EL

I opened my Apex Fusion app on my Android phone, and clicked the link icon on the Apex List main page.

I named the new Apex 'himb-2hot-2amb'.

!!IMPORTANT!! **When prompted with "How should Apex connect to the internet?" I selected 'Ethernet' and plugged in the ethernet cable.** 

I updated the clock setting by expanding the gear icon, and then clicking the clock icon. Under Setup I selected Time Zone UTC -10, with daylight savings disabled and auto clock set enabled.

I expanded the gear icon, and the wrench icon, then changed the data log to every 1 minute. 

Graphs not yet populating with data.

Rebooting Apex.

I can see temp values changing, but no graph populating yet.

I navigated to https://apexfusion.com/apex to begin naming probes, adjusting the dashboard, adding virtual outlets, and coding outlet temperature regime.

#### Rename Temp Probes

I named the temp probes the following:

- HIGH-1 : Temperature Probe on the Apex Base Unit.

- HIGH-2 : Temperature Probe on the Probe Module 1 named PM1_2 at Aquabus address 2.

- AMB-1 : Temperature Probe on the Probe Module 1 named PM1_4 at Aquabus address 4.

- AMB-2 : Temperature Probe on the Probe Module 1 named PM1_3 at Aquabus address 3.

*temp values still not populating graph ... getting nervous*

#### Virtual Outlets

> You can add virtual outlets by clicking on the icon shaped like an outlet, and then clicking the gear and "+ Virtual Output" option. 
>
> I added 16 virtual outlets named:
>
> vo-high1-1 ...8
>
> vo-high2-1 ...8
>
> For each virtual outlet I set:
>
> ​	Icon : Up/Down Arrows
>
> ​	Control Type : Advanced
>
> ​	Log : enabled (check box)
>
> And I copied the following code into each respective virtual outlet's configuration:

#### HIGH 1 BLUE TUB HEATERS *final code!*

vo-high1-1: hold temp at 29.7 $\degree$C ON from 00:00 to 02:59, OFF from 03:00 to 23:59

```
Set OFF
If HIGH-1 < 29.7 Then ON
If HIGH-1 > 29.7 Then OFF
If Time 03:00 to 23:59 Then OFF
```

vo-high1-2: hold temp at 29.6 $\degree$C ON from 03:00 - 05:59, OFF from 06:00 - 02:59

```
Set OFF
If HIGH-1 < 29.6 Then ON
If HIGH-1 > 29.6 Then OFF
If Time 06:00 to 02:59 Then OFF
```

vo-high1-3: hold temp at 29.5 $\degree$C ON from 06:00 - 08:59, OFF from 09:00 - 05:59

```
Set OFF
If HIGH-1 < 29.5 Then ON
If HIGH-1 > 29.5 Then OFF
If Time 09:00 to 05:59 Then OFF
```

vo-high1-4: hold temp at 29.8 $\degree$C ON from 09:00 - 11:59, OFF from 12:00 - 08:59

```
Set OFF
If HIGH-1 < 29.8 Then ON
If HIGH-1 > 29.8 Then OFF
If Time 12:00 to 08:59 Then OFF
```

vo-high1-5: hold temp at 30.6$\degree$C ON from 12:00 - 14:59, OFF from 15:00 - 11:59

```
Set OFF
If HIGH-1 < 30.6 Then ON
If HIGH-1 > 30.6 Then OFF
If Time 15:00 to 11:59 Then OFF
```

vo-high1-6: hold temp at 30.3$\degree$C ON from 15:00 - 17:59, OFF from 18:00 - 14:59

```
Set OFF
If HIGH-1 < 30.3 Then ON
If HIGH-1 > 30.3 Then OFF
If Time 18:00 to 14:59 Then OFF
```

vo-high1-7: hold temp at 29.9$\degree$C ON from 18:00 - 20:59, OFF from 21:00 - 17:59

```
Set OFF
If HIGH-1 < 29.9 Then ON
If HIGH-1 > 29.9 Then OFF
If Time 21:00 to 17:59 Then OFF
```

vo-high1-8: hold temp at 29.8$\degree$C ON from 21:00 - 23:59, OFF from 00:00 - 20:59

```
Set OFF
If HIGH-1 < 29.8 Then ON
If HIGH-1 > 29.8 Then OFF
If Time 00:00 to 20:59 Then OFF
```



#### HIGH 2 BLUE TUB HEATERS *final code!*

vo-high2-1: hold temp at 29.7 $\degree$C ON from 00:00 to 02:59, OFF from 03:00 to 23:59

```
Set OFF
If HIGH-2 < 29.7 Then ON
If HIGH-2 > 29.7 Then OFF
If Time 03:00 to 23:59 Then OFF
```

vo-high2-2: hold temp at 29.6 $\degree$C ON from 03:00 - 05:59, OFF from 06:00 - 02:59

```
Set OFF
If HIGH-2 < 29.6 Then ON
If HIGH-2 > 29.6 Then OFF
If Time 06:00 to 02:59 Then OFF
```

vo-high2-3: hold temp at 29.5 $\degree$C ON from 06:00 - 08:59, OFF from 09:00 - 05:59

```
Set OFF
If HIGH-2 < 29.5 Then ON
If HIGH-2 > 29.5 Then OFF
If Time 09:00 to 05:59 Then OFF
```

vo-high2-4: hold temp at 29.8 $\degree$C ON from 09:00 - 11:59, OFF from 12:00 - 08:59

```
Set OFF
If HIGH-2 < 29.8 Then ON
If HIGH-2 > 29.8 Then OFF
If Time 12:00 to 08:59 Then OFF
```

vo-high2-5: hold temp at 30.6$\degree$C ON from 12:00 - 14:59, OFF from 15:00 - 11:59

```
Set OFF
If HIGH-2 < 30.6 Then ON
If HIGH-2 > 30.6 Then OFF
If Time 15:00 to 11:59 Then OFF
```

vo-high2-6: hold temp at 30.3$\degree$C ON from 15:00 - 17:59, OFF from 18:00 - 14:59

```
Set OFF
If HIGH-2 < 30.3 Then ON
If HIGH-2 > 30.3 Then OFF
If Time 18:00 to 14:59 Then OFF
```

vo-high2-7: hold temp at 29.9$\degree$C ON from 18:00 - 20:59, OFF from 21:00 - 17:59

```
Set OFF
If HIGH-2 < 29.9 Then ON
If HIGH-2 > 29.9 Then OFF
If Time 21:00 to 17:59 Then OFF
```

vo-high2-8: hold temp at 29.8$\degree$C ON from 21:00 - 23:59, OFF from 00:00 - 20:59

```
Set OFF
If HIGH-2 < 29.8 Then ON
If HIGH-2 > 29.8 Then OFF
If Time 00:00 to 20:59 Then OFF
```



#### Program (Real!) Outlets ... round 2

Navigate to the outlet icon, and filter by Type. You should see 8 outlets! They will have pre-set names, stuff like 'Heater_5_4' and 'Light_2_3', Click on them and you will see the outlet number in the detail. I went ahead and renamed them as outlet_1 thru outlet_8 (after their outlet number).

For outlets 5 thru 8, I changed the icon to  Left/Right Arrow, Control Type to Advanced, and checked the Log to enable. I pasted "Fallback OFF" as the only line of code in the configuration.

For outlets 1 thru 4, I changed the icon to Left/Right Arrow, Control Type to Advanced, and checked the Log to enable. 

I copied the [same code I used previously](####program-(real!)-outlets) into the outlet configuration windows for outlets 1, 2, 3, & 4.

**I then pulled outlets 1 thru 4 down into my dashboard using the lock icon to open dashboard tiles**

> I made sure all outlets and virtual outlets are set to 'Auto'
>
> *graphs still not populating! Forums say wait up to 24hrs!?*
>
> I checked that I could manually turn outlets on and off, all seems to be working well!
>
> Updated to latest operating system, from 5.06 to 5.10
>
> **Updated clock settings, disabled DST**, rebooted
>
> Updated module software (from version 7 to ... version 7? Ok so they give you an option to update even when there is no update to install... weird)
>
> 20:43, **leaving unit plugged in to lab power and ethernet**.. hoping to see graphs tomorrow morning
>
> 20:50 graphs! eureka! Can go to sleep happy now :D

### 14-AUG-2022

Calibrated all temp probes together by averaging two digital thermometers.

Moved the entire setup from indoor ethernet connection to outdoor WiFi connection by first unplugging the EB from power, and unplugging the ethernet!

Moved unit outside, and plugged in EB to extension cord. The apex EB color turned orange, the apex brain ran through purple and green and ended on blue, indicating that it is looking for a network.

I then opened my phone, and connected my phone to the 'ApexSetup' network. Once connected to ApexSetup network on my phone, I opened the ApexFusion app on my phone, where I was prompted with a note to 'fix apex WiFi', I followed the in-app prompts, connecting the Apex to the network by manually entering the WiFi network name and password. The app loaded through a "Connecting to Apex" phase, and then a "Linking to Fusion" phase before we were all setup and able to load the dashboard!

I then placed two heaters in each of the high treatment tubs

With all 4 500W heaters ON, I do get a high Amp and high Volt warning... The draw on the entire EB should be less than 15 Amps and less than 120 Volts.  I get the warning at 14 Amps, and 110 Volts, there are no other potential energy draws from the outlet, so I know it won't spike above the maximum amperage and volts allowed. 



