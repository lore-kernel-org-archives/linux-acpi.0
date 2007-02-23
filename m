From: Len Brown <lenb@kernel.org>
Subject: Re: EC init cleanup patches
Date: Fri, 23 Feb 2007 02:24:19 -0500
Message-ID: <200702230224.19440.lenb@kernel.org>
References: <45DC9091.9050605@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:41325 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752133AbXBWH0N (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 Feb 2007 02:26:13 -0500
In-Reply-To: <45DC9091.9050605@linux.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: linux-acpi@vger.kernel.org

On Wednesday 21 February 2007 13:33, Alexey Starikovskiy wrote:
> Hi,
> Here is the patch series to clean-up init of EC.
> 
> Please test, comment.

> ACPI: EC: enable burst functionality in EC

seems to expose ec_burst_enable(), but nobody calls it --
so the patch has no functional change by itself, yes?

looks like some unrelated cleanups in that patch too.

anybody able to test this out on the samsung box
that had trouble with burst mode?

if we are going to cut over to enabling burst mode by default,
surely we should have a boot-param so the user can set it
to whatever works -- as well as a dmesg indicator so we
can tell what is going on -- like we do for ec_intr=, yes?

thanks, 
-Len

ps. in the patch and mbox format, please include
a Signed-off-by: line in addition to the From: line --
i have to remember to add these manually when they're
not included in what you sent to me, and technically nobody should be adding
a signed-off-by line with somebody elses's name on it...

