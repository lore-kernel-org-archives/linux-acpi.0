From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] Adding_write_support_to_trip_points
Date: Tue, 26 Oct 2010 05:00:43 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010260457100.11036@localhost.localdomain>
References: <1288122410-3215-1-git-send-email-durgadoss.r@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173009pub.verizon.net ([206.46.173.9]:64692 "EHLO
	vms173009pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092Ab0JZJAv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Oct 2010 05:00:51 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173009.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAW00GSD3PAZA42@vms173009.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Tue, 26 Oct 2010 04:00:49 -0500 (CDT)
In-reply-to: <1288122410-3215-1-git-send-email-durgadoss.r@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: durgadoss.r@intel.com
Cc: alan@linux.intel.com, rui.zhang@intel.com, linux-acpi@vger.kernel.org, ramesh.agarwal@intel.com, len.brown@intel.com

On Wed, 27 Oct 2010, durgadoss.r@intel.com wrote:

> From: R.Durgadoss <durgadoss.r@intel.com>
> 
> This patch makes the thermal trip points 'write'able.
> Thus, enabling the trip points to be configured at runtime.
> Please review and apply.

We've been through this with ACPI, and the decision was NOT
to allow writable trip points.

The reason is that the FIRMWARE is responsible for deciding when
to notify Linux if when a trip point actually trips -- and if the
firmware doesn't know that your trip point has moved, then
its notifications effectively become random, and the user
has been fooled into thinking that the trip point they moved
actually does something, when it may do nothing.

The only way to fix that is to POLL, and nobody likes polling.
Thus, no writable trip points.

thanks,
-Len Brown, Intel Open Source Technology Center.
