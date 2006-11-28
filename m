From: "Eric Benton" <benton71@gmail.com>
Subject: Re: How ACPI is actually implemented?
Date: Tue, 28 Nov 2006 13:37:15 +0200
Message-ID: <29545330611280337s9c4ed10sb00d2ad97eac6eb@mail.gmail.com>
References: <3E68BD4534D7FC4995E20ECE949EA0C77EA34E@pdsmsx412.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.174]:181 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S935871AbWK1LhR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Nov 2006 06:37:17 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1448200uga
        for <linux-acpi@vger.kernel.org>; Tue, 28 Nov 2006 03:37:16 -0800 (PST)
In-Reply-To: <3E68BD4534D7FC4995E20ECE949EA0C77EA34E@pdsmsx412.ccr.corp.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Wu, Cody" <cody.wu@intel.com>
Cc: "Yuan, Kein" <kein.yuan@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Hi All,


On 11/28/06, Wu, Cody <cody.wu@intel.com> wrote:
> Hi Kein,
>
> >The SCI handler, which will run a GPE handler as you said here,  Who is
> >belongs to? I mean, is it part of OS? Or BIOS?  ACPI spec seems says if
> >the OS is ACPI compatible and ACPI was enabled,  EC will trigger SCI,
> >then handled by OS otherwise it will trigger SMI which handled by BIOS,
> >is this true?
>
> GPE handler is provided by Bios originally in the form of AML. Os's AcPI
> driver will parse it and link it to SCI interrupt processing. Whether EC
> will trigger SCI or SMI depends on how you want it to be done as well as
> what OS you are working with. For OS supporting ACPI it will enable ACPI
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
