From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 11/12] PCI PM: Run-time callbacks for PCI bus type (rev. 2)
Date: Tue, 1 Dec 2009 23:50:13 +0100
Message-ID: <200912012350.13384.rjw@sisk.pl>
References: <200911160047.46299.rjw@sisk.pl> <200911291643.15603.rjw@sisk.pl> <20091201220043.GA17093@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20091201220043.GA17093@srcf.ucam.org>
Sender: linux-pci-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Jesse Barnes <jbarnes@virtuousgeek.org>, Oliver Neukum <oliver@neukum.org>, Shaohua Li <shaohua.li@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, Francois Romieu <romieu@fr.zoreil.com>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 01 December 2009, Matthew Garrett wrote:
> On Sun, Nov 29, 2009 at 04:43:15PM +0100, Rafael J. Wysocki wrote:
> 
> > -	if (enable && !device_may_wakeup(&dev->dev))
> > +	if (enable && runtime && !device_may_wakeup(&dev->dev))
> 
> Should this be !runtime? We only care about device_may_wakeup() in the 
> system suspend case.

Yes, it should, thanks!
