From: "Joey Lee" <jlee@novell.com>
Subject: Re: [PATCH] Add intel drm blacklist to intel_opregion_present
 detect
Date: Tue, 24 Aug 2010 08:51:26 -0600
Message-ID: <4C74690E020000230001F3F1@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mjg59@srcf.ucam.org
Cc: gregkh@suse.de, trenn@suse.de, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Dennis.Jansen@web.de

Hi Matthew,=20

=E6=96=BC =E4=BA=8C=EF=BC=8C2010-08-24 =E6=96=BC 15:22 +0100=EF=BC=8CMa=
tthew Garrett =E6=8F=90=E5=88=B0=EF=BC=9A
> Erm. Sorry about that - I just realised that there's actually a fairl=
y=20
> significant problem with it :) Right now you'll perform the register=20
> call unconditionally on module load. You need to make sure that there=
's=20
> actually Poulsbo hardware in the system, either by registering as a=20
> proper PCI driver and calling acpi_video_register in your probe funct=
ion=20
> (and unregister in your remove function) or walking the PCI device li=
st=20
> looking for a psb device.
>=20

Sorry! You are right! That's my fail!
I will put the PCI device check in probe function then send patch again=
=2E

Appreciate for your review.


Thank's a lot!
Joey Lee

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
