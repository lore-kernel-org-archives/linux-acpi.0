From: tmc-+XVqjN4+fIJfbCVcMT5z6Ydd74u8MsAO@public.gmane.org (Tomasz Ciolek)
Subject: Re: S3 suspend/resume driver questions
Date: Tue, 20 Apr 2004 11:46:14 +1000
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040420014614.GN8823@dreamcraft.com.au>
References: <32839.66.245.64.93.1082425332.squirrel@webmail.cc.gatech.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wxDdMuZNg1r63Hyj"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <32839.66.245.64.93.1082425332.squirrel-2RFepEojUI2yzif+TlFmFpQCsf4PZ8us@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ilya Bagrak <reason-ss4n/k5RZhaUArH+D2fLrA@public.gmane.org>
Cc: brewt-acpi.sf.net-CDLCgzMZgTDYtjvyW6yDsg@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

 Hooray.
=20
 If only someone at ATI or Fujitsu finnaly mamanged to cough up
 the magic incantations for the radeon cards so that the POST
 correctly...=20

 Regards
 TMC

On Mon, Apr 19, 2004 at 09:42:12PM -0400, Ilya Bagrak wrote:
> Adrian,
>=20
> Your patch worked beautifully on my Fujitsu E7010 laptop.  Prior to the
> patch, the system would lock up hard if I tried to load snd_intel8x0 after
> waking up from S3.  If I didn't not unload the sound modules before going
> to sleep, the system would not wake up at all (lock up would happen on
> resume).  In any case, the sound "just works" (tm) now.
>=20
> There is more good news.  I adapted your patch to orinoco_pci driver which
> manages my built in Prism2 wireless adapter.  The unpatched driver failed
> to reinit the card upon resume.  Even though that didn't not lock up my
> computer like sound did, the card was not functional.  I was absolutely
> stunned when this 3-liner-of-a-patch returned full functionality to the
> card upon resume.  You don't even have to unload the driver before going
> to sleep.  I have a little signal strength applet running in the toolbar,
> and you can watch the signal strength gradually increase after wakeup and
> the card is back to normal in a couple of seconds.
>=20
> The wireless NIC was the last stumbling block in getting S3 to work.  I
> now officially declare Fujitsu E7010 Linux ACPI-friendly.  All major
> devices (have not tested Firewire or IrDA) recover and work properly after
> S3. Thank you all.
>=20
> Ilya
>=20
> > Hi,
> >
> >> mine isn't a technical reply, but you can post in the 'alsa-devel'
> >> mailing-list, as it seems that Takashi Iwai is working on PM-lacking
> >> drivers. Here some links:
> >>    http://sourceforge.net/mailarchive/forum.php?thread_id=3D4201761&fo=
rum_id=3D1752
> >
> > Doing a grep through the alsa code, it doesn't look like any driver
> > save/restores pci state.
> >
> >>    http://sourceforge.net/mailarchive/forum.php?thread_id=3D4107033&fo=
rum_id=3D1752
> >>
> >> BTW-1, could you post your 'intel8x0' patch? I could give it a try
> >> ASAP...
> >
> > That's essentially what I did.  It is a little different though:
> >
> > --- /usr/src/linux-2.6.5-mm6/sound/pci/intel8x0.c       2004-04-05
> > 18:46:17.000000000 -0700 +++ intel8x0.c  2004-04-18 04:03:34.000000000
> > -0700
> > @@ -445,6 +445,7 @@ struct _snd_intel8x0 {
> >
> >  #ifdef CONFIG_PM
> >         int in_suspend;
> > +       u32 pci_state[16];
> >  #endif
> >  };
> >
> > @@ -2223,11 +2224,13 @@ static int snd_intel8x0_suspend(struct p
> >  {
> >         intel8x0_t *chip =3D snd_magic_cast(intel8x0_t,
> > pci_get_drvdata(dev), return -ENXIO); intel8x0_suspend(chip);
> > +       pci_save_state(dev, chip->pci_state);
> >         return 0;
> >  }
> >  static int snd_intel8x0_resume(struct pci_dev *dev)
> >  {
> >         intel8x0_t *chip =3D snd_magic_cast(intel8x0_t,
> > pci_get_drvdata(dev), return -ENXIO);
> > +       pci_restore_state(dev, chip->pci_state);
> >         intel8x0_resume(chip);
> >         return 0;
> >  }
> >
> >> BTW-2, in the few tests I made on my ASUS M6842NWH ('intel8x0' based),
> >> I have to remove the sound modules even to have a successfull S1.
> >
> > Actually, I haven't tried out S1 yet, but I don't have to remove the
> > sound modules for S3 to work.  And even if I do, my system will lock up
> > when trying to load the alsa drivers due to the device's configuration
> > state.
> >
> > Adrian
> >
> >
> > -------------------------------------------------------
> > This SF.Net email is sponsored by: IBM Linux Tutorials
> > Free Linux tutorial presented by Daniel Robbins, President and CEO of
> > GenToo technologies. Learn everything from fundamentals to system
> > administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op?k
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
>=20
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=3Dclick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel

--=20
Tomasz M. Ciolek=09
***************************************************************************=
****
 tmc at dreamcraft dot com dot au=20
***************************************************************************=
****
   GPG Key ID:		0x41C4C2F0
   GPG Key Fingerprint: 3883 B308 8256 2246 D3ED  A1FF 3A1D 0EAD 41C4 C2F0
   Key available on www.pgp.net=09
***************************************************************************=
****

--wxDdMuZNg1r63Hyj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAhIDmOh0OrUHEwvARAhD/AKCG6xyeKE9W2fqKHfuIpcTgk7ajigCeOaVS
OjpOpAy1dIoKGOEA60l9umM=
=gCll
-----END PGP SIGNATURE-----

--wxDdMuZNg1r63Hyj--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
