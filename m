From: Bob Lees <bob-l+PWtdWbHAsG2Il/BtU0GPXRex20P6io@public.gmane.org>
Subject: Re: No battery information - Compaq Evo N800v, 2.4.20pre8, acpi 20021002
Date: Fri, 3 Jan 2003 11:11:21 +0000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200301031111.21645.bob@diamond.demon.co.uk>
References: <200210081115.21667.mark.pritchard-acpi@modus.com.au> <20030102113459.GA2974@zaurus> <87hecqiryo.fsf@lapper.ihatent.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <87hecqiryo.fsf-E1YXmAG8v4VQD7NkSvH8p9BPR1lH4CV8@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Alexander Hoogerhuis <alexh-rpjHciJLgqZBDgjK7y7TUQ@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Alexander

On my 800c running 2.4.19 SUSE 8.1 with 0918 patch and my modified DSDT I=
 get=20
the following:

present:                 yes
design capacity:         4114 mAh
last full capacity:      4114 mAh
battery technology:      rechargeable
design voltage:          14800 mV
design capacity warning: 411 mAh
design capacity low:     0 mAh
capacity granularity 1:  100 mAh
capacity granularity 2:  100 mAh
model number:            Primary
serial number:           3
battery type:            4E4F494C
OEM info:                 COMPAQ

with AC plugged in a full battery

present:                 yes
capacity state:          ok
charging state:          unknown
present rate:            0 mA
remaining capacity:      4114 mAh
present voltage:         16633 mV

with AC removed and a near full battery

present:                 yes
capacity state:          ok
charging state:          discharging
present rate:            1105 mA
remaining capacity:      4074 mAh
present voltage:         16227 mV

I get 3+ hours out of a full battery.

I use my laptop similar to you as a portable desk machine, ie it spends m=
ost=20
of its time plugged into AC.

I also have klaptopdaemon working, edited the current acpi proc tree into=
=20
portable.cpp in the source.

I have not gone down the 2.4.20 route, but will have to shortly as I need=
 the=20
updated usb support.  I was waiting until it appeared stable, but I guess=
 i=20
will have to bit the bullet and try it.  Since working through the variou=
s=20
issues a while back I have a stable acpi install.  About the only area I=20
don't have working is the speedstep switching from P0 to P1; it always=20
reports P0.

I concur, beefy is a good description, but a lot less weight than a numbe=
r of=20
the alternatives, and you forgot the 1600x1200 screen - very nice;)

Hope this helps

Bob

On Friday 03 January 2003 07:59, Alexander Hoogerhuis wrote:
> Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org> writes:
> > Hi!
> >
> > > present:                 yes
> > > design capacity:         1918 mAh
> > > last full capacity:      1918 mAh
> > > battery technology:      rechargeable
> > > design voltage:          14800 mV
> > > design capacity warning: 192 mAh
> >
> > 2Ah seems quite low, but as you have 15V
> > battery its 30Wh, which might be okay for
> > *small* notebook.
>
> Evo n800c is not a *small* notebook, its a pretty beefy thing and the
> biggest beast Compaq could conjure up this summer :) P4-1.7GHz, 768Mb
> RAM and a 30Gb disk and a nice ATI Radeon 7500 to boot :)
>
> > > And it's been a long time since I've had much physics, but the desi=
gn
> > > capacity doesn't seem right to me. I'm able to run about 13-14 mins=
 on
> > > battery, before the machine dies, from a fully charged battery.
> >
> > Perhaps your battery is too old these days?
>
> Not even six months, and not many cycles as its used mainly as a
> portable desktop.
>
> > --
> > =09=09=09=09Pavel
> > Written on sharp zaurus, because my Velo1 broke. If you have Velo you
> > don't need...



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
