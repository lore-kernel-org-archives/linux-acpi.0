From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH_v8 1/2] IPMI/ACPI: Define acpi_ipmi notifier hook
	functions
Date: Tue, 27 Jul 2010 14:22:39 +0100
Message-ID: <20100727132239.GA25190@srcf.ucam.org>
References: <1280155565-2938-1-git-send-email-yakui.zhao@intel.com> <1280155565-2938-2-git-send-email-yakui.zhao@intel.com> <201007261052.04772.bjorn.helgaas@hp.com> <4C4E340E.3050003@acm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:34622 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752631Ab0G0NW6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 27 Jul 2010 09:22:58 -0400
Content-Disposition: inline
In-Reply-To: <4C4E340E.3050003@acm.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Corey Minyard <minyard@acm.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, yakui.zhao@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org, openipmi-developer@lists.sourceforge.net

On Mon, Jul 26, 2010 at 08:19:10PM -0500, Corey Minyard wrote:

> I agree that a notifier framework seems like massive overkill for this  
> interface.  I will note that there are already interfaces for  
> registering to receive callbacks when an IPMI device is added or  
> removed.  What's missing is a way to ask "Is this an ACPI PNP device?".

So we just want something that returns addr_source, along with moving 
that enum into a global header?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
