From: =?ISO-8859-1?Q?S=E9rgio?= Monteiro Basto <sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org>
Subject: Re: Re: DSDT Change (Compaq Presario 2100)
Date: Sat, 03 Jul 2004 02:24:33 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1088817873.8649.21.camel@darkstar>
References: <200405280621.29874.andre@eisenbach.com>
	 <c9am7j$nng$1@sea.gmane.org> <200405291345.51712.andre@eisenbach.com>
	 <20040628213409.GA19468@elf.ucw.cz> <cbsi0v$t1r$1@sea.gmane.org>
	 <20040702115454.GA12889@elf.ucw.cz>  <40E59C64.9050603@eisenbach.com>
Reply-To: sergiomb-hHo3WeeoaswVhHzd4jOs4w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <40E59C64.9050603-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andre Eisenbach <andre-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org>, "Francesco P. Lovergine" <frankie-8fiUuRrzOP0dnm+yROfE0A@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Erik Meitner <usenet-cuDg6iFcrsRAfugRpC6u6w@public.gmane.org>, acpi-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, 2004-07-02 at 18:33, Andre Eisenbach wrote:
> Pavel Machek wrote:
>=20
> >>>Try your machine on battery, with full load. Monitor battery
> >>>temperature. If it gets hot, your battery was not really designed for
> >>>this, and forget this...
> >>>								Pavel
> >>>     =20
> >>>
>=20
> Thanks for the heads up on this, Pavel!
>=20
> I did unplug my batter, started an updatedb and compiled firefox,=20
> coreutils and a new kernel. The battery got warm, but not hot.=20
> Definitely not more then when charging it.
>=20
> A curious (unrelated) observation:
> The ACPI thermal zone temperature indicated about 68 C at most  on=20
> battery doing this. However, when the battery was drained and I plugged=20
> the AC back in, the temperature rose and stayed at about 75 C and the=20
> fans worked audibly harder. This continued even after I removed the=20
> battery, so it's not the additional heat from the charging.
> I wonder if something else is throttled when on battery. It's not the=20
> CPU though as benchmarks dont slow down on battery anymore after my DSDT=20
> change.
>=20
> As far as the DSDT change goes. Pavel, do you think that the kind of=20
> throtteling they do is an effective way to limit battery current draw?
> I am getting more battery life now - even with powernow at "performance".
>=20
> Cheers.
>    Andre
Hi=20
with cpufreq on kernel 2.4.2x
you can get even better "performance" (I guess)
http://ftp.linux.org.uk/pub/linux/cpufreq/

About nolapic problem. I understand that you, also, have to put
"nolapic" on boot kernel to boot. Well is an old problem on some
presarios like my 700.=20
We have one patch that can resolve boot problem, I am testing it and the
only problem that I found by now, is that hangs when trying change video
output (Fn+F3).
the last propose patch on
http://bugme.osdl.org/show_bug.cgi?id=3D1269

ah! btw my dir /proc/acpi/thermal_zone/ is empty and laptop lives well
with that.

cheers,
--=20
S=E9rgio M. B.



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
