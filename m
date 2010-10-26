From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Adding_write_support_to_trip_points
Date: Tue, 26 Oct 2010 14:22:21 +0100
Message-ID: <20101026132221.GB9221@srcf.ucam.org>
References: <1288122410-3215-1-git-send-email-durgadoss.r@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:55257 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932084Ab0JZNWb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Oct 2010 09:22:31 -0400
Content-Disposition: inline
In-Reply-To: <1288122410-3215-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: durgadoss.r@intel.com
Cc: lenb@kernel.org, alan@linux.intel.com, rui.zhang@intel.com, linux-acpi@vger.kernel.org, ramesh.agarwal@intel.com, len.brown@intel.com

On Wed, Oct 27, 2010 at 01:16:50AM +0530, durgadoss.r@intel.com wrote:
> From: R.Durgadoss <durgadoss.r@intel.com>
> 
> This patch makes the thermal trip points 'write'able.
> Thus, enabling the trip points to be configured at runtime.
> Please review and apply.

If you're going to do this then you need to have a callback to determine 
whether the platform supports this behaviour. ACPI doesn't and writes 
should fail in that case.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
