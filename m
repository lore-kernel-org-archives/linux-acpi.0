From: "Herbert Nachtnebel" <Herbert.Nachtnebel-8zxNtbQCHXIjuwv8T7myQQ@public.gmane.org>
Subject: Re: gettimeofday() moving backwards
Date: Thu, 19 Dec 2002 11:01:22 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <B900970C7DD9474C972986EB3EC7C58F0D404F@andromeda.agcad.local>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: p.a.richards-Y3tGgqFSo3OFxr2TtlUqVg@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

In 2.4 there exists CONFIG_ASYNC_TSC to help with such things.=20
I never tried it, but it should change the gettimeofday()=20
system call to not use the TSC for time calculations. This=20
results in a really slow system call since now it uses the PIT
for every access, but the system time should be smoothly again.

Regards, Herbert.

-----Urspr=FCngliche Nachricht-----
Von: Dominik Brodowski [mailto:linux-JhLEnvuH02M@public.gmane.org]
Gesendet: Mittwoch, 18. Dezember 2002 23:41
An: Grover, Andrew
Cc: 'Paul Richards'; acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Betreff: Re: [ACPI] gettimeofday() moving backwards


On Wed, Dec 18, 2002 at 01:23:57PM -0800, Grover, Andrew wrote:
> > From: Paul Richards [mailto:p.a.richards-Y3tGgqFSo3OFxr2TtlUqVg@public.gmane.org]=20
> > I am using linux kernel v2.4.20 with ACPI patch dated 2002-12-05.
> >=20
> > I have noticed that if my processor changes state (800Mhz up=20
> > to 1200Mhz say)
> > then gettimeofday() behaves weirdly.  It runs smoothly but=20
> > every now and again
> > (on the order of 10 times a second) it makes a correction. =20
> > If I have gone from
> > 800Mhz to 1200Mhz then the correction is backwards, otherwise=20
> > it makes a forward
> > jump..
>=20
> Hmm, can you mention this on the cpufreq mailing list?
> cpufreq-1walMZg8u8rXmaaqVzeoHQ@public.gmane.org .

In kernel 2.5.5x, gettimeofday() should work fine: ACPI uses the cpufreq
infrastructure, which adds -among other things- a hunk in
arch/i386/timer/tsc.c which updates some values on frequency =
transitions.
(see http://www.brodo.de/cpufreq/ for details on cpufreq).

As cpufreq isn't included in 2.4. kernels, and likely never will, the =
2.4.
gettimeofday() call does cause strange results in 2.4.

	Dominik




-------------------------------------------------------
This SF.NET email is sponsored by: Order your Holiday Geek Presents Now!
Green Lasers, Hip Geek T-Shirts, Remote Control Tanks, Caffeinated Soap,
MP3 Players,  XBox Games,  Flying Saucers,  WebCams,  Smart Putty.
T H I N K G E E K . C O M       http://www.thinkgeek.com/sf/
_______________________________________________
Acpi-devel mailing list
Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.NET email is sponsored by: Geek Gift Procrastinating?
Get the perfect geek gift now!  Before the Holidays pass you by.
T H I N K G E E K . C O M      http://www.thinkgeek.com/sf/
