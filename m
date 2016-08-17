From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 0/5] Fixing a set of bugs for ioapic hotplug
Date: Wed, 17 Aug 2016 02:36:09 +0200
Message-ID: <2854492.7D21TlQXT3@vostro.rjw.lan>
References: <1470801718-29004-1-git-send-email-rui.y.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:56394 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753442AbcHQAaj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Aug 2016 20:30:39 -0400
In-Reply-To: <1470801718-29004-1-git-send-email-rui.y.wang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rui Wang <rui.y.wang@intel.com>
Cc: helgaas@kernel.org, tglx@linutronix.de, tony.luck@intel.com, bhelgaas@google.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org

On Wednesday, August 10, 2016 12:01:53 PM Rui Wang wrote:
> A set of patches fixing bugs found while testing IOAPIC hotplug.

This should have been posted to the x86@kernel.org list too for the benefit
of the maintainers.

Can you please resend it with a CC to that one (and the Bjorn's ACK on the
second patch)?

Thanks,
Rafael


> Changelog:
> 
> Changes from v2 to v3:
> * Rebased on top of 4.8-rc1 per Bjorn & Rafael.
> * Improved the commit message of 0003, w/ clearer explanation.
> 
> Changes from v1 to v2:
> * Split the first patch into two as advised by Bjorn: "would be nicer if
> the interface change and header file munging were in a separate patch so
> they wouldn't obscure the meat of the change, i.e., the addition of calls
> to acpi_ioapic_add()."
> * Removed acpi_ioapic_add() as an exported symbol.
> * Fixed some typos, and s/acpi/ACPI/, s/ioapic/IOAPIC/ throughout.
> * Fixed a warning from 0-day testing.
> 
> Rui Wang (5):
>   x86/ioapic: Change prototype of acpi_ioapic_add()
>   x86/ioapic: Support hot-removal of IOAPICs present during boot
>   x86/ioapic: Fix setup_res() failing to get resource
>   x86/ioapic: Fix lost IOAPIC resource after hot-removal and hotadd
>   x86/ioapic: Fix ioapic failing to request resource
> 
>  drivers/acpi/internal.h |  2 --
>  drivers/acpi/ioapic.c   | 46 ++++++++++++++++++++++++++--------------------
>  drivers/acpi/pci_root.c | 12 +++++++++++-
>  drivers/pci/setup-bus.c |  5 ++++-
>  include/linux/acpi.h    |  6 ++++++
>  5 files changed, 47 insertions(+), 24 deletions(-)

