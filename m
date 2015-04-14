From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 2/4] PCI: Mark invalid BARs as unassigned
Date: Tue, 14 Apr 2015 18:30:51 -0500
Message-ID: <CAErSpo6PV7+cZKgDPBA7tDn4oyp_hONqJFegTFxVLz2KaTeK4A@mail.gmail.com>
References: <20150312173201.1052.28341.stgit@bhelgaas-glaptop2.roam.corp.google.com>
 <20150312173533.1052.46464.stgit@bhelgaas-glaptop2.roam.corp.google.com> <CA+8MBbJv-RwX_RDzk85X_sHAHUG6cTsCAKd-_iE7wrdQ9wYKsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35176 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752615AbbDNXbX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Apr 2015 19:31:23 -0400
Received: by qkhg7 with SMTP id g7so46565996qkh.2
        for <linux-acpi@vger.kernel.org>; Tue, 14 Apr 2015 16:31:23 -0700 (PDT)
In-Reply-To: <CA+8MBbJv-RwX_RDzk85X_sHAHUG6cTsCAKd-_iE7wrdQ9wYKsQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tony Luck <tony.luck@gmail.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>

Hi Tony,

On Tue, Apr 14, 2015 at 6:14 PM, Tony Luck <tony.luck@gmail.com> wrote:
> On Thu, Mar 12, 2015 at 10:35 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> If a BAR is not inside any upstream bridge window, or if it conflicts with
>> another resource, mark it as IORESOURCE_UNSET so we don't try to use it.
>> We may be able to assign a different address for it.
>
> This went into Linux tree - and broke my ia64 box in a weird way. It only
> sees one of the two disks.  git bisect points to this commit, and reverting
> it fixes the problem.
>
> Attached are serial logs from the "bad" boot (tip of Linus tree = b79013b2449c)
> and for a "good" boot with this commit reverted.

Thanks for the report, and sorry for breaking you.  I hate to ask for
more after all your work already, but would you mind collecting logs
with "ignore_loglevel"?  We only print the BAR information at
KERN_DEBUG, so it doesn't make it to the console unless you use
ignore_loglevel.

I don't really see how the mptsas device at 83:00.0 worked before;
ACPI didn't tell us about any MMIO apertures in the PCI1 host bridge.
But I'll look closer.

Bjorn
