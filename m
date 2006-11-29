From: "Wu, Cody" <cody.wu@intel.com>
Subject: RE: How ACPI is actually implemented?
Date: Wed, 29 Nov 2006 09:22:50 +0800
Message-ID: <3E68BD4534D7FC4995E20ECE949EA0C77EA986@pdsmsx412.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:10558 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S1758599AbWK2BXv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Nov 2006 20:23:51 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Eric Benton <benton71@gmail.com>
Cc: "Yuan, Kein" <kein.yuan@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Hi Eric,
>But, the thing is, I didn't see in any place
>that the actual USB1 device is being associated with the 3rd bit of
>this GPE register block. Is it defined in some other ACPI table or is
>it dectated by the system platform?

This is made stiff in the board hardware layout especially how it
connects onboard USB controller to the ACPI Chipset. You can find the
details illustrations such as which USB port is for which bit in the ICH
spec. 

Best regards,
Cody
-----Original Message-----
From: Eric Benton [mailto:benton71@gmail.com] 
Sent: Tuesday, November 28, 2006 7:37 PM
To: Wu, Cody
Cc: Yuan, Kein; Len Brown; linux-acpi@vger.kernel.org
Subject: Re: How ACPI is actually implemented?

Hi All,


On 11/28/06, Wu, Cody <cody.wu@intel.com> wrote:
> Hi Kein,
>
> >The SCI handler, which will run a GPE handler as you said here,  Who
is
> >belongs to? I mean, is it part of OS? Or BIOS?  ACPI spec seems says
if
> >the OS is ACPI compatible and ACPI was enabled,  EC will trigger SCI,
> >then handled by OS otherwise it will trigger SMI which handled by
BIOS,
> >is this true?
>
> GPE handler is provided by Bios originally in the form of AML. Os's
AcPI
> driver will parse it and link it to SCI interrupt processing. Whether
EC
> will trigger SCI or SMI depends on how you want it to be done as well
as
> what OS you are working with. For OS supporting ACPI it will enable
ACPI
> controller on the chipset and SCI will take precedence over SMI.
>

If we will go back again to the GPEs, In my DSDT (Lenovo Laptop),
under the _GPE scope, there is a method that assigns itself to the 3rd
bit of the GPE register block. It's code is the following:

Method (_L03, 0, NotSerialized)
{
    Notify (\_SB.PCI0.USB1, 0x02)
}

Now, it tells the OSPM to notify the native device driver of the USB1
device to Wake (0x02). But, the thing is, I didn't see in any place
that the actual USB1 device is being associated with the 3rd bit of
this GPE register block. Is it defined in some other ACPI table or is
it dectated by the system platform?

Thanks,
Eric.
