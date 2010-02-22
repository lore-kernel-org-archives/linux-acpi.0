From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI video: Be more liberal in validating _BQC
	behaviour
Date: Mon, 22 Feb 2010 17:38:36 +0000
Message-ID: <20100222173836.GA24808@srcf.ucam.org>
References: <1266357230-10602-1-git-send-email-mjg@redhat.com> <201002221824.16920.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:56419 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344Ab0BVRii (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Feb 2010 12:38:38 -0500
Content-Disposition: inline
In-Reply-To: <201002221824.16920.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, rui.zhang@intel.com

On Mon, Feb 22, 2010 at 06:24:16PM +0100, Thomas Renninger wrote:

> Can you use:
> printk(KERN_WARNING FW_WARN "%s returned an invalid level", buf);
> instead please.
> It would be great if major kernel contributors, especially those working
> near the BIOS do make use of the FW_* strings more often!

I could, but I don't see there being any real benefit in doing so while 
the rest of the file doesn't make use of it. It seems like a reasonable 
thing to do in a followup patch.

> Cleaning up existing messages is one (work intensive) thing, but please
> use it to identify new BIOS issues.

This is just moving an existing warning, rather than adding a new issue.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
