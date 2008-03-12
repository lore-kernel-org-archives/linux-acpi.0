From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 2/4] ACPI: video: prevent ACPI video actions upondisplay switch notifications
Date: Wed, 12 Mar 2008 18:09:58 +0000
Message-ID: <20080312180958.GA29487@srcf.ucam.org>
References: <1201243677.4663.18.camel@acpi-sony.sh.intel.com> <1205281262.8194.58.camel@linux-2bdv.site> <1205284888.8194.72.camel@linux-2bdv.site> <1205290380.2240.41.camel@acpi-hp-zz.sh.intel.com> <1205338005.29877.247.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:42305 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbYCLSKQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Mar 2008 14:10:16 -0400
Content-Disposition: inline
In-Reply-To: <1205338005.29877.247.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: "Zhang, Rui" <rui.zhang@intel.com>, lenb <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, linux-gfx@linux.intel.com

On Wed, Mar 12, 2008 at 05:06:45PM +0100, Thomas Renninger wrote:

> Above was not from myself, but copied out from the bug.
> The guy(s) complained that DOS=0 now breaks their machines...
> I try to find some time to look at this a bit deeper and will then
> comment in the bug (can take some time...).
> IMO recent HPs can/should be taken as a reference as they tend to stick
> to the ACPI spec closely.

Setting my HP 2510p to a DOS of 0 leaves it smashing CPU state on every 
other lid open event, so I suspect it's not tested at all. I'd lean 
towards saying that the kernel default should probably be 1, with 
userspace altering that as appropriate.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
