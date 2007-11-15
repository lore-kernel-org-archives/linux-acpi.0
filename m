From: Rolf Eike Beer <eike-hotplug@sf-tec.de>
Subject: Re: [PATCH 2/5] Construct one fakephp slot per pci slot
Date: Thu, 15 Nov 2007 12:57:56 +0100
Message-ID: <200711151258.02696.eike-hotplug@sf-tec.de>
References: <20071114193605.GA25002@ldl.fc.hp.com> <20071114201246.GZ17785@parisc-linux.org> <20071114205555.GH25002@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2096403.2qAC2VgN9l";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.sf-mail.de ([62.27.20.61]:60838 "EHLO mail.sf-mail.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755815AbXKOL6P (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Nov 2007 06:58:15 -0500
In-Reply-To: <20071114205555.GH25002@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
Cc: Matthew Wilcox <matthew@wil.cx>, Gary Hade <garyhade@us.ibm.com>, Greg KH <greg@kroah.com>, gregkh@suse.de, kristen.c.accardi@intel.com, lenb@kernel.org, rick.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, kaneshige.kenji@jp.fujitsu.com, pcihpd-discuss@lists.sourceforge.net, linux-acpi@vger.kernel.org

--nextPart2096403.2qAC2VgN9l
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Mittwoch, 14. November 2007 schrieb Alex Chiang:
> * Matthew Wilcox <matthew@wil.cx>:
> > On Wed, Nov 14, 2007 at 12:37:29PM -0700, Alex Chiang wrote:
> > > Register one slot per slot, rather than one slot per function.
> > > Change the name of the slot to fake%d instead of the pci address.
> > >
> > > +#define SLOT_NAME_SIZE KOBJ_NAME_LEN
> >
> > Defined, then never used ... how about s/KOBJ_NAME_LEN/8/, then use
> > SLOT_NAME_SIZE throughout?
>
> Whoops, good catch. I had a braino there.

Just drop it and use sizeof(dslot->name) in snprintf(). Just be careful not=
 to=20
use slot->name there as it would always be sizeof(void*)!

Eike

--nextPart2096403.2qAC2VgN9l
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.4-svn0 (GNU/Linux)

iD8DBQBHPDRKXKSJPmm5/E4RAlD8AJsHvbDUszM1hxiF1ejjsiXfTEFrQACfXEn5
Mg8iJNoYdp4qGPoWNWGjKGA=
=7xfM
-----END PGP SIGNATURE-----

--nextPart2096403.2qAC2VgN9l--
