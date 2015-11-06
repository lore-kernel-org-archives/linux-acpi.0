From: Jeremy Linton <jeremy.linton@arm.com>
Subject: Re: [Patch v7 4/7] PCI/ACPI add interface to acpi_pci
Date: Fri, 6 Nov 2015 14:44:13 -0600
Message-ID: <563D111D.80404@arm.com>
References: <563CE870.3040901@arm.com> <20151106185510.GA10672@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from eu-smtp-delivery-143.mimecast.com ([207.82.80.143]:40876 "EHLO
	eu-smtp-delivery-143.mimecast.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030449AbbKFUoT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 6 Nov 2015 15:44:19 -0500
In-Reply-To: <20151106185510.GA10672@red-moon>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: jiang.liu@linux.intel.com, Tomasz Nowicki <tomasz.nowicki@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, G Gregory <graeme.gregory@linaro.org>

On 11/06/2015 12:55 PM, Lorenzo Pieralisi wrote:
> Hi Jeremy,

> As I said, this is certainly confusing. AFAICT, I read "secondary bus"
> as secondary bus side of the PCI bridge, I agree there is a mismatch
> in the ACPI specs between the WordIo specification and the actual
> Resource descriptors, reading page 366, for an IO resource descriptor,
> _TTP:
>
> Bit [4] I/O to Memory Translation, _TTP
> 1 TypeTranslation: This resource, which is I/O on the secondary
> 		   side of the bridge, is memory on the primary side
> 		   of the bridge.
> 0 TypeStatic: This resource, which is I/O on the secondary side of the
> 	      bridge, is also I/O on the primary side of the bridge.
>
> Then (19.6.33):

> That reads the other way around :), which one is correct ?

	Well, I just read it for the two hundredth time today, and I'm back to 
my original position this morning before posting that BS above, that 
"secondary" refers to the device directed side, and primary is the 
processor directed side.

	For sure its made confusing by the link to the table 6-213, which says 
basically the opposite of what is said in table 6-214. The difference 
being that 6-214 is for IO regions (and what we are discussing, and the 
link in the 6.0 docs is wrong, probably because both tables were on the 
same page in 5.x).

	So your probably right, and the juno is incorrect. That said, I suspect 
we aren't the only ones, as i tested the juno against the RHEL release 
which has PCI/ACPI in it (running against all the ARM64 servers, AFAIK), 
and it was doing the right thing given the juno tables. <sigh> Which 
back when I was doing them, initially I created the resource with the 
base address=0, len=7FFFFF and the translate = 5f800000, but it didn't 
work.

	Can someone give us a dwordio example from an IA64 machine?

	But, after reading it over and over, I still don't see how the _TTP bit 
changes the way the translation is done... The TranslationDensity, yes, 
but that is set to dense for the two examples so far. Its really in my 
mind a question of whether the translate is added or subtracted, which 
comes down to which direction primary and secondary refer to.





