From: Jakob Praher <jpraher-LWAfsSFWpa4@public.gmane.org>
Subject: thermal shutdown
Date: Wed, 03 Mar 2004 12:41:58 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1078314118.1889.2.camel@jaques2>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

hi,

my system: 2.6.3 acpi patched

I have noticed, that at some sudden point in time (especially when I am
not working actively ( I mean using input devices )), I receive a
thermal shutdown, because of a (false?) temperature value.

looking under /var/log/kern.log I found  

jaques2:/var/log# cat  kern.log | grep  Critical
Feb 19 16:11:21 jaques2 kernel: Critical temperature reached (123 C),
shutting down.
Feb 19 16:11:22 jaques2 kernel: Critical temperature reached (46 C),
shutting down.
Feb 20 10:47:02 jaques2 kernel: Critical temperature reached (123 C),
shutting down.
Feb 20 10:47:02 jaques2 kernel: Critical temperature reached (44 C),
shutting down.
Mar  2 22:38:27 jaques2 kernel: Critical temperature reached (123 C),
shutting down.
Mar  2 22:38:27 jaques2 kernel: Critical temperature reached (44 C),
shutting do

this temperature always happens to be 123 C.
How is that possible?
I noticed that the acpi_thermal_critical method uses some kind of flag
for enabled disabled, but apparently in any case the shutdown user space
app (/sbin/poweroff) is called.
Should this only be the case when the temperature is too high and the
flag (enabled) is set to != 0? Otherwise, what is the point in the
enabled thing. [tz->trips.critical.flags.enabled]

As you can see from my kern.log, the second value is drastically lower,
so could this be a weekness in the system, that one sporadically high
value can trigger a shutdown?

thanks
-- Jakob




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
