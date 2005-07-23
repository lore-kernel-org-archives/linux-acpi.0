From: Sanjoy Mahajan <sanjoy-Bhlo64W4KxTQzY9nttDBhA@public.gmane.org>
Subject: (fwd) [Bug 4926] New: no wakeup after S3 sleep with Thinkpad 600X
Date: Sat, 23 Jul 2005 02:10:52 +0100
Message-ID: <E1Dw8XU-00012O-00@skye.ra.phy.cam.ac.uk>
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

Date:    Fri, 22 Jul 2005 12:45:23 -0700
From:    bugme-daemon-ztI5WcYan/vQLgFONoPN62D2FQJk+8+b@public.gmane.org
Subject: [Bug 4926] New: no wakeup after S3 sleep with Thinkpad 600X

http://bugzilla.kernel.org/show_bug.cgi?id=4926

           Summary: no wakeup after S3 sleep with Thinkpad 600X
    Kernel Version: 2.6.13-rc3
            Status: NEW
          Severity: high
             Owner: acpi_power-sleep-wake-ztI5WcYan/vQLgFONoPN62D2FQJk+8+b@public.gmane.org
         Submitter: sanjoy-Bhlo64W4KxTQzY9nttDBhA@public.gmane.org


Distribution: Debian testing (etch)

Hardware Environment: Thinkpad 600X, Pentium III 650 MHz, 576MB memory

Software Environment: using my hacked DSDT mentioned in Bug #3534 (will attach
in next msg) that allowed S3 to work with 2.6.11.4.  It's the IBM DSDT with the
compile errors fixed, though some of my fixes may not be right (but they got S3
working)!

Problem Description: After going to sleep with 'echo mem > /sys/power/state',
the system displays 'stopping tasks' and then goes to sleep mostly fine (the
suspend light goes on, although the disk drive light also goes on even though
the disk is quiet).  With 2.6.11.4, it would wake up either upon opening the li
d
or pressing the 'Fn' key.  With 2.6.13-rc3, nothing wakes it up.  Holding the
power switch for several seconds turns the machine off, but to turn it back on 
I
have to remove the AC cord and the main and spare batteries, then power it back
on.  Otherwise it just ignores the power on.

Steps to reproduce:

Boot into multi-user mode (which gets all the ACPI modules loaded), then 

   echo mem > /sys/power/state

------- End of Forwarded Message

And the correction I submitted:

------- Additional Comments From sanjoy-Bhlo64W4KxTQzY9nttDBhA@public.gmane.org  2005-07-22 16:40 ------
-
Correction: The disk light goes on only after I try to wake it up
(e.g. by pressing the Fn key).  The screen flashes briefly, the disk
light turns on (though the disk doesn't spin), then the screen goes
blank and nothing happens.  In order to reboot, I have to fully power
cycle by removing the batteries and AC cord.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
