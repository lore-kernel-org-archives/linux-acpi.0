From: Diego SANTA CRUZ <Diego.SantaCruz-p8DiymsW2f8@public.gmane.org>
Subject: RE: ACPI + Laptop Power Management
Date: Fri, 28 Nov 2003 10:32:57 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1070011976.2409.8.camel@ltspc67.epfl.ch>
References: <C386328088ED7F4E9F81AFBABDDF60DA0338640F@wdmyexch02.my.asia.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <C386328088ED7F4E9F81AFBABDDF60DA0338640F-Yw6hFe9C1vnHQcBQSaPqJq0fmWJ9l57d0E9HWUfgJXw@public.gmane.org>
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

On Fri, 2003-11-28 at 04:21, Ow Mun Heng wrote:

> The thing here is, even though it's flushing the buffers when there are
> others to flush, it makes not difference if the drive is still spinning and
> not in standby-mode! I can't figure out what is making the HD _not_ spin
> down.
> 

Just a thing to check: syslogd will (by default) sync the log file after
each write. If you have a daemon that write syslog messages often then
syslogd will keep your HD active all the time, despite any laptop-mode.

Two, possibly complementary, solutions

1) Find the offending daemon(s) and modify their settings or disable
them if not necessary.

2) Prepend the log file name with a - on the /etc/syslog.conf file. This
prevents the sync on every write default.

If this does not solve your problem you can check (in dmesg) what is
writing to disk by doing

echo -n 1 > /proc/sys/vm/block_dump

But BE CAREFUL!. You have to disable klogd before doing this or you will
likely end up in an infinite loop.

Hope this helps.
-- 
-------------------------------------------------------
Diego Santa Cruz - PhD
Publications available at http://ltswww.epfl.ch/~dsanta
Signal Processing Institute (LTS1 / ITS / STI)
Swiss Federal Institute of Technology (EPFL)
EPFL - STI - ITS, CH-1015 Lausanne, Switzerland
E-mail:     Diego.SantaCruz-p8DiymsW2f8@public.gmane.org
Phone:      +41 - 21 - 693 26 57
Fax:        +41 - 21 - 693 76 00
-------------------------------------------------------



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
