From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [Patch v7 4/7] PCI/ACPI add interface to acpi_pci
Date: Sun, 8 Nov 2015 20:40:45 +0800
Message-ID: <563F42CD.9000602@linux.intel.com>
References: <563CE870.3040901@arm.com> <20151106185510.GA10672@red-moon>
 <563D111D.80404@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:38894 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751423AbbKHMks (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 8 Nov 2015 07:40:48 -0500
In-Reply-To: <563D111D.80404@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeremy Linton <jeremy.linton@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Tomasz Nowicki <tomasz.nowicki@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, G Gregory <graeme.gregory@linaro.org>

On 2015/11/7 4:44, Jeremy Linton wrote:
> On 11/06/2015 12:55 PM, Lorenzo Pieralisi wrote:
>> Hi Jeremy,
> 
>> As I said, this is certainly confusing. AFAICT, I read "secondary bus"
>> as secondary bus side of the PCI bridge, I agree there is a mismatch
>> in the ACPI specs between the WordIo specification and the actual
>> Resource descriptors, reading page 366, for an IO resource descriptor,
>> _TTP:
>>
>> Bit [4] I/O to Memory Translation, _TTP
>> 1 TypeTranslation: This resource, which is I/O on the secondary
>>            side of the bridge, is memory on the primary side
>>            of the bridge.
>> 0 TypeStatic: This resource, which is I/O on the secondary side of the
>>           bridge, is also I/O on the primary side of the bridge.
>>
>> Then (19.6.33):
> 
>> That reads the other way around :), which one is correct ?
> 
>     Well, I just read it for the two hundredth time today, and I'm back
> to my original position this morning before posting that BS above, that
> "secondary" refers to the device directed side, and primary is the
> processor directed side.
> 
>     For sure its made confusing by the link to the table 6-213, which
> says basically the opposite of what is said in table 6-214. The
> difference being that 6-214 is for IO regions (and what we are
> discussing, and the link in the 6.0 docs is wrong, probably because both
> tables were on the same page in 5.x).
> 
>     So your probably right, and the juno is incorrect. That said, I
> suspect we aren't the only ones, as i tested the juno against the RHEL
> release which has PCI/ACPI in it (running against all the ARM64 servers,
> AFAIK), and it was doing the right thing given the juno tables. <sigh>
> Which back when I was doing them, initially I created the resource with
> the base address=0, len=7FFFFF and the translate = 5f800000, but it
> didn't work.
> 
>     Can someone give us a dwordio example from an IA64 machine?
> 
>     But, after reading it over and over, I still don't see how the _TTP
> bit changes the way the translation is done... The TranslationDensity,
> yes, but that is set to dense for the two examples so far. Its really in
> my mind a question of whether the translate is added or subtracted,
> which comes down to which direction primary and secondary refer to.
Hi Jeremy and Lorenzo,
	The ACPI spec is really confusion. I think the issue comes from
the truth that TypeTranslation may be used for both IO port -> MMIO
translation and MMIO -> IO Port translation, but the explanation of
TypeTranslation only covers one direction. If we look at the Extended
Address Space Descriptor, it may give some hints about how to interpret
TypeTranslation.
	About the relationship between _TTP and translation_offset,
we need to first define the context. From hardware point of view,
_TTP doesn't affect the way, primary_side_address always equals to
secondary_side_address + translation_offset.
	From software(linux kernel) point of view, it becomes
complicated. There's only one ACPI DWordIO resource descriptor for
each IO port range, but Linux kernel needs two resource type of
resource objects to support IO port on IA64 and ARM64:
1) An IO port resource object, so PCI devices could allocate IO ports
   from this resource object.
2) An MMIO resource object, which is used to map IO port address into
   MMIO address space.
	So we need make a choice when parsing a DWordIO resource
descriptor with _TTP set as:
a) Translate it into an Linux IO port resource object
b) Translate it into an Linux MMIO resource object
	My recommended choice is a) becomes that will make thing
simpler. That is, the arch independent code will always translate an
ACPI DWordIO resource descriptor into an Linux IO port resource object
no matter _TTP is set or not. And arch specific code will create
an Linux MMIO resource object for b) iff _TTP is set. If we adopt
above design, translation_offset will be used as:
if (_TTP is set) {
   linux_mmio_res->start = acpi_desc->start + acpi_desc->translation_offset;
    linux_ioport_res->start = acpi_desc->start;
} else {
   linux_ioport_res->start = acpi_desc->start +
acpi_desc->translation_offset;
   //linux_mmio_res is not needed
}

To summarize, _TTP doesn't affect address translation from hardware
point of view; but it does matter from software point of view.
Thanks,
Gerry
