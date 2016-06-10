From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V3 1/3] x86/ioapic: Support hot-removal of IOAPICs present
 during boot
Date: Fri, 10 Jun 2016 14:57:52 +0200 (CEST)
Message-ID: <alpine.DEB.2.11.1606101456520.5839@nanos>
References: <1465369193-4816-2-git-send-email-rui.y.wang@intel.com> <1465378364-5982-1-git-send-email-rui.y.wang@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1465378364-5982-1-git-send-email-rui.y.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rui Wang <rui.y.wang@intel.com>
Cc: rjw@rjwysocki.net, tony.luck@intel.com, bhelgaas@google.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, 8 Jun 2016, Rui Wang wrote:

> v3: Previous versions break mips. This version fixes it.
> 
> IOAPICs present during system boot aren't added to ioapic_list,
> thus are unable to be hot-removed. Fix it by calling
> acpi_ioapic_add() during root bus enumeration.

Who will pick that one up? I already took 2/3 of this series as they are
independent.

Thanks,

	tglx

 
