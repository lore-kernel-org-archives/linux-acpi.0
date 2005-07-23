From: Sanjoy Mahajan <sanjoy-Bhlo64W4KxTQzY9nttDBhA@public.gmane.org>
Subject: (fwd) [Bug 4928] New: S1 standby produces bizarre patterns on the screen
Date: Sat, 23 Jul 2005 02:12:09 +0100
Message-ID: <E1Dw8Yj-00012l-00@skye.ra.phy.cam.ac.uk>
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

The fixed DSDT I use with my TP 600X is attached to Bug #4926.

-Sanjoy

Date:    Fri, 22 Jul 2005 13:28:36 -0700
From:    bugme-daemon-ztI5WcYan/vQLgFONoPN62D2FQJk+8+b@public.gmane.org
Subject: [Bug 4928] New: S1 standby produces bizarre patterns on the screen

http://bugzilla.kernel.org/show_bug.cgi?id=4928

           Summary: S1 standby produces bizarre patterns on the screen
    Kernel Version: 2.6.13-rc3
            Status: NEW
          Severity: normal
             Owner: acpi_power-sleep-wake-ztI5WcYan/vQLgFONoPN62D2FQJk+8+b@public.gmane.org
         Submitter: sanjoy-Bhlo64W4KxTQzY9nttDBhA@public.gmane.org


Distribution: Debian testing ('etch')
Hardware Environment: Thinkpad 600X, Pentium III 650 MHz, 576 MB
Software Environment: Fixed DSDT from Bug #4926

Problem Description: S1 ('standby') produces growing color patterns on the
screen.  They start out as a thin horizontal band across the middle of the
screen, and then more lines and dots develop.

Steps to reproduce: 
Boot into X, then
  echo standby > /sys/power/state
The colored patterns grow on the screen.  Then press the shift key to wake it u
p
 and it eventually returns, and works fine.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
