From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] IBM R40e blacklist for C2/C3 states: sort & remove duplicate
Date: Mon, 18 Aug 2008 17:04:49 +0100
Message-ID: <20080818160449.GA27214@srcf.ucam.org>
References: <20080815160657.25828.qmail@serverkommune.de> <200808181710.18456.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:42261 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752727AbYHRQE4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Aug 2008 12:04:56 -0400
Content-Disposition: inline
In-Reply-To: <200808181710.18456.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Thomas Rosner <kernel-bugs@digital-trauma.de>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Andi Kleen <ak@linux.intel.com>

On Mon, Aug 18, 2008 at 05:10:17PM +0200, Thomas Renninger wrote:

> I can repost if people think that the root cause cannot be fixed for .27 
> anymore and above is considered as a workaround that should be taken for now.

The existing workaround (of just disabling C-state transitions on this 
hardware) is fine for .27. We just need to determine how windows chooses 
to use the RSDT over the XSDT. Is it simply that values that are present 
in the XSDT are ignored if they're also in the RSDT?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
