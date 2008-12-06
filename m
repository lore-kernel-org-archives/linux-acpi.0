From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: samsung x360, acpi support
Date: Sat, 6 Dec 2008 16:26:49 +0000
Message-ID: <20081206162649.GA7623@srcf.ucam.org>
References: <200812041915.39971.mheinz@cs.uni-frankfurt.de> <20081206114358.GA4821@srcf.ucam.org> <200812061426.08294.mheinz@cs.uni-frankfurt.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:51191 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146AbYLFQ0v (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 6 Dec 2008 11:26:51 -0500
Content-Disposition: inline
In-Reply-To: <200812061426.08294.mheinz@cs.uni-frankfurt.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthias Heinz <mheinz@cs.uni-frankfurt.de>
Cc: linux-acpi@vger.kernel.org

On Sat, Dec 06, 2008 at 02:26:07PM +0100, Matthias Heinz wrote:
> Am Samstag, 6. Dezember 2008 schrieb Matthew Garrett:
> > Do you have the i915 module loaded? NVID is simply the vendor's name for
> > the ACPI object representing the video controller.
> 
> Its compiled into my kernel. I can add the config of both kernels, if needed. 
> I even compiled the 2.6.28-rc7 kernel with the config of the 2.6.26, but the 
> backlight support didnt work. It looks like its something that changed over 
> the time.

Mm. It could be that the opregion support is now enabled, but you've got 
some kind of interrupt failure. Can you attach the output of 

lspci -vxxx -s 00:02.0 

and

cat /proc/dri/0/i915_gem_interrupt

?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
