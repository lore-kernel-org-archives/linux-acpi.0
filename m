From: Bob McElrath <mcelrath-/+vdk8Lzq6wBYXXUC76CrNADJCGDAxhI@public.gmane.org>
Subject: Re: laptop turns itself off
Date: Tue, 23 Jul 2002 15:17:37 -0500
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20020723151737.A18822@draal.physics.wisc.edu>
References: <20020710132039.B17998@draal.physics.wisc.edu> <20020723183320.GA25180@lps.ens.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gBBFr7Ir9EOA20Yy"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20020723183320.GA25180-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>; from ebrunet-l5PIGlIYzrxGWvitb5QawA@public.gmane.org on Tue, Jul 23, 2002 at 08:33:21PM +0200
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=acpi-devel>
To: =?iso-8859-1?Q?=C9ric_Brunet?= <ebrunet-l5PIGlIYzrxGWvitb5QawA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=C9ric Brunet [ebrunet-l5PIGlIYzrxGWvitb5QawA@public.gmane.org] wrote:
> On Wed, Jul 10, 2002 at 01:20:39PM -0500, Bob McElrath wrote:
> > I have a laptop that spontaneously turns itself off about once or twice
> > a day.  It is an all-ACPI model from Compal model ACL00.  I understand
> > it is equivalent to a Toshiba Satellite 3000 series.  The computer
> > itself is the Emperor Linux model from http://www.aslab.com/.
>=20
> I have the same problem with toshiba S3000-X11.

X11?  As in X-Windows?  Is that the model number?  Interesting... ;)

> It happens even when the computer is cool. However, I think it is related=
 to temperature:

Mine seems to bounce between 50 and 60 degrees C.  Seems a bit hot to
me.  I'd like to keep the fan on and keep it below 50...

> I have spent some time looking at the temperature of the computer, as
> reported by Bruno Ducrot's tosh300k module (the DSDT is buggued, so there
> is no thermal zone unless you change it, which I haven't done yet)

Ah, so that's why my thermal doesn't work... :(

> The temperature behaves most of the time nicely: it increases slowly from
> the lower value to the higher, then goes down quickly as the fan gets on.
> However, at some times, the sensor report some aberrant value; like 15 or
> 20 or more degrees (Centigrade) off. It lasts for one or two seconds and
> goes back to normal.
>=20
> I believe that at some point, the grossely incorrect reported temperature
> triggers the emergency shutdown.
>=20
> I don't know what I should do. Is there a way to disable the emergency
> shutdown (the fan works correctly, thank you) ? Is it possible to make
> the emergency procedure average the temperature for 5 seconds before
> deciding to shut down ? Is there a way to fix the sensors so that they
> don't report wrong values ?
>=20
> Of course, the other possibility is that the shutdown has nothing to do
> with temperature, and that the wrong values reported by the sensors are
> just a coincidence.

This is very interesting information.  I just discovered (thanks to a
post on this list) the omnibook tools:
    http://sourceforge.net/projects/omke
Which work with my laptop (after some patching to recognize the ACL00 --
which I will send to the maintainer shortly), and are able to report
temperature.  I also just wrote a script to log the temperature every
second:
    #!/usr/bin/perl -w

    use IO::Handle;

    open(OUT, ">>templog") || die "Unable to open ~/templog";
    OUT->autoflush(1);

    while(1) {
        chomp($date=3D`date`);
        chomp($temp=3D`cat /proc/omnibook/cpu`);
        chomp(@performance=3D`cat /proc/acpi/processor/CPU0/performance`);
        foreach $line (@performance) {
            if($line =3D~ /^.*\*(P[01]): *(\d+) MHz.*/) { $acpiperf =3D $1;=
 $acpimhz =3D $2; }
        }
        chomp(@cpuinfo=3D`cat /proc/cpuinfo`);
        foreach $line (@cpuinfo) {
            if($line =3D~ /^cpu MHz.*: ([\d\.]+).*/) { $cpuinfomhz =3D $1; }
        }
        $outstr =3D "$date: $temp, CPU speed: $acpiperf($acpimhz) $cpuinfom=
hz\n";
        print OUT $outstr;
        print $outstr;
        system("/bin/sync");
        sleep 1;
    }

I will let you know if I see the wild temperature variations you mention.

Right now ACPI does not recognize the fan on this laptop.  Looking at my ds=
dt,
it seems that there is stuff in there about reading/writing the fan status.
Presumably if ACPI took control of the fan and temperature reading, the BIOS
would stop controlling it.  For instance, with the omnibook tools above, as
soon as they take control of the volume buttons, they stop working -- they'=
re
interepreted as keypresses.  I had to write X11 key handlers (WindowMaker m=
enu
items with a keyboard shortcut) to call aumix to change the volume.

I wonder if all tosh3k/ACL00/Omnibook users see this problem, or if we
have a buggy temperature sensor/controller.

Incidentally, the omnibook tools allow all the extra front buttons to work.
They show up as keypresses.  Now I have them hooked up to xmms.  ;)

What processor state have you been using (P0/P1)?  Have you tried both?
I notice more crashes when in state P1 but it also crashes in P0.  I
wonder if this is related.  (There were lots of reported Speedstep
related crashes around 10/2001)

I also just compiled the cpufreq patch.  Hopefully this will fix linux'
timer when the speed changes.  (in state P1 /proc/cpuinfo still reports
the P0 speed)  Dunno if this has anything to do with anything...

Cheers,
-- Bob

Bob McElrath (rsmcelrath-9geRo0GdX4mkVGS65fRQmodd74u8MsAO@public.gmane.org)=20
Univ. of Wisconsin at Madison, Department of Physics

"No nation could preserve its freedom in the midst of continual warfare."
    --James Madison, April 20, 1795

--gBBFr7Ir9EOA20Yy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj09ueEACgkQjwioWRGe9K2CwACghv/mq543oLRWiNWl1DJtTe8t
hZ8AoIg9axOoUOC4DGppzrziXGud3WO+
=C0c+
-----END PGP SIGNATURE-----

--gBBFr7Ir9EOA20Yy--


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
