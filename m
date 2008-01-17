From: Matthew Hall <mhall@mhcomputing.net>
Subject: Re: sata_nv does not function in kernel > 2.6.20.21... possible
	ACPI or PCI involvement?
Date: Thu, 17 Jan 2008 19:04:03 +0000
Message-ID: <20080117190403.GA20483@mhcomputing.net>
References: <20080112205939.GA5291@mhcomputing.net> <200801141702.26914.bjorn.helgaas@hp.com> <20080115043804.GA17040@mhcomputing.net> <200801161407.38280.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ip-163-246-113-216.pool.grokthis.net ([216.113.246.163]:1824
	"EHLO mail.mhcomputing.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754502AbYAQTEF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Jan 2008 14:04:05 -0500
Content-Disposition: inline
In-Reply-To: <200801161407.38280.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-pci@atrey.karlin.mff.cuni.cz, linux-acpi@vger.kernel.org

On Wed, Jan 16, 2008 at 02:07:37PM -0700, Bjorn Helgaas wrote:
> Matthew,

Bjorn,

> Can you please try the revised patch below?

It works on my machine! I just had to change the first hunk to get the 
includes to work because your file had a few more includes than mine 
since it was newer code.

> Thanks,
>   Bjorn

Best Regards,
Matthew Hall
