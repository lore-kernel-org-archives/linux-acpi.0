From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] dell-laptop: Use buffer with 32-bit physical address
Date: Thu, 22 Oct 2009 02:57:23 +0100
Message-ID: <20091022015723.GA14946@srcf.ucam.org>
References: <DFEF91B22ED07447AB6AA4B237F913F9039D0A64@ausx3mpc125.aus.amer.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:48526 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753159AbZJVB5Z (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Oct 2009 21:57:25 -0400
Content-Disposition: inline
In-Reply-To: <DFEF91B22ED07447AB6AA4B237F913F9039D0A64@ausx3mpc125.aus.amer.dell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stuart_Hayes@Dell.com
Cc: linux-acpi@vger.kernel.org, Rezwanul_Kabir@Dell.com

On Wed, Oct 21, 2009 at 02:04:09PM -0500, Stuart_Hayes@Dell.com wrote:
> 
> Calls to communicate with system firmware via a SMI (using dcdbas) need
> to use a buffer that has a physical address of 4GB or less.  Currently
> the dell-laptop driver does not guarantee this, and when the buffer
> address is higher than 4GB, the address is truncated to 32 bits and the
> SMI handler writes to the wrong memory address.
> 
> Signed-off-by: Stuart Hayes <stuart_hayes@dell.com>

It looks like you've got a printk in there that should be dropped, but 
if you resubmit without that then feel free to add

Acked-by: Matthew Garrett <mjg@redhat.com>

-- 
Matthew Garrett | mjg59@srcf.ucam.org
