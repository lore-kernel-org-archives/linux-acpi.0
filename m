From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 00/14] _OSC simplification
Date: Sat, 7 Sep 2013 07:59:39 -0600
Message-ID: <CAErSpo4YRS3-EC5NcFVyi-yBbEX2Fmr0G=Vt2pk_SO7+5Ad91A@mail.gmail.com>
References: <20130906171010.11482.34235.stgit@bhelgaas-glaptop> <16818914.Hl8YjzUdJi@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:59996 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750991Ab3IGOAA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 7 Sep 2013 10:00:00 -0400
Received: by mail-ie0-f172.google.com with SMTP id c10so9273295ieb.31
        for <linux-acpi@vger.kernel.org>; Sat, 07 Sep 2013 06:59:59 -0700 (PDT)
In-Reply-To: <16818914.Hl8YjzUdJi@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Fri, Sep 6, 2013 at 6:01 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday, September 06, 2013 11:13:24 AM Bjorn Helgaas wrote:
>> This is a long series of mostly minor changes with the goal of
>> simplifying the _OSC-related code and making the negotiation between
>> Linux and the platform more understandable.
>>
>> My intent is that this doesn't change any behavior except for the text
>> in dmesg.
>>
>> However, this restructuring does raise some questions in my mind, such
>> as the fact that we do not call pcie_no_aspm() to disable ASPM in two
>> cases where it seems like we might want to:
>>
>>   1) When pcie_ports_disabled, e.g., when booting with
>>      "pcie_ports=compat".
>>
>>   2) When Linux doesn't support all the required services, e.g., if
>>      compiled with ASPM support but not MSI support.
>
> We tried that (i.e. 2)), but then it caused energy usage to increase on some
> systems with power-hungry graphics adapters and Phoronix made some fuss about
> that. :-)

The _OSC section of the spec is pretty obtuse, but my reading of Table
4-6 (PCI Firmware r3.0) is that the OS is prohibited from writing to
the PCIe Capability (for ASPM, VC, AER, or other control) unless it
has been granted "PCI Express Capability Structure control".  That's
why I'm dubious about the fact that we use ASPM in those two cases
where we don't even *ask* for that control.

For the Phoronix case, I assume they made the argument that Windows
does use ASPM without having PCIe Capability control?  Do you have any
pointers to that discussion?

I don't propose changing this now, but it does raise my eyebrows.
Maybe some sort of dmesg note would be appropriate.

Thanks for looking at all this stuff; I know from experience that it's
pretty hard to wade through :)

Bjorn
