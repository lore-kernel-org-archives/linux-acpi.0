From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH]: ACPI: Skip the first two elements in the _BCL package
Date: Wed, 4 Feb 2009 06:08:20 +0000
Message-ID: <20090204060820.GB28321@srcf.ucam.org>
References: <1233545621.3715.42.camel@localhost.localdomain> <200902031456.39680.trenn@suse.de> <1233712213.3684.46.camel@localhost.localdomain> <alpine.LFD.2.00.0902032319280.5607@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:41440 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750892AbZBDGI0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Feb 2009 01:08:26 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0902032319280.5607@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: yakui_zhao <yakui.zhao@intel.com>, Thomas Renninger <trenn@suse.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>

On Tue, Feb 03, 2009 at 11:25:45PM -0500, Len Brown wrote:

> per my previous e-mail, i would recommend that if we export them
> to user-space, that we allow user-space to override them
> and have the kernel simply consume them.  That way things
> would work normall even if user-space is ignorant.

I'm not sure how this would be useful. The kernel doesn't perform the 
ac/dc brightness change - that's handled by either the firmware or 
userspace (depending on _DOS bit 2). We can't provide new values to the 
firmware.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
