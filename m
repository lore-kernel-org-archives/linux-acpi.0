From: Justin Georgeson <justin_georgeson-/E1597aS9LQAvxtiuMwx3w@public.gmane.org>
Subject: Inspiron 2600 with Ubuntu warty
Date: Sun, 31 Oct 2004 14:39:40 -0800 (PST)
Message-ID: <20041031223940.38540.qmail@web20027.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

I'm running a fully updated install of Ubuntu Warty on a Dell Inspiron
2600. The kernel version is 2.6.8.1. ACPI drivers are loading and seem
to be receiving and handling events. The default configurations from
Ubuntu have the lid event configured to turn off the display when it is
closed and back on when the lid is opened, that works fine. I can enter
S3 by running the command 'echo -n mem > /sys/power/state' and it
appears to suspend successfully. I don't seem to have any way to resume
though. If I hit the power button, the configured action is to power
down, so the laptop resumes and shuts down. I'd like to configure the
lid events to suspend on close and resume on open. I suppose if I could
figure that out, I could configure the powerbtn even to resume if
currently suspended, or shutdown if currently powered up and running.

I was under the impression that the 2.6 kernels had a software suspend
patch included by default. I think Ubuntu's binary kernel packages
disable it though. I'd like to enable it and get it working. In
Windows, I can hit Fn+Esc and it will hibernate, so being able to
enable that in Linux too would be nice.

Last, I'm trying to clean up the DSDT. I got rid of all the errors but
have one warning left

dsdt.dsl  2757:                         Name (PBUF, Buffer (0x14)
Warning  2079 -         Statement is unreachable 

Since it's just a warning, it does compile, but it'd be nice to get a
clean compile of the DSDT.


	
		
__________________________________
Do you Yahoo!?
Yahoo! Mail - You care about security. So do we.
http://promotions.yahoo.com/new_mail


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
