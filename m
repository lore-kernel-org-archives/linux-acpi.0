From: Emma Jane Hogbin <emmajane-MHIYrZpDPrNWk0Htik3J/w@public.gmane.org>
Subject: 2.6.6 + AcerTravelMate634 suspend
Date: Wed, 26 May 2004 21:34:36 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040527013436.GA2559@smeagol>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi everyone,

I just thought I'd let everyone know how my system behaves with the
various suspend options:
	echo -n "standby" > /sys/power/state  
		back light stays on in X
		does nothing from the console
		
	echo -n "mem" > /sys/power/state  
		system "goes away", no back light, "Zz" light goes on
		Fn-F4 should work to put the computer into this state but it just
		beeps and does nothing
		can't restore (tried the power button, Fn-F4, moving the mouse, etc)
		have to force power off with the power button and then force restart

(more at the bottom)
NB: I have to stop mysqld by hand. (Yes, I run a database on my laptop for
testing purposes--I'm a web developer by day.)

May 26 19:34:49 smeagol kernel: Stopping tasks: ====================================================
=================
May 26 19:34:49 smeagol kernel:  stopping tasks failed (1 tasks remaining)
May 26 19:34:49 smeagol kernel: Restarting tasks...<6> Strange, mysqld not stopped
May 26 19:34:50 smeagol kernel:  done
May 26 19:34:50 smeagol udev[3195]: creating device node '/dev/vcs63'
May 26 19:34:50 smeagol udev[3265]: removing device node '/dev/vcs63'
May 26 19:34:55 smeagol udev[3274]: removing device node '/dev/vcsa63'
May 26 19:35:00 smeagol udev[3280]: removing device node '/dev/vcs63'
May 26 19:35:05 smeagol udev[3284]: removing device node '/dev/vcsa63'
May 26 19:35:10 smeagol udev[3310]: removing device node '/dev/vcs63'
May 26 19:35:15 smeagol udev[3314]: removing device node '/dev/vcsa63'
May 26 19:35:18 smeagol kernel: PM: Preparing system for suspend
May 26 19:35:19 smeagol kernel: Stopping tasks: ====================================================
============|
May 26 19:35:19 smeagol kernel: Restarting tasks... done
May 26 19:35:20 smeagol udev[3318]: removing device node '/dev/vcs63'
May 26 19:35:25 smeagol udev[3322]: removing device node '/dev/vcsa63'
May 26 19:35:30 smeagol udev[3326]: removing device node '/dev/vcs63'
May 26 19:35:35 smeagol udev[3329]: removing device node '/dev/vcsa63'
May 26 19:46:53 smeagol syslogd 1.4.1#10: restart.
May 26 19:46:53 smeagol kernel: klogd 1.4.1#10, log source = /proc/kmsg
started.
May 26 19:46:53 smeagol kernel: Inspecting /boot/System.map-2.6.6.gimli
May 26 19:46:54 smeagol udev[1498]: creating device node '/dev/vcs1'
May 26 19:46:54 smeagol udev[1594]: removing device node '/dev/vcs1'
May 26 19:46:54 smeagol udev[1505]: creating device node '/dev/vcsa1'
May 26 19:46:54 smeagol udev[1600]: removing device node '/dev/vcsa1'
May 26 19:46:54 smeagol kernel: Loaded 30706 symbols from
/boot/System.map-2.6.6.gimli.
May 26 19:46:54 smeagol kernel: Symbols match kernel version 2.6.6.


	echo -n "disk" > /sys/power/state 
	system shuts off. No "Zz" light. When I use the power button to turn
	the system back on it says that it was not shut down properly.


REMINDER: when I try to use poweroff and halt the computer does not power
off when acpi_power_off is called at the very end.

emma

-- 
Emma Jane Hogbin
[[ 416 417 2868 ][ www.xtrinsic.com ]]


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
