From: Marvin Stark <marv@der-marv.de>
Subject: Re: 2.6.21.1 problems during suspend-to-ram
Date: Mon, 30 Apr 2007 20:27:23 +0200
Message-ID: <200704302027.27244.marv@der-marv.de>
References: <200704292348.33869.marv@der-marv.de> <200704301931.16778.marv@der-marv.de> <20070430174309.GA1405@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1261550.dupkuZTPyt";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 139-66-107-89.rdns.global-control.de ([89.107.66.139]:60689
	"EHLO mail.der-marv.de" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with ESMTP id S1423628AbXD3S1m (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 Apr 2007 14:27:42 -0400
In-Reply-To: <20070430174309.GA1405@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org

--nextPart1261550.dupkuZTPyt
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 30 April 2007 19:43, Matthew Garrett wrote:
> On Mon, Apr 30, 2007 at 07:31:11PM +0200, Marvin Stark wrote:
> > On Monday 30 April 2007 00:32, Matthew Garrett wrote:
> > > On Sun, Apr 29, 2007 at 11:48:29PM +0200, Marvin Stark wrote:
> > > > Hi,
> > > >
> > > > I'm trying to suspend my MacBook2,1 to ram and always get following
> > > > error during suspend:
> > > >
> > > > ACPI: PCI interrupt for device 0000:00.1f.2 disabled.
> > >
> > > That's not an error - what problems do you think it's causing?
> >
> > I realy dont know... Maybe you can give me some hints?
> > Is there a way to get more debug info except enable debugging in the
> > kernel?
>
> Well, uh, to start with it might help if you actually told us what the
> problem is.

Main problem is, that the maschine is not shutting down (suspend consoles).
I tried s2ram and s2disk with both programs I'm not able to suspend my=20
maschine. All devices (nic, firewire, usb etc) except hdd were suspended=20
without any problems. After that the maschine freezes, showing this message:

=2D------ 8< -------
ACPI: PCI interrupt for device 0000:00.1f.2 disabled.
=2D------ 8< -------

As 00:1f.2 is my S-ATA controller, I think my harddisk will not get=20
suspended...

=2D------ 8< -------
00:1f.2 IDE interface: Intel Corporation 82801GBM/GHM (ICH7 Family) Serial =
ATA=20
Storage Controller IDE (rev 02)
=2D------ 8< -------

The only possibly way to suspend my system to disk is using sysfs.
But this also only works when I set /sys/power/disk to "shutdown".
If it's set to "platform" my system will not suspend.

So there must be a problem with ACPI. Am I right with this suspicion?

Regards,
=2D-=20
 .""`.     Marvin Stark <marv@der-marv.de>
: :"  :    Homepage: www.der-marv.de
`. `"`
  `-  Debian - when you have better things to do than fix a system

--nextPart1261550.dupkuZTPyt
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGNjUPQV+FW6osnHMRApO8AKCQRw2EmCFBtfv2dNEtZMMFfPpCewCgnPOk
KzLdJ1qdZCN+KkpzeXpRtJ8=
=1SDP
-----END PGP SIGNATURE-----

--nextPart1261550.dupkuZTPyt--
