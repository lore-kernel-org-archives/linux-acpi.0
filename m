From: "Uwe Bugla" <uwe.bugla@gmx.de>
Subject: Re: Re: [patch 11/18] pnpacpi: reject ACPI_PRODUCER resources
Date: Thu, 29 Jun 2006 14:24:19 +0200
Message-ID: <20060629122419.151020@gmx.net>
References: <CFF307C98FEABE47A452B27C06B85BB6D8C7C7@hdsmsx411.amr.corp.intel.com>
	 <1151409746.44a11e52e7002@imp8-g19.free.fr>	
 <1151456568.21189.84.camel@sli10-desk.sh.intel.com>	
 <200606281055.26887.bjorn.helgaas@hp.com>
 <1151543616.21189.99.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.de ([213.165.64.21]:392 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751717AbWF2MYV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 29 Jun 2006 08:24:21 -0400
In-Reply-To: <1151543616.21189.99.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>, bjorn.helgaas@hp.com
Cc: linux-acpi@vger.kernel.org, len.brown@intel.com, akpm@osdl.org, ambx1@neo.rr.com, castet.matthieu@free.fr


-------- Original-Nachricht --------
Datum: Thu, 29 Jun 2006 09:13:36 +0800
Von: Shaohua Li <shaohua.li@intel.com>
An: Bjorn Helgaas <bjorn.helgaas@hp.com>
Betreff: Re: [patch 11/18] pnpacpi: reject ACPI_PRODUCER resources

> On Wed, 2006-06-28 at 10:55 -0600, Bjorn Helgaas wrote:
> > On Tuesday 27 June 2006 19:02, Shaohua Li wrote:
> > > On Tue, 2006-06-27 at 14:02 +0200, castet.matthieu@free.fr wrote:
> > > > Is only PNP0A03 is producer type in __all__ ACPI possible devic=
es ?
> > > > If not we will have the same problem with others devices...
> > > >=20
> > > > I don't think blacklist is the solution : pnpacpi should be abl=
e to
> handle all
> > > > ressources types : we should complete the implementation instea=
d of
> blacklist
> > > > devices our implementation doesn't support.
> > > >=20
> > > > If there are broken ACPI bios, there should be firmware update,=
 a
> patched dsdt
> > > > or a quirk, but no "quirk and no generic solution".
> >=20
> > > From my understanding, if the device is really a PNP device its
> resource
> > > should not be producer.
> >=20
> > I know PNP as currently implemented doesn't support resource produc=
ers.
> > But I don't think of that as a restriction of PNP itself.  I think =
of
> > it as an area where a new back end (PNPACPI) added functionality, a=
nd
> > PNP should be enhanced to comprehend it.
> Ok, it's fine ACPI PNP handles resource producers.
>=20
> > I think the current scheme where some devices are claimed using
> > PNPACPI and pnp_register_driver(), and others are claimed using
> > acpi_bus_register_driver() directly, is confusing at best.
> >=20
> > I'd rather have ALL devices handled by PNPACPI, and either extend
> > the PNP infrastructure to comprehend the new functionality of ACPI
> > (e.g., new resource types like PCI bus numbers, ACPI events), or
> > maybe just provide a "to_acpi_dev()" that takes a PNP device and
> > returns the corresponding ACPI device.
Hi Shaohua,
> That's a big deal. We had a lot of discussions about this like
> introducing ACPI bus, but frankly there isn't a solid direction which
> bus ACPI devices should belong to.
Where is the deeper sense of this discussion as long as the AS-IS-STATE=
 conforms to a multiplicity of busses like ISA, PCI, AGP, please?
And why please didn=C2=B4t you mix yourself in at an earlier point of t=
ime?
And why don=C2=B4t you offer more profound material and information on =
the conflicts you saw on your IA64 architecture?
I simply have big problems understanding the attitude behind your behav=
iour.
>=20
> > > Or could we take this way, merge both patches (both patches are g=
ood
> to
> > > me), which should be safer. Anyway, it doesn't make sense to expo=
rt
> root
> > > bridge to pnp layer to me.
> >=20
> > One reason I don't like the blacklist is because it just papers ove=
r
> > the problem without leaving a clue about how to really solve it.
> > For example, if PNP is enhanced later to comprehend resource produc=
ers,
> > we won't know to go back and remove things from the blacklist.
> So lets have a note there. It (no blacklist) is meaningful to have al=
l
> ACPI devices handled by PNP layer, but currently not.
In how far "currently not", please? At what point of time will this mak=
e sense according to your opinion?
> We don't expect a PNP driver for root bridge.
> And we will take risk of buggy BIOS.
What please has a buggy BIOS to do with a more cryptic or more sophisti=
cated ACPI PNP concept?
>=20
> Thanks,
> Shaohua
>=20
Regards
Uwe


--=20


"Feel free" =E2=80=93 10 GB Mailbox, 100 FreeSMS/Monat ...
Jetzt GMX TopMail testen: http://www.gmx.net/de/go/topmail
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
