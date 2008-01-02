From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [patch] hibernation: utilize ACPI hardware signature
Date: Wed, 2 Jan 2008 15:12:53 +0100
Message-ID: <200801021512.54140.rjw@sisk.pl>
References: <1199257162.14632.4.camel@sli10-desk.sh.intel.com> <62e5edd40801020208s268aeacbj96481f5a317b8ea7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:41595 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752559AbYABOK6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jan 2008 09:10:58 -0500
In-Reply-To: <62e5edd40801020208s268aeacbj96481f5a317b8ea7@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Erik =?iso-8859-15?q?Andr=E9n?= <erik.andren@gmail.com>
Cc: Shaohua Li <shaohua.li@intel.com>, pm list <linux-pm@lists.linux-foundation.org>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Wednesday, 2 of January 2008, Erik Andr=E9n wrote:
> Hi,
>=20
> 2008/1/2, Shaohua Li <shaohua.li@intel.com>:
> >
> > ACPI defines a hardware signature. BIOS calculates the signature
> > according to hardware configure, if hardware changes, the signature=
 will
> > change, in this case, S4 resume should fail.
> >
> > Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> > ---
>=20
>=20
> Would it be possible to extend this mechanism to prevent the followin=
g
> scenario:
>=20
> 1. Linux image A is suspended to disk
> 2. Linux image B is booted and various changes to the system are done=
=2E
> 3. Linux image B is shut down
> 4. Linux image A is booted, restoring the suspend to disk image.
> 5. Chaos is ensured as the file system state is changed in regard to =
how
> linux image A expects it.
>=20
> Correct behaviour would naturally be that image A detects that change=
s have
> been made under its feet and proceed to perform a normal boot instead=
 of
> resuming the stored suspend-to-disk image.

It should be possible in theory.

> Is there another mechanism preventing this?

Not at the kernel level, but you can prevent this from happening by run=
ning
mkswap on all swap spaces that refuse to come up after a fresh boot.

Greetings,
Rafael
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
