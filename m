From: "Adrian Yee" <brewt-acpi.sf.net-CDLCgzMZgTDYtjvyW6yDsg@public.gmane.org>
Subject: Re: S3 suspend/resume driver questions
Date: Sun, 18 Apr 2004 04:16:41 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <GMail.1082287001.299101428.71013230813@brewt.org>
References: <40825D85.1000702@pca.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <40825D85.1000702-wlebWZzHoyE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi,

> mine isn't a technical reply, but you can post in the 'alsa-devel' mailin=
g-list,
> as it seems that Takashi Iwai is working on PM-lacking drivers. Here some=
 links:
>    http://sourceforge.net/mailarchive/forum.php?thread_id=3D4201761&forum=
_id=3D1752

Doing a grep through the alsa code, it doesn't look like any driver save/re=
stores pci state.

>    http://sourceforge.net/mailarchive/forum.php?thread_id=3D4107033&forum=
_id=3D1752
>=20
> BTW-1, could you post your 'intel8x0' patch? I could give it a try ASAP...

That's essentially what I did.  It is a little different though:

--- /usr/src/linux-2.6.5-mm6/sound/pci/intel8x0.c       2004-04-05 18:46:17=
=2E000000000 -0700
+++ intel8x0.c  2004-04-18 04:03:34.000000000 -0700
@@ -445,6 +445,7 @@ struct _snd_intel8x0 {
=20=20=20=20=20=20=20=20
 #ifdef CONFIG_PM
        int in_suspend;
+       u32 pci_state[16];
 #endif
 };
=20
@@ -2223,11 +2224,13 @@ static int snd_intel8x0_suspend(struct p
 {
        intel8x0_t *chip =3D snd_magic_cast(intel8x0_t, pci_get_drvdata(dev=
), return -ENXIO);
        intel8x0_suspend(chip);
+       pci_save_state(dev, chip->pci_state);
        return 0;
 }
 static int snd_intel8x0_resume(struct pci_dev *dev)
 {
        intel8x0_t *chip =3D snd_magic_cast(intel8x0_t, pci_get_drvdata(dev=
), return -ENXIO);
+       pci_restore_state(dev, chip->pci_state);
        intel8x0_resume(chip);
        return 0;
 }

> BTW-2, in the few tests I made on my ASUS M6842NWH ('intel8x0' based), I =
have to
> remove the sound modules even to have a successfull S1.

Actually, I haven't tried out S1 yet, but I don't have to remove the sound =
modules for S3 to work.  And even if I do, my system will lock up when tryi=
ng to load the alsa drivers due to the device's configuration state.

Adrian


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
