From: "Ow Mun Heng" <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Subject: RE: "TSC cannot be used as a timesource" when on battery
Date: Thu, 11 Mar 2004 16:06:28 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C386328088ED7F4E9F81AFBABDDF60DA04A9256E@wdmyexch02.my.asia.wdc.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "Acpi-List (E-mail)" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Len Brown [mailto:len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]
> Sent: Thursday, March 11, 2004 3:15 PM
> To: Ow Mun Heng
> Cc: Acpi-List (E-mail)
> Subject: RE: [ACPI] "TSC cannot be used as a timesource" when=20
> on battery
>=20
>=20
> Does /proc/acpi/processor/CPU0/power show any usage in C3?

On 2.6.3 kernel, (vanilla or acpi patched or..) C3 Usage is
quite Good. More than C2 (even on battery) only when i put in=20
the usb or access the HD agressively (loading/reading/writing=20
large files, will it get fffffff)
=20
> I believe there is a bugfix in the pipeline regarding local APIC timer
> slowing down in C3. =20

Frankly, running on C3 or C2 doesn't really make a difference for my=20
D600 laptop. (i initially thought it would help increase batt life.=20
No Luck there.)

So.. Should I try apic=3Doff when running on battery? I've not tried=20
that since it's sparodic. sometimes bootup got, sometimes none.

> The fix is to disable C3 -- the workaround is to
> use another timer.

ACPI PM Timer?? Is that where we're heading..

>=20
> cheers,
> -Len

Thanks. Sincerely appreciate it.
Ow

PS : I really want to know what's your/list preference. Reply to List=20
or reply to all. Since if reply to all, then subcribers will get 2 =
copies=20
of the same email. (which is not so nice..)

>=20
>=20
> On Thu, 2004-03-11 at 00:21, Ow Mun Heng wrote:
> > > -----Original Message-----
> > > From: Ow Mun Heng=20
> > > Sent: Monday, March 01, 2004 10:39 AM
> > > To: Acpi-List (E-mail)
> > > Subject: [ACPI] "TSC cannot be used as a timesource" when=20
> on battery
> > >=20
> > >=20
> > > Hi All,
> > >=20
> > > D600 + RH9 + kernel 2.6.3+acpi20040211
> > >=20
> > > Was seeing these error messages when booting from battery.=20
> > > I've searched through google and the only thing It came up with=20
> > > was a reference that asks to use ACPI PM as the timesource.
> > >=20
> > > I'm currently using RTC (real time clock)
> > >=20
> > > I'm still trying to figure out what is the difference=20
> between ACPI=20
> > > PM timesource/RTC.
> > >=20
> > > I've not investigated further to determine if my clock is indeed=20
> > > running slower.=20
> > >=20
> > > =3D=3D=3D=3Dstart kernel message=3D=3D=3D=3D=3D=3D=3D
> > > TSC cannot be used as a timesource.
> > >  <4> Possible reasons for this are
> > > You're running with speedstep
> > > You don't have DMA enabled for your hard drive (See hdparm)
> > > Incorrect TSC synchronization on an SMP system (dee dmesg)
> > > Falling back to sane timesource now.
> > > =3D=3D=3D=3D=3D=3D=3Dend kernel =
messages=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > >=20
> > > HDparm shows all my hd and cdrom are on dma
> > > This is uniprocessor laptop
> > >=20
> > > Yes.. running on speedstep.
> > > When on AC power, I don't see this error.
> >=20
> > Sent this to the list a while back.. I've not
> > seen any responses. So, asking again, just in case it
> > was missed (busy schedules etc)
> >=20
> > I don't really think it's an issue.. but still would like=20
> > to know what is triggering it.
> >=20
> > Thanks,
> > Ow
> >=20
> > =20
> >=20
> >=20
> > -------------------------------------------------------
> > This SF.Net email is sponsored by: IBM Linux Tutorials
> > Free Linux tutorial presented by Daniel Robbins, President=20
> and CEO of
> > GenToo technologies. Learn everything from fundamentals to system
> > =
administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=3Dclick
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20
>=20


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
