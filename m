From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [Patch v6 6/7] x86/PCI/ACPI: Use common interface to support PCI
 host bridge
Date: Tue, 6 Oct 2015 13:01:44 -0500
Message-ID: <20151006180144.GC29420@localhost>
References: <1442218057-4355-1-git-send-email-jiang.liu@linux.intel.com>
 <1442218057-4355-7-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54969 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752887AbbJFSBr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 6 Oct 2015 14:01:47 -0400
Content-Disposition: inline
In-Reply-To: <1442218057-4355-7-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Marc Zyngier <marc.zyngier@arm.com>, Hanjun Guo <hanjun.guo@linaro.org>, Liviu Dudau <Liviu.Dudau@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org

On Mon, Sep 14, 2015 at 04:07:35PM +0800, Jiang Liu wrote:
> Use common interface to simplify ACPI PCI host bridge implementation.
> 
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Is there a corresponding ia64 patch?  If we're really consolidating
this code (which I completely support), we need to do the whole job.

> ---
>  arch/x86/pci/acpi.c |  293 +++++++++++++++------------------------------------
>  1 file changed, 86 insertions(+), 207 deletions(-)
