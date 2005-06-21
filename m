From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: /proc/acpi/alarm miscalculations and RTC century corruption
Date: Tue, 21 Jun 2005 10:07:41 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD30575025A17EF@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Eran Tromer <acpi2eran-IJe252wrQBYdnm+yROfE0A@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,
>
>As of kernel 2.6.12, acpi_system_write_alarm() in
>drivers/acpi/sleep/proc.c does the following:
>
>        if (acpi_gbl_FADT->day_alrm)
>                CMOS_WRITE(day, acpi_gbl_FADT->day_alrm);
>        if (acpi_gbl_FADT->mon_alrm)
>                CMOS_WRITE(mo, acpi_gbl_FADT->mon_alrm);
>        if (acpi_gbl_FADT->century)
>                CMOS_WRITE(yr/100, acpi_gbl_FADT->century);
>
>The first two are fine, but the third one changes the "current century"
>field of RTC (there is no alarm century field). It definitely shouldn't
>touch that.
>
>This means that writing a reasonable explicit date (e.g., "2005-06-21
>33:33") to /proc/acpi/alarm happens to work fine, but a silly alarm
date
>would corrupt your RTC's century setting. A ThinkPad T21, for example,
>would choke on that and refuse to boot until the date is reset in BIOS.
>
>Worse yet, relative form (e.g., "+0000-00-00 00:30") *always* corrupts
>the RTC century (unless you're in the 0th century), because in the "yr"
>variable above is initialized just from RTC_YEAR, without the century.
>Note that acpi_system_alarm_seq_show() did get that part right.
Century alarm is optional. I didn't find any system which supports
century alarm at hand. Is there any real hardware support it?


>Another potential concern:
>acpi_system_write_alarm() performs the following normalization on its
>input, and then again (when adjust=3D=3D1) after adding the relative =
date
to
>the RTC date:
>
>        if (sec > 59) {
>                min++;
>                sec -=3D 60;
>        }
>        if (min > 59) {
>                hr++;
>                min -=3D 60;
>        }
>        if (hr > 23) {
>                day++;
>                hr -=3D 24;
>        }
>        if (day > 31) {
>                mo++;
>                day -=3D 31;
>        }
>        if (mo > 12) {
>                yr++;
>                mo -=3D 12;
>        }
>
>No further validation is done. Obviously this won't catch some invalid
Yes, we should add more check. Please send a patch to Len.

>dates, but even valid inputs (e.g, RTC "2000-01-31 12:00" and relative
>date "+0000-00-31 12:00") can yield an invalid output ("2000-02-32
>00:00"), and that's before we get to variable month lengths. How safe
is
>it to let this stuff hit the CMOS?
No, the format written to alarm is fixed. It's just an interface and so
it's no reason to let kernel parse the complex string. If you want a
more user friendly interface, please write a tool.

>While at it, there is currently no way to disable the ACPI alarm; at
>most you can set it to a date in the past or in the far future. It
would
>be nice if writing some special value (maybe "" or "off") to
>/proc/acpi/alarm disabled the alarm, by removing RTC_AIE from the
>RTC_CONTROL CMOS field and/or by disabling ACPI_EVENT_RTC.
ACPI alarm is disabled by default. It only enabled if you give it alarm
date. But it is good not enabling it if the alarm date is invalid. In
addition, a 'off' or a special value like '0000-00-00 00:00.00' to
disable alarm makes sense to me.

Thanks,
Shaohua


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
