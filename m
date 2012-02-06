From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 3/5] ACPI: EC: Add a limited number of repeats after
 false EC interrupts
Date: Mon, 6 Feb 2012 16:27:40 +0000
Message-ID: <20120206162740.GA32061@srcf.ucam.org>
References: <1328545032-21373-1-git-send-email-andi@firstfloor.org>
 <1328545032-21373-4-git-send-email-andi@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:38264 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753003Ab2BFQ1p (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2012 11:27:45 -0500
Content-Disposition: inline
In-Reply-To: <1328545032-21373-4-git-send-email-andi@firstfloor.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>

On Mon, Feb 06, 2012 at 08:17:10AM -0800, Andi Kleen wrote:
> My Acer laptop has a large number of false EC interrupts
> (interrupts when the EC indexed data register protocol is in the wrong
> state, expecting input when we should send output or vice versa)
> It seems the hardware triggers the interrupt before it actually
> sets the right status in the register.

Our EC code is, at this point, a layer of hacks piled on top of other 
hacks. We have various patches that fix some machines and break others 
and a lack of a detailed description of what the driver actually does 
and where it deviates from the specification (and why).

I mention this not because I object to adding more hacks to the pile, 
but because at some point we're really going to need to bite the bullet 
and figure out how Windows deals with this hardware and what we're doing 
differently. That probably means adding ec emulation to qemu.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
