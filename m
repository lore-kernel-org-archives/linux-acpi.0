From: Corey Minyard <minyard@acm.org>
Subject: Re: [PATCH -v6 2/2] IPMI: use ACPI detection mechanism firstly to
 detect IPMI system interface
Date: Wed, 09 Jun 2010 08:08:52 -0500
Message-ID: <4C0F9264.8000008@acm.org>
References: <1275902842-19895-1-git-send-email-yakui.zhao@intel.com>
 <1275902842-19895-2-git-send-email-yakui.zhao@intel.com>
 <1275902842-19895-3-git-send-email-yakui.zhao@intel.com>
 <20100607125213.GA8277@srcf.ucam.org>
 <1275960531.3718.77.camel@localhost.localdomain>
 <20100608013453.GA5167@srcf.ucam.org>
 <1275973808.3718.99.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:41458 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756781Ab0FINJD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 9 Jun 2010 09:09:03 -0400
Received: from wf-rch.minyard.local ([unknown] [173.57.145.237])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0L3R00FE60IT0ZE3@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 09 Jun 2010 08:08:54 -0500 (CDT)
In-reply-to: <1275973808.3718.99.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ykzhao <yakui.zhao@intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, "lenb@kernel.org" <lenb@kernel.org>, "openipmi-developer@lists.sourceforge.net" <openipmi-developer@lists.sourceforge.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Myron Stowe <myron.stowe@hp.com>

ykzhao wrote:
> On Tue, 2010-06-08 at 09:34 +0800, Matthew Garrett wrote:
>  =20
>> On Tue, Jun 08, 2010 at 09:28:51AM +0800, ykzhao wrote:
>>
>>    =20
>>> =EF=BB=BFDoes there exist the ACPI detection mechanism on the machi=
nes you
>>> mentioned? If exists, does it detect the same IPMI interface with t=
he
>>> PCI IPMI detection mechanism?
>>>      =20
>> What is "the same"? It's not using the same ioport space, certainly.
>>    =20
>
> "The same" means that they will use the same ioport space/address.
> If they use the different ioport space/address, they will be regarded=
 as
> the different IPMI device.
>
>  =20
>>> =EF=BB=BFIf the two mechanisms will detect the same IPMI interface,=
 I agree with
>>> what you are concerned.  Do you have an idea/thought to set up the
>>> relationship between ACPI and IPMI interface? In order to enable th=
at
>>> AML code can access the IPMI, it should know which IPMI interface w=
ill
>>> be accessed and create the corresponding user interface. If ACPI
>>> mechanism will fail to register the IPMI interface, maybe it is
>>> difficult to create the correct user interface.
>>>      =20
>> Well, right now if you change the ordering then the PCI interface wi=
ll=20
>> never be exposed. It would be preferable to only expose the ACPI=20
>> interface as a user-visible device if there's no prior device - if t=
here=20
>> is, I think the ideal solution would be for it to be an in-kernel on=
ly=20
>> device without a corresponding UI.
>>    =20
>
> Sorry that I don't explain it clearly. The concept of "user interface=
"
> in IPMI interface is only a channel that can be used to communicate w=
ith
> the IPMI controller. It has no relationship with whether the IPMI
> interface should be exposed to user space. If one driver wants to
> communicate with one IPMI interface, we should create one "user
> interface" firstly and send the corresponding IPMI message by using t=
he
> "user interface".
>
> If one IPMI interface(controller) is already detected by PCI mechanis=
m,
> then ACPI will fail to detect the same IPMI interface. In such case i=
t
> is difficult for ACPI to know which IPMI interface should be accessed
> when the ACPI AML code need to communicate with the IPMI interface.
>  =20
This may all be true, but the IPMI specification clearly gives the=20
detection order.  It's not a good idea to deviate from that without a=20
very good reason.  I'm not sure this is a good enough reason.

Also, the bulk of this code clearly has nothing to do with the system=20
interface itself and should be in its own file.  And is there any reaso=
n=20
to tie this to the SMI code, anyway?  There are plenty of systems with=20
IPMI and ACPI that use I2C or serial ports.  Can they not use this ACPI=
=20
function (even though their drivers are not in the mainstream kernel)?

Can you look and see if there is some other way to detect the ACPI=20
function on a BMC with some other mechanism?  I think that would be=20
better all around.  If it's the same BMC, the I can't imagine it matter=
s=20
if you send the messages via the PCI-detected or ACPI-detected mechanis=
ms.

-corey
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
