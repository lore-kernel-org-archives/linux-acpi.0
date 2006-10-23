From: Frank Seidel <fseidel@suse.de>
Subject: Re: [patch 0/2] acpi: driverregistration again can report ENODEV
Date: Mon, 23 Oct 2006 18:33:24 +0200
Message-ID: <200610231833.29714.fseidel@suse.de>
References: <20061020092547.519734000@neutrino.suse.de> <1161529793.12599.36.camel@sublime.site> <200610230934.12775.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4174468.J3QWtQpfmF";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:31400 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751999AbWJWQdj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 23 Oct 2006 12:33:39 -0400
In-Reply-To: <200610230934.12775.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: trenn@suse.de, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>

--nextPart4174468.J3QWtQpfmF
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

first i want to thank you for your feedback, which i really appreciate=20
very much.

On Monday 23 October 2006 17:34, Bjorn Helgaas wrote:
> I think the current tree contains a merge error in asus_acpi_init().
> It says:
>
> 	if (!asus_hotk_found) {
> 		...
> 		return result;
>
> But "result" is always zero at this point (it came from
> acpi_bus_register_driver(), which returns either zero or a negative
> error value).
I got convinced that this is source of the problem.=20
acpi_bus_register_driver() shouldn't always return zero, but -ENODEV=20
if no device was attached to the driver.
Currently it only does so if acpi is disabled.

>
> My original change:
> =20
> http://kernel.org/git/?p=3Dlinux/kernel/git/torvalds/linux-2.6.git;a=3Dco
>mmitdiff;h=3D578b333bfe8eb1360207a08a53c321822a8f40f3 contained:
>
> 	if (!asus_hotk_found) {
> 		...
> 		return -ENODEV;
>
> which is what we want.  I think the -ENODEV got lost when resolving
> conflicts with the "propagate correct return value" patches that
> happened at about the same time.
That is the very same solution i also first thought of for this problem.=20
But as the result var here holds the return value of=20
acpi_bus_register_driver(), asus_acpi is also ok again with this fix.

> > > I think it's a mistake to have acpi_bus_register_driver() return
> > > any indication of how many devices were claimed.  If the driver
> > > needs to know how many devices it claimed, it can easily count
> > > them in its add() method.  Returning the count from
> > > register_driver() is racey if devices can be hot-plugged.
> >
> > I think this is wrong.
> > It needs not to return the number of claimed devices, it needs to
> > return -ENODEV if no device will ever exist.
>
> There is no way for acpi_bus_register_driver() to know that no device
> will ever exist.
But it can determine if the driver could be attached to devices or not
as acpi_driver_attach increases the references counter each time
it could bind the driver.

> > The whole culprit to hotplug design (and you are right, this patch
> > also does not
> > work because of this) is this line in acpi_driver_attach:
> >                 if (dev->driver || !dev->status.present)
> >                         continue;
> > If a device is not present, but exists in ACPI namespace, .add
> > function must still be
> > called.
> > Can you/someone have a look at my mail a month ago:
> > http://marc.theaimsgroup.com/?l=3Dlinux-acpi&m=3D115833743117570&w=3D2
>
> Sorry, I missed this and haven't had time to pay any attention
> to this for a long time.
>
> I'm not sure I agree with your approach.  I don't think a driver
> should have to have a notify handler just to handle hotplug.  It
Perhaps i got Thomas wrong, but i think he doesn't intend the
=2Enotify callback functions to be mandatory for every driver (as many
don't need them at all). But this is a nice way for drivers that e.g.=20
need to/should stay even if the devices got removed or never were=20
available until now (like for batteries).
In general .add and .remove sometimes are (or seemt to be) not enough=20
and .notify callbacks seems a elegant way to solve this in a common=20
way.
But i have to admit that the changes this trails in the other drivers
(using notifications) is a drawback on the one side, but on the other
this also could be the chance to do some great cleanups (e.g. in
memory hotplug).

=46rank

--nextPart4174468.J3QWtQpfmF
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBFPO7ZlizSENHXK2gRAj7nAJ0TKQWJSeX2AvNuTCh16PTA5J7hTgCeO3ED
sdUtfNJ7t6T9jbryjYWrM1U=
=csFs
-----END PGP SIGNATURE-----

--nextPart4174468.J3QWtQpfmF--
