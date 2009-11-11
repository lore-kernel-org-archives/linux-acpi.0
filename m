From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] pci: Updates to Rafael's runtime PCI PM patch set
Date: Wed, 11 Nov 2009 20:05:03 +0000
Message-ID: <20091111200503.GA22328@srcf.ucam.org>
References: <200910090051.50932.rjw@sisk.pl> <1257806529-6535-1-git-send-email-mjg@redhat.com> <200911112058.20331.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:50235 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755129AbZKKUFf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 Nov 2009 15:05:35 -0500
Content-Disposition: inline
In-Reply-To: <200911112058.20331.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, jbarnes@virtuousgeek.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, stern@rowland.harvard.edu, shaohua.li@intel.com, bjorn.helgaas@hp.com

On Wed, Nov 11, 2009 at 08:58:20PM +0100, Rafael J. Wysocki wrote:

> The PME was supposed to be turned on by pci_prepare_to_sleep().
> I guess it wasn't in practice?

Only if the device is set as a wakeup device, which seems messy. Though 
there may need to be a check there to avoid duplicate PME setup.

> Generally, some parts of it belong to the
> "PCI PM: Run-time callbacks for PCI bus type" patch and the others belong
> to "PCI / ACPI PM: Platform support for PCI PME wake-up" patch.  Should I fold
> the changes into them?

Feel free!

-- 
Matthew Garrett | mjg59@srcf.ucam.org
