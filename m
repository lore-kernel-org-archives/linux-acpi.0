From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: DSDT fixes for Presario 900
Date: 23 Sep 2003 06:19:40 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1064294380.1613.9.camel@darkstar.portugal>
References: <200309191439.41572.fedor@karpelevitch.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200309191439.41572.fedor-ugkMPi23kyXAHCkTjeiZhQ@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Fedor Karpelevitch <fedor-ugkMPi23kyXAHCkTjeiZhQ@public.gmane.org>
Cc: LinuxPresario900-+vy+FFr6rAI3CPJRO4ggG/Z8FUJU4vz8@public.gmane.org, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!
I can you give a diff of your orig dsl and your corrected dsl?

BTW: http://developer.intel.com/technology/iapc/acpi/downloads.htm as
been updated in September 19, 2003 and have some things new for presario
for example mine 706EA , now compiles without any error or warning !.

thanks
=20

On Fri, 2003-09-19 at 22:39, Fedor Karpelevitch wrote:
> Hi, people!
>=20
> I finally got around to fixing some of the annoying acpi problems I=20
> was experiencing:
>=20
> 1) lid state reported incorrectly ("open" when closed and "closed"=20
> when open)
>=20
> 2) lack of AC plug/unplug events
>=20
> one remaining annoying problem is double powerbutton events (i get two=20
> events when I press button once). For what I understand it cannot be=20
> fixed by DSDT since it is handled as fixed-feature.
>=20
> Attached are: source and compiled DSDT and a patch to vanilla 2.4.22=20
> (maybe it will apply to 2.6 kernels too) to have this fixed DSDT=20
> override the one from ROM...
>=20
> I would be interested to hear
>=20
> 1) do other people experience same issues on presario 900 (and maybe=20
> Evos) in all it's permutations
> 2) if yes, does this patch remedy these problems?
>=20
> I would appreciate you sending me your DSDTs (cat /proc/acpi/dsdt to a=20
> file) to see if they all have it identical or not...
>=20
> Thanks.
>=20
> Fedor.
> ----

--=20
S=E9rgioMB
email: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org

Who gives me one shell, give me everything.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
