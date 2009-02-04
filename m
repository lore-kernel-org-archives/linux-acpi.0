From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH]: ACPI: Skip the first two elements in the _BCL package
Date: Wed, 4 Feb 2009 06:09:38 +0000
Message-ID: <20090204060938.GC28321@srcf.ucam.org>
References: <1233545621.3715.42.camel@localhost.localdomain> <200902031456.39680.trenn@suse.de> <alpine.LFD.2.00.0902032304060.5607@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:41464 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbZBDGJn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Feb 2009 01:09:43 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0902032304060.5607@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Thomas Renninger <trenn@suse.de>, yakui_zhao <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, rui.zhang@intel.com

On Tue, Feb 03, 2009 at 11:09:26PM -0500, Len Brown wrote:

> I should think that it would be prudent to expose the
> ac and dc defaults to user-space -- allowing user-space
> to over-ride them, and then on ac events doing the
> brightness switch in the kernel.  That way it will work
> even w/o teaching user-space new tricks.

Woah - it's bad enough that we've got hotkey policy in kernel for ACPI 
(and nothing else). Please don't add more policy to the core code - we 
leave that up to userspace for a reason.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
