From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: PME via interrupt or SCI mechanism?
Date: Thu, 29 Sep 2011 11:05:38 +0200
Message-ID: <201109291105.38342.rjw@sisk.pl>
References: <20110912171003.GA7939@xanatos> <201109290021.28407.rjw@sisk.pl> <20110929014019.GA6144@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110929014019.GA6144@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thursday, September 29, 2011, Matthew Garrett wrote:
> On Thu, Sep 29, 2011 at 12:21:28AM +0200, Rafael J. Wysocki wrote:
> 
> > Moreover, evidently, the event is signaled and it causes pci_acpi_wake_dev()
> > to be called for multiple devices, _except_ for the xhci_hcd.  Perhaps
> > the notifier is not installed for that device for some reason.
> 
> I suspect that we're just going to end up accepting defeat and having to 
> poll *all* pci devices (including pcie) once a second.

Well, this case actually looks like a subtle bug in ACPICA.  I think we
need to debug it further before deciding anything.

Thanks,
Rafael
