From: Mathieu LESNIAK <maverick-uEz9PMp7chasTnJN9+BGXg@public.gmane.org>
Subject: Re: ACPI issues - suspend-to-ram and processor speed
Date: Thu, 20 May 2004 11:17:27 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <40AC77A7.10704@eskuel.net>
References: <200405180213.34603.andre@eisenbach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200405180213.34603.andre-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andre Eisenbach <andre-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

I confirm what Andre have said : I've got a Presario 2118EA (quite same=20
model with AMD Athlon XP1800). Suspend to ram hav never worked for me.=20
It suspends but cannot resume (2 seconds after the wake up, the laptop=20
shuts down)
I suspected acpid to catch the power button press and tell the laptop to=20
shut down, but after disabling it, no more luck...

Regarding the CPU slowdown, I've seen similar behaviour under Windows. I=20
think it's related to the laptop itself, maybe as Pavel Machek said on=20
LKML, it's the lack of power that force the laptop to run in this mode.

Mathieu LESNIAK

Andre Eisenbach wrote:
> Dear ACPI devel team,
>=20
> I have two issues which prevent me from fully enjoying my notbook runni=
ng on
> Linux. Both are seemingly related to ACPI. Please help me understand th=
e
> problems better and maybe fix them or help me attempting a fix.
>=20
> The notebook in question is a Compaq Presario 2100Z with an AMD Athlon =
XP
> 2400+ processor. Current kernel version is 2.6.6-mm2. I am not applying=
 any
> ACPI patches from sf.net, but rely on whats in the kernel (which may be=
 my
> first mistake).
>=20
> I am very willing to learn and may be able to fix it myself, if you guy=
s can
> help me find out more about which components are involved.
>=20
> Problem 1 - Cannot suspend (or resume better)
>=20
> Right now I am unable to suspend my notebook in any for or fashion (ram=
, disk,
> etc.). Therefore I have to turn off the notebook and boot again, which
> honestly makes the notebook pretty useless.
>=20
> When I try to suspend to RAM, the suspend part seems to run fine (I can=
 see
> suspend-to-ram messages), the lcd shuts off and the power button starts
> pulsing slowly (indicating standby). So far so good. However, if I hit =
the
> power button then to resume, the device seems to want to wake up (hd sp=
ins
> up, fans start) but the LCD never turns on and the notebook quickly (1-=
2
> seconds) later switched to off (all quiet/lights off). Hitting the powe=
r
> button again starts a normal startup.
>=20
> I also tried to suspend to disk using swsusp. That corrupted my swap pa=
rtition
> and didn't resume.
>=20
> What does it take to suspend to RAM?
> What could be broken, and where should I start looking if I want to fix=
 it?
> What more debug information do you guys need?
>=20
> Problem 2 - CPU slows down when on battery
>=20
> When the power cord is unplugged, my CPU slows down quite a bit. This i=
s not
> indicated in /proc/cpuinfo and NOT due to cpufreq / powernow adjustment=
s.
>=20
> The problem does not seem to occur with ACPI=3DOFF
>=20
> More details here in a post to the linux-kernel mailing list:
> http://lkml.org/lkml/2004/5/9/100
>=20
> Also a relevant and informative entry here:
> http://forums1.itrc.hp.com/service/forums/questionanswer.do?threadId=3D=
467655
>=20
> When on battery, KDE is barely usable. Once again it doesnt make much s=
ense
> for a laptop not to be usable on battery ... :(
>=20
>=20
> Thanks for your attention and hopefully for your answers/comments. I ca=
n
> provide as much debug/info/configs as you would like and as a programme=
r am
> willing to help out/read up, if you just help me identify where to star=
t.
>=20
> Thanks,
>    Andr=E9 Eisenbach

-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id%62&alloc_ida84&op=3Dclick
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
