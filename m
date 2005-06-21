From: Eran Tromer <acpi2eran-IJe252wrQBYdnm+yROfE0A@public.gmane.org>
Subject: /proc/acpi/alarm miscalculations and RTC century corruption
Date: Tue, 21 Jun 2005 04:19:12 +0300
Message-ID: <d97pj8$r41$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

Hi,

As of kernel 2.6.12, acpi_system_write_alarm() in
drivers/acpi/sleep/proc.c does the following:

        if (acpi_gbl_FADT->day_alrm)
                CMOS_WRITE(day, acpi_gbl_FADT->day_alrm);
        if (acpi_gbl_FADT->mon_alrm)
                CMOS_WRITE(mo, acpi_gbl_FADT->mon_alrm);
        if (acpi_gbl_FADT->century)
                CMOS_WRITE(yr/100, acpi_gbl_FADT->century);

The first two are fine, but the third one changes the "current century"
field of RTC (there is no alarm century field). It definitely shouldn't
touch that.

This means that writing a reasonable explicit date (e.g., "2005-06-21
33:33") to /proc/acpi/alarm happens to work fine, but a silly alarm date
would corrupt your RTC's century setting. A ThinkPad T21, for example,
would choke on that and refuse to boot until the date is reset in BIOS.

Worse yet, relative form (e.g., "+0000-00-00 00:30") *always* corrupts
the RTC century (unless you're in the 0th century), because in the "yr"
variable above is initialized just from RTC_YEAR, without the century.
Note that acpi_system_alarm_seq_show() did get that part right.


Another potential concern:
acpi_system_write_alarm() performs the following normalization on its
input, and then again (when adjust==1) after adding the relative date to
the RTC date:

        if (sec > 59) {
                min++;
                sec -= 60;
        }
        if (min > 59) {
                hr++;
                min -= 60;
        }
        if (hr > 23) {
                day++;
                hr -= 24;
        }
        if (day > 31) {
                mo++;
                day -= 31;
        }
        if (mo > 12) {
                yr++;
                mo -= 12;
        }

No further validation is done. Obviously this won't catch some invalid
dates, but even valid inputs (e.g, RTC "2000-01-31 12:00" and relative
date "+0000-00-31 12:00") can yield an invalid output ("2000-02-32
00:00"), and that's before we get to variable month lengths. How safe is
it to let this stuff hit the CMOS?


While at it, there is currently no way to disable the ACPI alarm; at
most you can set it to a date in the past or in the far future. It would
be nice if writing some special value (maybe "" or "off") to
/proc/acpi/alarm disabled the alarm, by removing RTC_AIE from the
RTC_CONTROL CMOS field and/or by disabling ACPI_EVENT_RTC.

  Eran



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
