From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V3 1/3] x86/ioapic: Support hot-removal of IOAPICs present during boot
Date: Fri, 10 Jun 2016 15:56:24 +0200
Message-ID: <47298553.oybh2YTvtj@vostro.rjw.lan>
References: <1465369193-4816-2-git-send-email-rui.y.wang@intel.com> <1465378364-5982-1-git-send-email-rui.y.wang@intel.com> <alpine.DEB.2.11.1606101456520.5839@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <alpine.DEB.2.11.1606101456520.5839@nanos>
Sender: linux-kernel-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Rui Wang <rui.y.wang@intel.com>, tony.luck@intel.com, bhelgaas@google.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Friday, June 10, 2016 02:57:52 PM Thomas Gleixner wrote:
> On Wed, 8 Jun 2016, Rui Wang wrote:
> 
> > v3: Previous versions break mips. This version fixes it.
> > 
> > IOAPICs present during system boot aren't added to ioapic_list,
> > thus are unable to be hot-removed. Fix it by calling
> > acpi_ioapic_add() during root bus enumeration.
> 
> Who will pick that one up? I already took 2/3 of this series as they are
> independent.

I can pick it up.

Thanks,
Rafael
