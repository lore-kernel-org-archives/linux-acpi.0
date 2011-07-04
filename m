From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [patch]acpi: add missing _OSI strings -- resend
Date: Mon, 4 Jul 2011 14:24:03 +0100
Message-ID: <20110704132402.GA31498@srcf.ucam.org>
References: <1309757000.15392.221.camel@sli10-conroe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:59943 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757402Ab1GDNYN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 4 Jul 2011 09:24:13 -0400
Content-Disposition: inline
In-Reply-To: <1309757000.15392.221.camel@sli10-conroe>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, Andrew Morton <akpm@linux-foundation.org>, "Jarosz, Sebastian" <sebastian.jarosz@intel.com>

On Mon, Jul 04, 2011 at 01:23:20PM +0800, Shaohua Li wrote:

> Linux supports some optional features, but it should notify BIOS about them
> in _OSI method. Currently Linux doesn't notify any, which might make such
> features not work because BIOS doesn't know about them.
> 
> Reported-by: "Jarosz, Sebastian" <sebastian.jarosz@intel.com>
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>

I can't find any systems in my DSDT collection that actually use these, 
but in terms of correctness:

Acked-by: Matthew Garrett <mjg@redhat.com>

-- 
Matthew Garrett | mjg59@srcf.ucam.org
