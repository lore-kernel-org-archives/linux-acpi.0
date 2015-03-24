From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [Xen-devel] 3.18 xen-pcifront regression?
Date: Tue, 24 Mar 2015 18:31:39 -0500
Message-ID: <CAErSpo46hAg7kfEZ9hiNFP1jr=-_L55_iNd0RXXBcO-10G1fDQ@mail.gmail.com>
References: <OF77E25ED8.9CA80CE3-ON85257E12.004F7B31-85257E12.0053B9A0@gdeb.com>
 <20150324152806.GD14418@l.oracle.com> <20150324172702.GC2495@google.com> <OF3F22FEC8.8B4BEFD3-ON85257E12.007A8088-85257E12.007B5FAC@gdeb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qg0-f51.google.com ([209.85.192.51]:35350 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751874AbbCXXcA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Mar 2015 19:32:00 -0400
Received: by qgh3 with SMTP id 3so5854761qgh.2
        for <linux-acpi@vger.kernel.org>; Tue, 24 Mar 2015 16:31:59 -0700 (PDT)
In-Reply-To: <OF3F22FEC8.8B4BEFD3-ON85257E12.007A8088-85257E12.007B5FAC@gdeb.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michael D Labriola <mlabriol@gdeb.com>
Cc: Jayson A Dyke <jdyke@gdeb.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, michael.d.labriola@gmail.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Stuart Wehrly <swehrly@gdeb.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>

On Tue, Mar 24, 2015 at 5:27 PM, Michael D Labriola <mlabriol@gdeb.com> wrote:
> Bjorn Helgaas <bhelgaas@google.com> wrote on 03/24/2015 01:27:02 PM:

>> Thanks for the report, Michael, and sorry for the inconvenience.  I
> think
>> the patch below will fix it, but I don't think it's the right fix either
>> because it seems a little ad hoc to sprinkle "acpi_pci_disabled" tests
>> around like fairy dust.  I wonder if we can set things up so ACPI
> methods
>> would fail gracefully like they do when ACPI is disabled at
> compile-time.
>>
>> I can boot with "acpi=off" on qemu just fine, and when we look up the
> ACPI
>> device handles, we just get NULL pointers, so everything works out even
>> without a fix like the one below.
>
> FYI, I'm not passing "acpi=off" on the guest's command line...  I believe
> it's getting turned off dynamically by the guest kernel.  I get the
> following in dmesg within the 1st dozen lines:
>
> ACPI in unprivileged domain disabled

That's from xen_arch_setup(), which prints it when it calls
disable_acpi().  Booting with "acpi=off" also calls disable_acpi(), so
the effect should be similar.  But of course xen's PCI enumeration is
started a little differently and my guess is that difference is what
leads to this oops.

Bjorn
