From: "Uwe Bugla" <uwe.bugla@gmx.de>
Subject: Re: Re: RE: Re: [patch 11/18] pnpacpi: reject ACPI_PRODUCER resources
Date: Fri, 30 Jun 2006 11:47:47 +0200
Message-ID: <20060630094747.89070@gmx.net>
References: <8BF50482CE9EE245902340E0724784D59B95F2@pdsmsx411.ccr.corp.intel.com>
	 <20060630090451.89100@gmx.net>
 <1151658516.21189.113.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.de ([213.165.64.21]:58547 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932217AbWF3Jrv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Jun 2006 05:47:51 -0400
In-Reply-To: <1151658516.21189.113.camel@sli10-desk.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-acpi@vger.kernel.org, len.brown@intel.com, akpm@osdl.org, ambx1@neo.rr.com, castet.matthieu@free.fr, bjorn.helgaas@hp.com


-------- Original-Nachricht --------
Datum: Fri, 30 Jun 2006 17:08:35 +0800
Von: Shaohua Li <shaohua.li@intel.com>
An: Uwe Bugla <uwe.bugla@gmx.de>
Betreff: Re: RE: Re: [patch 11/18] pnpacpi: reject ACPI_PRODUCER resour=
ces

> On Fri, 2006-06-30 at 11:04 +0200, Uwe Bugla wrote:
> > -------- Original-Nachricht --------
> > Datum: Thu, 29 Jun 2006 20:41:07 +0800
> > Von: "Li, Shaohua" <shaohua.li@intel.com>
> > An: Uwe Bugla <uwe.bugla@gmx.de>, bjorn.helgaas@hp.com
> > Betreff: RE: Re: [patch 11/18] pnpacpi: reject ACPI_PRODUCER resour=
ces
> >=20
> > >=20
> > >=20
> > > >-----Original Message-----
> > > >From: Uwe Bugla [mailto:uwe.bugla@gmx.de]
> > > >Sent: Thursday, June 29, 2006 8:24 PM
> > > >To: Li, Shaohua; bjorn.helgaas@hp.com
> > > >Cc: linux-acpi@vger.kernel.org; Brown, Len; akpm@osdl.org;
> > > ambx1@neo.rr.com;
> > > >castet.matthieu@free.fr
> > > >Subject: Re: Re: [patch 11/18] pnpacpi: reject ACPI_PRODUCER
> resources
> > > >
> > > >
> > > >-------- Original-Nachricht --------
> > > >Datum: Thu, 29 Jun 2006 09:13:36 +0800
> > > >Von: Shaohua Li <shaohua.li@intel.com>
> > > >An: Bjorn Helgaas <bjorn.helgaas@hp.com>
> > > >Betreff: Re: [patch 11/18] pnpacpi: reject ACPI_PRODUCER resourc=
es
> > > >
> > > >> On Wed, 2006-06-28 at 10:55 -0600, Bjorn Helgaas wrote:
> > > >> > On Tuesday 27 June 2006 19:02, Shaohua Li wrote:
> > > >> > > On Tue, 2006-06-27 at 14:02 +0200, castet.matthieu@free.fr
> wrote:
> > > >> > > > Is only PNP0A03 is producer type in __all__ ACPI possibl=
e
> devices
> > > ?
> > > >> > > > If not we will have the same problem with others devices=
=2E..
> > > >> > > >
> > > >> > > > I don't think blacklist is the solution : pnpacpi should=
 be
> able
> > > to
> > > >> handle all
> > > >> > > > ressources types : we should complete the implementation
> instead
> > > of
> > > >> blacklist
> > > >> > > > devices our implementation doesn't support.
> > > >> > > >
> > > >> > > > If there are broken ACPI bios, there should be firmware
> update, a
> > > >> patched dsdt
> > > >> > > > or a quirk, but no "quirk and no generic solution".
> > > >> >
> > > >> > > From my understanding, if the device is really a PNP devic=
e its
> > > >> resource
> > > >> > > should not be producer.
> > > >> >
> > > >> > I know PNP as currently implemented doesn't support resource
> > > producers.
> > > >> > But I don't think of that as a restriction of PNP itself.  I
> think of
> > > >> > it as an area where a new back end (PNPACPI) added functiona=
lity,
> and
> > > >> > PNP should be enhanced to comprehend it.
> > > >> Ok, it's fine ACPI PNP handles resource producers.
> > > >>
> > > >> > I think the current scheme where some devices are claimed us=
ing
> > > >> > PNPACPI and pnp_register_driver(), and others are claimed us=
ing
> > > >> > acpi_bus_register_driver() directly, is confusing at best.
> > > >> >
> > > >> > I'd rather have ALL devices handled by PNPACPI, and either e=
xtend
> > > >> > the PNP infrastructure to comprehend the new functionality o=
f
> ACPI
> > > >> > (e.g., new resource types like PCI bus numbers, ACPI events)=
, or
> > > >> > maybe just provide a "to_acpi_dev()" that takes a PNP device=
 and
> > > >> > returns the corresponding ACPI device.
> > > >Hi Shaohua,
> > > >> That's a big deal. We had a lot of discussions about this like
> > > >> introducing ACPI bus, but frankly there isn't a solid directio=
n
> which
> > > >> bus ACPI devices should belong to.
> > > >Where is the deeper sense of this discussion as long as the
> AS-IS-STATE
> > > >conforms to a multiplicity of busses like ISA, PCI, AGP, please?
> > > >And why please didn=C2=B4t you mix yourself in at an earlier poi=
nt of
> time?
> > > >And why don=C2=B4t you offer more profound material and informat=
ion on
> the
> > > >conflicts you saw on your IA64 architecture?
> > > I just took one ia64 box I ever saw as an example, but it's not u=
nique
> to
> > > ia64 I think.
> > >=20
> > > >I simply have big problems understanding the attitude behind you=
r
> > > behaviour.
> > > Me too :)
> > >=20
> > > >> > > Or could we take this way, merge both patches (both patche=
s are
> > > good
> > > >> to
> > > >> > > me), which should be safer. Anyway, it doesn't make sense =
to
> export
> > > >> root
> > > >> > > bridge to pnp layer to me.
> > > >> >
> > > >> > One reason I don't like the blacklist is because it just pap=
ers
> over
> > > >> > the problem without leaving a clue about how to really solve=
 it.
> > > >> > For example, if PNP is enhanced later to comprehend resource
> > > producers,
> > > >> > we won't know to go back and remove things from the blacklis=
t.
> > > >> So lets have a note there. It (no blacklist) is meaningful to =
have
> all
> > > >> ACPI devices handled by PNP layer, but currently not.
> > > >In how far "currently not", please? At what point of time will t=
his
> make
> > > >sense according to your opinion?
> > > >> We don't expect a PNP driver for root bridge.
> > > >> And we will take risk of buggy BIOS.
> > > >What please has a buggy BIOS to do with a more cryptic or more
> > > >sophisticated ACPI PNP concept?
> > > I want to emphasize I have no objection to merge the producer pat=
ch
> now
> > > but still think root bridge should be black list.
> > Hi Shaohua,
> > if I got something wrong I=C2=B4d appreciate you to correct me.
> > First of all, what is a root bridge please? I know what a PCI-ISA b=
ridge
> is, but I stumbled across the expression "root bridge."
> > As a consequence I do not understand in how far this "root bridge"
> should be blacklisted.
> > As far as I have received the issue the decision of blacklisting or
> rejecting ACPI_PRODUCER is a EITHER-OR one, but NOT a ALSO-THIS and A=
LSO-THAT
> one.
> > In so far your path of argumentation is more than confusing, at lea=
st
> for me, and may be for others too.
> > And as a second consequence I do not understand the essence of prop=
osal
> or decision you are expecting from Bjorn.
> > Would be please clear up this??
> I gave up, and didn't want to argue this issue any more
Hi Shaohua,
Sigh!!
This is no behaviour to bring anything forward. Guess we are missing mo=
re material, more information on specific platforms not conforming with=
 that ACPI-PRODUCER rejectment. In any other case there won=C2=B4t be a=
ny development forwards. Your kind of argumentation is more than (well,=
 I am missing the right adjective for what I feel).
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
