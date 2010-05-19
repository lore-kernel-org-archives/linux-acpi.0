From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH 1/3] ACPI: Ignore the upper bits of SystemIO addresses
Date: Wed, 19 May 2010 17:27:02 +0100
Message-ID: <20100519162702.GB25719@srcf.ucam.org>
References: <1274283791-3380-1-git-send-email-mjg@redhat.com> <201005191018.46799.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:52572 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241Ab0ESQ1N (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 May 2010 12:27:13 -0400
Content-Disposition: inline
In-Reply-To: <201005191018.46799.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org, robert.moore@intel.com, lenb@kernel.org

On Wed, May 19, 2010 at 10:18:46AM -0600, Bjorn Helgaas wrote:

> I think this is a good idea.  But it makes me a little bit nervous
> to change addresses supplied by the firmware without any user-visible
> indication at all.  Is it worth doing a WARN_ONCE() sort of thing
> when we truncate?

That doesn't seem unreasonable, but do we have anything equivalent to 
that in the acpica code right now?

> I know you experimented quite a bit to confirm that Windows does this
> sort of masking.  Do you have any notes about that experimentation
> that would be useful to add to the bugzilla?

Sure. I'll do that.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
