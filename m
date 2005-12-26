From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: /proc/acpi/alarm -- does it work or not?
Date: Mon, 26 Dec 2005 21:43:05 +0100
Message-ID: <20051226204305.GA2028@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ronald.mythtv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

I wanted to write some documentation about /proc/acpi/alarm, but
failed to make it work. I was putting machine to suspend-to-ram and
enabled everything in /proc/acpi/wakeup, still it would not do
anything. I even went to bios (thinkpad x32), set "RTC alarm" to
enabled and set time there. Nothing interesting
happened. /proc/acpi/alarm could not see most of my changes done in
BIOS, it only cleared century or something like that.

I checked that RTC readout in BIOS shows same thing as system timer.

Here are my attempts: [Commands were typed one-after-another where it
makes sense, and I left machine suspended for long enough -- timer
should have expired]

root@amd:/proc/acpi# cat alarm
2005-12-00 01:03:24
root@amd:/proc/acpi# echo '0-0-0 22:35:00' > alarm
root@amd:/proc/acpi# cat alarm
0005-12-00 22:35:00
root@amd:/proc/acpi# s2ram
Freezing cpus ...
Stopping tasks: ====================================|
ACPI: PCI interrupt for device 0000:02:01.0 disabled
ACPI: PCI interrupt for device 0000:02:00.1 disabled
ACPI: PCI interrupt for device 0000:02:00.0 disabled
radeonfb (0000:01:00.0): suspending to state: 2...
radeonfb (0000:01:00.0): resuming from state: 2...to 64er 10 Dec 2004
Restarting tasks... done
Thawing cpus ...
root@amd:/proc/acpi# date
Sun Dec 25 22:36:46 CET 2005
root@amd:/proc/acpi# cat alarm
0005-12-00 22:35:00
root@amd:/proc/acpi#

root@amd:/proc/acpi# cat alarm
0005-12-00 22:35:00
root@amd:/proc/acpi# echo '*-*-* 22:40:00' > alarm
root@amd:/proc/acpi# cat alarm
0005-12-00 22:35:00
root@amd:/proc/acpi# echo '2005-12-25 22:40:00' > alarm
root@amd:/proc/acpi# cat alarm
2005-12-25 22:40:00
root@amd:/proc/acpi# date
Sun Dec 25 22:37:53 CET 2005
root@amd:/proc/acpi# s2ram
Freezing cpus ...
Stopping tasks: =====================================|
ACPI: PCI interrupt for device 0000:02:01.0 disabled
ACPI: PCI interrupt for device 0000:02:00.1 disabled
ACPI: PCI interrupt for device 0000:02:00.0 disabled
radeonfb (0000:01:00.0): suspending to state: 2...
radeonfb (0000:01:00.0): resuming from state: 2...to 64er 10 Dec 2004
Restarting tasks... done
Thawing cpus ...
root@amd:/proc/acpi# date
Sun Dec 25 22:41:14 CET 2005
root@amd:/proc/acpi#

...so... what am I doing wrong? Is thinkpad x32 machine where it does
not work?
								Pavel

-- 
Thanks, Sharp!


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
