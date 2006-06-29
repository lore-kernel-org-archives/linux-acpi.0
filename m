From: "Li, Shaohua" <shaohua.li@intel.com>
Subject: RE: Re: [patch 11/18] pnpacpi: reject ACPI_PRODUCER resources
Date: Thu, 29 Jun 2006 20:41:07 +0800
Message-ID: <8BF50482CE9EE245902340E0724784D59B95F2@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:49721 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1750745AbWF2Ml7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Jun 2006 08:41:59 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Uwe Bugla <uwe.bugla@gmx.de>, bjorn.helgaas@hp.com
Cc: linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>, akpm@osdl.org, ambx1@neo.rr.com, castet.matthieu@free.fr



>-----Original Message-----
>From: Uwe Bugla [mailto:uwe.bugla@gmx.de]
>Sent: Thursday, June 29, 2006 8:24 PM
>To: Li, Shaohua; bjorn.helgaas@hp.com
>Cc: linux-acpi@vger.kernel.org; Brown, Len; akpm@osdl.org; ambx1@neo.r=
r.com;
>castet.matthieu@free.fr
>Subject: Re: Re: [patch 11/18] pnpacpi: reject ACPI_PRODUCER resources
>
>
>-------- Original-Nachricht --------
>Datum: Thu, 29 Jun 2006 09:13:36 +0800
>Von: Shaohua Li <shaohua.li@intel.com>
>An: Bjorn Helgaas <bjorn.helgaas@hp.com>
>Betreff: Re: [patch 11/18] pnpacpi: reject ACPI_PRODUCER resources
>
>> On Wed, 2006-06-28 at 10:55 -0600, Bjorn Helgaas wrote:
>> > On Tuesday 27 June 2006 19:02, Shaohua Li wrote:
>> > > On Tue, 2006-06-27 at 14:02 +0200, castet.matthieu@free.fr wrote=
:
>> > > > Is only PNP0A03 is producer type in __all__ ACPI possible devi=
ces ?
>> > > > If not we will have the same problem with others devices...
>> > > >
>> > > > I don't think blacklist is the solution : pnpacpi should be ab=
le to
>> handle all
>> > > > ressources types : we should complete the implementation inste=
ad of
>> blacklist
>> > > > devices our implementation doesn't support.
>> > > >
>> > > > If there are broken ACPI bios, there should be firmware update=
, a
>> patched dsdt
>> > > > or a quirk, but no "quirk and no generic solution".
>> >
>> > > From my understanding, if the device is really a PNP device its
>> resource
>> > > should not be producer.
>> >
>> > I know PNP as currently implemented doesn't support resource produ=
cers.
>> > But I don't think of that as a restriction of PNP itself.  I think=
 of
>> > it as an area where a new back end (PNPACPI) added functionality, =
and
>> > PNP should be enhanced to comprehend it.
>> Ok, it's fine ACPI PNP handles resource producers.
>>
>> > I think the current scheme where some devices are claimed using
>> > PNPACPI and pnp_register_driver(), and others are claimed using
>> > acpi_bus_register_driver() directly, is confusing at best.
>> >
>> > I'd rather have ALL devices handled by PNPACPI, and either extend
>> > the PNP infrastructure to comprehend the new functionality of ACPI
>> > (e.g., new resource types like PCI bus numbers, ACPI events), or
>> > maybe just provide a "to_acpi_dev()" that takes a PNP device and
>> > returns the corresponding ACPI device.
>Hi Shaohua,
>> That's a big deal. We had a lot of discussions about this like
>> introducing ACPI bus, but frankly there isn't a solid direction whic=
h
>> bus ACPI devices should belong to.
>Where is the deeper sense of this discussion as long as the AS-IS-STAT=
E
>conforms to a multiplicity of busses like ISA, PCI, AGP, please?
>And why please didn=B4t you mix yourself in at an earlier point of tim=
e?
>And why don=B4t you offer more profound material and information on th=
e
>conflicts you saw on your IA64 architecture?
I just took one ia64 box I ever saw as an example, but it's not unique =
to ia64 I think.

>I simply have big problems understanding the attitude behind your beha=
viour.
Me too :)

>> > > Or could we take this way, merge both patches (both patches are =
good
>> to
>> > > me), which should be safer. Anyway, it doesn't make sense to exp=
ort
>> root
>> > > bridge to pnp layer to me.
>> >
>> > One reason I don't like the blacklist is because it just papers ov=
er
>> > the problem without leaving a clue about how to really solve it.
>> > For example, if PNP is enhanced later to comprehend resource produ=
cers,
>> > we won't know to go back and remove things from the blacklist.
>> So lets have a note there. It (no blacklist) is meaningful to have a=
ll
>> ACPI devices handled by PNP layer, but currently not.
>In how far "currently not", please? At what point of time will this ma=
ke
>sense according to your opinion?
>> We don't expect a PNP driver for root bridge.
>> And we will take risk of buggy BIOS.
>What please has a buggy BIOS to do with a more cryptic or more
>sophisticated ACPI PNP concept?
I want to emphasize I have no objection to merge the producer patch now=
 but still think root bridge should be black list.

Thanks,
Shaohua
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
