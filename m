From: Rob Miller <rob-7HoZ3oJp7ZtBDgjK7y7TUQ@public.gmane.org>
Subject: ACPI - SWSUSP interaction
Date: Wed, 7 May 2003 15:33:36 +0100 (WAT)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.21.0305071429500.7835-100000@vista.rtm.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Hi,

I am a happy user of both the ACPI and SWSUSP patches; I'm currently still
on acpi-20030328 applied to 2.4.21-rc1 as the latest SWSUSP patch
(19-27) isn't playing well for me with acpi-20030424.

In any event, I think there is an issue that one or more folk here may be
able to help with.  It appears to me that reads of at least the following
/proc entries do not actually test the hardware state, but rely on
detecting ACPI events to trigger changes in stored information:

/proc/acpi/ac_adapter/ADP1/state
/proc/acpi/battery/BAT1/state: capacity state, charging state

I base this on observing that these entries do not change to reflect
removal/insertion of the AC plug on my Toshiba Satellite 5100 laptop
during a suspend.  This caused minor but not insurmountable problems for
writing a battery monitoring daemon which hibernates the machine when the
battery goes too low, as it was difficult to determine when powering back
on that there was no need to immediately hibernate again.

I find these results with the ACPI code compiled-in and as modules.  When
built as modules, on loading during or after the resume without an
additional plug-change they report the wrong state -- e.g.:

ACPI: AC Adapter [ADP1] (off-line)

rmmod - plug - modprobe of ac.o while powered on of course gets the right
state, but I expect this is because the in-kernel ACPI code is running and
gets the ACPI event.

Question 1:  Is my conclusion above accurate, or have I run into an
idiosyncrasy of the laptop?  Certainly it gets the correct reading if I
shutdown - plug in - boot the device.

Question 2:  if it is the case that these /proc entries are only updated
on specific ACPI events, can I 
 (a) get the world changed such that reads of the /proc entries cause
    an actual re-read of the hardware status?
 (b) get the world changed so that the hardware status is re-read on 
    loading the ACPI modules?
 (c) simulate (an) ACPI event(s) in software to cause the hardware status 
    to be re-read?
 (d) implement another solution I haven't thought of yet?

Thanks for any suggestions.

best,

rob.






-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
