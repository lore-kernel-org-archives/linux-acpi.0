From: =?iso-8859-1?Q?=C9ric?= Brunet <Eric.Brunet-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>
Subject: Re: fan control
Date: Tue, 6 May 2003 11:21:20 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030506092120.GA24982@lps.ens.fr>
References: <B900970C7DD9474C972986EB3EC7C58F12EC9A@andromeda.agcad.local> <20030502103102.A2867@fermat.unipv.it> <3EB23932.9090508@gkec.tu-darmstadt.de> <20030502113819.GJ2954@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030502113819.GJ2954-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, May 02, 2003 at 01:38:19PM +0200, Ducrot Bruno wrote:
> > >echo 0
> > >and echo 3 just by guessing).

About fan control, I would love to be able to stop my fan, but it doesn't
work. I can echo anything to /proc/acpi/fan/FAN/state, it has no bearing
on the fan, and the only result is a line in the log:
> acpi_bus-0199 [18] acpi_bus_set_power    : Device is not power manageab=
le
(kernel is 2.5.67)

I guess it is related to the fact that, according to
/proc/acpi/thermal_zone/THRM/trip_points:
> critical (S5):           100 C
> passive:                 90 C: tc1=3D4 tc2=3D3 tsp=3D60 devices=3D0xdf7=
d1ea8
> active[0]:               80 C: devices=3D0xdf75d9a8
the fan is not supposed to shut down. Did I mention that the computer was
not a laptop ?

However, the computer is a shuttle xpc, temperature does not ever go over
35=B0C, and I have the feeling that if I dividez my 5 the CPU frequency,
the computer should be able to live without fan.

What makes me hopefull are the methods FON and FOFF in the dsdt:
>    Method (FON, 0, NotSerialized)
>    {
>        SBYT (0x13, 0x46)
>        SBYT (0x14, 0x57)
>        Store (GBYT (0x54), Local0)
>        SBYT (0x14, Local0)
>        Store (GBYT (0x53), Local0)
>        SBYT (0x13, Local0)
>    }
>
>    Method (FOFF, 0, NotSerialized)
>    {
>        Store (GBYT (0x14), Local0)
>        SBYT (0x54, Local0)
>        SBYT (0x14, 0xD0)
>        Store (GBYT (0x13), Local0)
>        SBYT (0x53, Local0)
>    }

FOFF and FON (Fan Off and Fan On, I think) are called by SFAN (Set Fan.
SFAN(0) calls FOFF and SFAN(0xFF) calls FON). SFAN(0x00) appears
in \_PTS (is that Put To Sleep ?) and SFAN(0xFF) appears in \_WAK.

In short, the fan can be stopped in the software, but it is only done at
sleep time. Now it should be possible to translate the definition of FON
and FOFF in a series of writes to some ioports, I guess, but I have no
idea how to do that...

If you are interested, my dsdt is at http://perso.nerim.net/~tudia/downlo=
ad/dsdt

=C9ric Brunet





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
