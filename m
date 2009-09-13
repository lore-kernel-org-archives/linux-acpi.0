From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC][PATCH 1/4] PCI PM: Add function for checking PME status
	of devices
Date: Sun, 13 Sep 2009 23:15:52 +0100
Message-ID: <20090913221552.GB31175@srcf.ucam.org>
References: <200909132320.05077.rjw@sisk.pl> <200909132320.58093.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200909132320.58093.rjw@sisk.pl>
Sender: linux-pci-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Linux PCI <linux-pci@vger.kernel.org>, Len Brown <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Shaohua Li <shaohua.li@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sun, Sep 13, 2009 at 11:20:58PM +0200, Rafael J. Wysocki wrote:

> Add function pci_check_pme_status() that will check the PME status
> bit of given device and clear it along with the PME enable bit.  It
> will be necessary for PCI run-time power management.

I think the comment's slightly misleading - some PCI run-time power 
management will work without any PME code. But that's not terribly 
important.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
