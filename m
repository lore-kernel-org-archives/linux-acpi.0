From: "Li, Shaohua" <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: save/restore sysdev - re:2.6.9 S4: clock not updated after resume
Date: Mon, 25 Oct 2004 14:16:55 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <16A54BF5D6E14E4D916CE26C9AD3057563CCE1@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

>
>> I use with success 'echo disk > /sys/power/state' on my ASUS M6N
(BIOS
>> 0210A), Debian /experimental/, vanilla 2.6.9, XFree86/GNOME, with all
>> the modules installed (i.e, ALSA, bcm5700, ipw2100, USB, radeonfb,
>AGP/DRM).
>>
>> The resume is always ok, even if I suspend from battery or from AC,
>> there're no problem at all. The only remark is that the internal
clock
>> is 'freezed' at the time I suspended the machine and I must re-update
it
>> using the NTP service. This is not so problematic if your machine is
>> always connected to Internet, but as sometimes I work offline, I
should
>> re-update the internal clock by hand.
>
>It is a bug, here's the fix.
>
>
Pavel
>--- clean/arch/i386/kernel/time.c	2004-10-01 00:29:59.000000000
+0200
>+++ linux/arch/i386/kernel/time.c	2004-10-19 15:16:14.000000000
+0200
>@@ -319,7 +319,7 @@
> 	return retval;
> }
>
>-static long clock_cmos_diff;
>+static long clock_cmos_diff, sleep_start;
>
> static int time_suspend(struct sys_device *dev, u32 state)
> {
>@@ -328,6 +328,7 @@
> 	 */
> 	clock_cmos_diff =3D -get_cmos_time();
> 	clock_cmos_diff +=3D get_seconds();
>+	sleep_start =3D get_cmos_time();
> 	return 0;
> }
>
>@@ -335,10 +336,13 @@
> {
> 	unsigned long flags;
> 	unsigned long sec =3D get_cmos_time() + clock_cmos_diff;
>+	unsigned long sleep_length =3D get_cmos_time() - sleep_start;
>+
> 	write_seqlock_irqsave(&xtime_lock, flags);
> 	xtime.tv_sec =3D sec;
> 	xtime.tv_nsec =3D 0;
> 	write_sequnlock_irqrestore(&xtime_lock, flags);
>+	jiffies +=3D sleep_length * HZ;
> 	return 0;
> }
The patch is useless. The sysdev suspend/resume isn't invoked by swsusp,
as Bjorn has mentioned before.
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D109753613422952&w=3D2

Thanks,
Shaohua


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
