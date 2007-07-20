From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: acpi_bus_generate_genetlink_event
Date: Fri, 20 Jul 2007 13:29:23 +0800
Message-ID: <1184909363.5547.5.camel@rzhang1-laptop>
References: <20070719132556.a3fe2303.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:43648 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751338AbXGTF32 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 20 Jul 2007 01:29:28 -0400
In-Reply-To: <20070719132556.a3fe2303.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org

On Fri, 2007-07-20 at 04:25 +0800, Andrew Morton wrote:
> 
> It's quite sad that this uses GFP_ATOMIC.  Because GFP_ATOMIC is quite
> unreliable.
> 
> Is it just not possible to use GFP_KERNEL here?
I thought of this problem before,
but GFP_ATOMIC is required in some cases.

> If _any_ of the callers of this function could have used GFP_KERNEL
> then we
> could at least pass the gfp_t into this function to allow it to use
> the
> stronger form where it can do so.
> 
That makes sense. I'll send an incremental patch soon.

Thanks,
Rui
