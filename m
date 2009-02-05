From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: How should I handle device with two PNP-BIOS ids?
Date: Wed, 4 Feb 2009 17:00:19 -0700
Message-ID: <200902041700.20476.bjorn.helgaas@hp.com>
References: <497d80991ef709.35340258@wp.pl> <200901270852.52153.bjorn.helgaas@hp.com> <20090127171752.GI4996@sci.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:5804 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754799AbZBEAAf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Feb 2009 19:00:35 -0500
In-Reply-To: <20090127171752.GI4996@sci.fi>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ville =?iso-8859-1?q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Krzysztof Helt <krzysztof.h1@wp.pl>, Adam Belay <abelay@mit.edu>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Tuesday 27 January 2009 10:17:52 am Ville Syrj=E4l=E4 wrote:
> On Tue, Jan 27, 2009 at 08:52:51AM -0700, Bjorn Helgaas wrote:
> > Oh.  That sounds like a BIOS bug.  If there's only one actual
> > chip, the BIOS should not report it as two separate devices.
>=20
> It's not a bug. The cs423x chips contain several logical devices.
> WSS, MPU401, joystick etc.

Sorry it took me so long to get back to this.

Yes, you're right.  I was thinking the first device had a set of
resources, and the second device had a superset that included the
same resources plus another one, but that's not the case here.

> The control logical device (which is=20
> not present in the early models) is unfortunately some kind of dumpin=
g
> ground for new registers to keep the other logical devices' backwards
> compatible. It contains at least some extra mixer control registers a=
nd
> power management registers.

In this case, you have:

  /sys/bus/pnp/devices/00:0f/id:CSC0000
  /sys/bus/pnp/devices/00:0f/resources:state =3D active
  /sys/bus/pnp/devices/00:0f/resources:io 0x530-0x537
  /sys/bus/pnp/devices/00:0f/resources:io 0x388-0x38b
  /sys/bus/pnp/devices/00:0f/resources:io 0x220-0x22f
  /sys/bus/pnp/devices/00:0f/resources:irq 5
  /sys/bus/pnp/devices/00:0f/resources:dma 1
  /sys/bus/pnp/devices/00:0f/resources:dma 0

  /sys/bus/pnp/devices/00:10/id:CSC0010
  /sys/bus/pnp/devices/00:10/resources:state =3D active
  /sys/bus/pnp/devices/00:10/resources:io 0x210-0x217

Can't you just register another struct pnp_driver that claims the
CSC0010 device?  E.g., something like:

  static struct pnp_dev *ctrl;
  static int snd_cs423x_ctrl_pnpbios_detect(struct pnp_dev *dev, ...)
  {
	if (pnp_device_is_isapnp(dev)
		return -ENOENT;
	ctrl =3D dev;
	return 0;
  }

  static const struct pnp_device_id snd_cs423x_ctrl_ids[] =3D {
	{ .id =3D "CSC0010" },
  };
  static struct pnp_driver cs423x_ctrl_pnp_driver =3D {
	.id_table =3D snd_cs423x_ctrl_ids,
	.probe =3D snd_cs423x_ctrl_pnpbios_detect,
  };

Obviously that doesn't work for multiple cs423x chips, but I think we
had that problem before.  For ISAPNP, we have the "card" concept to
group the related logical devices.  But I don't see anything similar
in PNPBIOS (maybe I missed it), so I don't see how we could keep track
of multiple PNPBIOS cs423x chips.

Bjorn
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
