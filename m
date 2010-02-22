From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] ACPI video: Be more liberal in validating _BQC behaviour
Date: Mon, 22 Feb 2010 18:24:16 +0100
Message-ID: <201002221824.16920.trenn@suse.de>
References: <1266357230-10602-1-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:44294 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752199Ab0BVRYT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Feb 2010 12:24:19 -0500
In-Reply-To: <1266357230-10602-1-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-acpi@vger.kernel.org, lenb@kernel.org, rui.zhang@intel.com

On Tuesday 16 February 2010 22:53:50 Matthew Garrett wrote:
> Right now, if _BQC returns a value we don't understand we immediately
> invalidate it. Change this behaviour so we only invalidate it if it
> continues to give an invalid answer after we've already set a brightness.
> 
> +			if (!init) {
> +				/*
> +				 * BQC returned an invalid level.
> +				 * Stop using it.
> +				 */
> +				ACPI_WARNING((AE_INFO,
> +					      "%s returned an invalid level",
> +					      buf));
Can you use:
printk(KERN_WARNING FW_WARN "%s returned an invalid level", buf);
instead please.
It would be great if major kernel contributors, especially those working
near the BIOS do make use of the FW_* strings more often!

Cleaning up existing messages is one (work intensive) thing, but please
use it to identify new BIOS issues.

Thanks,

   Thomas
