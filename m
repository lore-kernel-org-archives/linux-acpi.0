From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 0/4] ACPI: kill acpi_pci_root_start
Date: Thu, 4 Oct 2012 11:36:15 -0700
Message-ID: <CAE9FiQWDnrk7VccFLLHucCVSxN5RRS0-8pwYazLy2aw3oqmPLQ@mail.gmail.com>
References: <CAE9FiQWgvVqnTTeYFvxf1GxLcEEeRyN-uSKPdg3o69oCpm43sQ@mail.gmail.com>
	<1349305214-3241-1-git-send-email-yinghai@kernel.org>
	<20121004174746.GA24119@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20121004174746.GA24119@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Len Brown <lenb@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Oct 4, 2012 at 10:47 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Wed, Oct 03, 2012 at 04:00:10PM -0700, Yinghai Lu wrote:
> This is a fundamental difference: at boot-time, all the ACPI devices below the
> host bridge already exist before the pci_root.c driver claims the bridge,
> while at hot-add time, pci_root.c claims the bridge *before* those ACPI
> devices exist.
>
> I think this is wrong.  The hot-plug case (where the driver is already
> loaded and binds to the device as soon as it's discovered, before the
> ACPI hierarchy below it is enumerated) seems like the obviously correct
> order.  I think we should change the boot-time order to match that, i.e.,
> we should register pci_root.c *before* enumerating ACPI devices.

in booting path, all device get probed at first, and then register driver...
do you want to register all pci driver before probing pci devices?

Yinghai
