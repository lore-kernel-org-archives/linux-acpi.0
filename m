From: Sanjoy Mahajan <sanjoy-Bhlo64W4KxTQzY9nttDBhA@public.gmane.org>
Subject: (fwd) [Bug 4930] New: temperatures not updated until 'acpi' client is run
Date: Sat, 23 Jul 2005 02:09:01 +0100
Message-ID: <E1Dw8Vh-00011o-00@skye.ra.phy.cam.ac.uk>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

I just submitted a few reports to the acpi bugzilla, which I'm going
to forward to acpi-devel.  Apologies if forwarding the submissions is
inappropriate for this list.

-Sanjoy

------- Forwarded Message

Date:    Fri, 22 Jul 2005 15:40:27 -0700
From:    bugme-daemon-ztI5WcYan/vQLgFONoPN62D2FQJk+8+b@public.gmane.org
To:      sanjoy-Bhlo64W4KxTQzY9nttDBhA@public.gmane.org
Subject: [Bug 4930] New: temperatures not updated until 'acpi' client is run

http://bugzilla.kernel.org/show_bug.cgi?id=4930

           Summary: temperatures not updated until 'acpi' client is run
    Kernel Version: 2.6.13-rc3
            Status: NEW
          Severity: normal
             Owner: acpi_power-thermal-ztI5WcYan/vQLgFONoPN62D2FQJk+8+b@public.gmane.org
         Submitter: sanjoy-Bhlo64W4KxTQzY9nttDBhA@public.gmane.org


Distribution: Debian testing ('etch')
Hardware Environment: TP 600X Pentium III 650 MHz, 576 MB
Software Environment: Fixed DSDT attached in Bug #4926

Problem Description: The temperature in thermal zone 2 (disk?) isn't updated
automatically even though polling_frequency is set to 10.  It is updated when I
run the command-line 'acpi' program, though I often have to run it twice.

Steps to reproduce:
I set the trip-point for THM2 to 48 C and the polling frequency to 10:

echo 120:0:40:48:0 > THM2/trip_points
echo 10 > THM2/polling_frequency

Then I ran a process (reindexing the huge wwwoffle cache) that ran the disk a
lot and drove the temperature over 48 C.  The fan was on (with a bit of proddin
g
from acpi -t).  Eventually the process finished and the fan stayed on.  A few
minutes after it was done I could feel the air coming out was reasonably cool. 
So I checked the temperature by catting the state files:

/proc/acpi/thermal_zone/THM2# cat temperature trip_points polling_frequency 
temperature:             49 C
critical (S5):           120 C
active[0]:               48 C: devices=0xc1575108
polling frequency:       10 seconds

It was plenty of time for the 10-second polling to have updated the temperature
.
 But I didn't believe the 49 C so I ran acpi -t twice right away:

sanjoy:/proc/acpi/thermal_zone/THM2# acpi -t
     Battery 1: charged, 99%
     Battery 2: charged, 99%
     Thermal 1: ok, 43.0 degrees C
     Thermal 2: active[0], 49.0 degrees C
     Thermal 3: ok, 35.0 degrees C
     Thermal 4: ok, 38.0 degrees C
sanjoy:/proc/acpi/thermal_zone/THM2# acpi -t
     Battery 1: charged, 99%
     Battery 2: charged, 99%
     Thermal 1: ok, 43.0 degrees C
     Thermal 2: ok, 40.0 degrees C
     Thermal 3: ok, 35.0 degrees C
     Thermal 4: ok, 37.0 degrees C

And voila the second acpi produces 40 C for the temperature, which felt about
right.  And the fan stopped (right before I ran the second acpi).

This lack-of-update problem was there in 2.6.11.4 as well, and perhaps even wor
se. 

I'm using acpi v0.09 (Debian package), and its the stock 2.6.13-rc3.  Am happy
to try patches and/or turn on acpi debugging output.

- ------- You are receiving this mail because: -------
You reported the bug, or are watching the reporter.

------- End of Forwarded Message



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
