From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: ACPI device using sub-resource of PCI device
Date: Wed, 18 May 2016 23:25:59 +0200
Message-ID: <CAJZ5v0hh1ve=w590D4XncheNVsrmr7f6k1msdr+dzT4UoUa+JQ@mail.gmail.com>
References: <CAE2855tofJV=HV2dYuC+1=pi2mb942zrRF7f0+wqxPPay44RGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34998 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753531AbcERV0B (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 18 May 2016 17:26:01 -0400
Received: by mail-wm0-f49.google.com with SMTP id r12so53356608wme.0
        for <linux-acpi@vger.kernel.org>; Wed, 18 May 2016 14:26:00 -0700 (PDT)
In-Reply-To: <CAE2855tofJV=HV2dYuC+1=pi2mb942zrRF7f0+wqxPPay44RGA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Durbin <adurbin@google.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Wed, May 18, 2016 at 5:54 PM, Aaron Durbin <adurbin@google.com> wrote:
> Hi,
>
> We're currently running into a problem of resource conflicts with a
> PCI device and ACPI devices.
>
> [    0.243534] pci 0000:00:0d.0: can't claim BAR 0 [mem
> 0xd0000000-0xd0ffffff 64bit]: address conflict with INT3452:03 [mem
> 0xd0c00000-0xd0c03fff]
>
> The PCI BAR covers a large amount mmio resources, however, there are
> ACPI devices with their own HID (for probing) which uses resources
> that are a subset of the PCI BAR.
>
> Short of re-structuring the linux driver is there anything that can be
> done with ASL to properly have the ACPI device use a sub-resource of
> the PCI device during the ACPI/PCI probing?

Do you have an ACPI device object corresponding to the PCI device?
