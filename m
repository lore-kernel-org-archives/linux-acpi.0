From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 2/5] ACPI, APEI, Fix acpi_pre_map() return value
Date: Tue, 21 Sep 2010 14:47:46 +0200
Message-ID: <20100921124746.GF18991@one.firstfloor.org>
References: <1284865235-29920-1-git-send-email-ying.huang@intel.com> <1284865235-29920-3-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:56897 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753229Ab0IUMrr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Sep 2010 08:47:47 -0400
Content-Disposition: inline
In-Reply-To: <1284865235-29920-3-git-send-email-ying.huang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, Jin Dongming <jin.dongming@np.css.fujitsu.com>

On Sun, Sep 19, 2010 at 11:00:32AM +0800, Huang Ying wrote:
> From: Jin Dongming <jin.dongming@np.css.fujitsu.com>
> 
> After we ioremap() a new region, we call __acpi_try_ioremap() to
> see whether another thread has already mapped the same region.
> This check clobbers "vaddr",  so compute the return value of
> acpi_pre_map() using the ioremap() result "map->vaddr" instead.
> 
> v2:
>     Modified the unsuitable description of patch.
> 
> v3:
>     Removed unlikely() check and made description simpler.

Reviewed-by: Andi Kleen <ak@linux.intel.com>

-Andi
