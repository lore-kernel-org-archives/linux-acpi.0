From: Nigel Cunningham <ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org>
Subject: Re: wrong system time after wakeup
Date: Tue, 11 Jan 2005 07:44:38 +1100
Message-ID: <1105389878.2941.10.camel@desktop.cunninghams>
References: <Pine.LNX.4.58.0501102008270.22897@gaston.free.fr>
Reply-To: ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.58.0501102008270.22897-iBKnCo7tEuSksujEA26zIQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Peter =?ISO-8859-1?Q?M=FCnster?= <pmlists-GANU6spQydw@public.gmane.org>
Cc: ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Peter.

That attached little patch will fix your issue.

Regards,

Nigel

diff -ruNp 910-original-time-patch-old/arch/i386/kernel/time.c 910-origin=
al-time-patch-new/arch/i386/kernel/time.c
--- 910-original-time-patch-old/arch/i386/kernel/time.c	2004-12-27 10:03:=
24.000000000 +1100
+++ 910-original-time-patch-new/arch/i386/kernel/time.c	2005-01-08 10:23:=
28.335811408 +1100
@@ -343,12 +343,13 @@ static int timer_resume(struct sys_devic
 		hpet_reenable();
 #endif
 	sec =3D get_cmos_time() + clock_cmos_diff;
-	sleep_length =3D get_cmos_time() - sleep_start;
+	sleep_length =3D (get_cmos_time() - sleep_start) * HZ;
 	write_seqlock_irqsave(&xtime_lock, flags);
 	xtime.tv_sec =3D sec;
 	xtime.tv_nsec =3D 0;
 	write_sequnlock_irqrestore(&xtime_lock, flags);
-	jiffies +=3D sleep_length * HZ;
+	jiffies +=3D sleep_length;
+	wall_jiffies +=3D sleep_length;
 	return 0;
 }
=20


On Tue, 2005-01-11 at 06:39, Peter M=FCnster wrote:
> Hello,
> when resuming from S1, the system-time is completely wrong: about 22h
> instead of 11h.
> The system goes to sleep the day before at about 22h30 with the followi=
ng
> commands:
> modprobe genrtc
> sleep 5
> echo 2005-01-11 11:10:00 >/proc/acpi/alarm
> sleep 5
> echo 1 >/proc/acpi/sleep
>=20
> What could be wrong?
> I'm using Linux-2.6.10 and ASUS A7N8X-X ACPI BIOS Rev 1006.
>=20
> Thanks in advance for any help! Please tell me, if you need more inform=
ation.
> Kind regards, Peter
--=20
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com

Ph: +61 (2) 6292 8028      Mob: +61 (417) 100 574



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
