From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v3 5/5] ACPI: ARM64: support for ACPI_TABLE_UPGRADE
Date: Tue, 14 Jun 2016 17:41:16 +0100
Message-ID: <20160614164116.GF16531@arm.com>
References: <20160527171424.GG10909@e104818-lin.cambridge.arm.com>
 <20160602174910.30428-1-aleksey.makarov@linaro.org>
 <02dde480-cc01-6372-5baa-02ecf0037074@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:60107 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751371AbcFNQlU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Jun 2016 12:41:20 -0400
Content-Disposition: inline
In-Reply-To: <02dde480-cc01-6372-5baa-02ecf0037074@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aleksey Makarov <aleksey.makarov@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Graeme Gregory <graeme.gregory@linaro.org>, Jon Masters <jcm@redhat.com>, "Zheng, Lv" <lv.zheng@intel.com>, Mark Rutland <mark.rutland@arm.com>

On Tue, Jun 14, 2016 at 06:51:19PM +0300, Aleksey Makarov wrote:
> 
> On 06/02/2016 08:49 PM, Aleksey Makarov wrote:
> > From: Jon Masters <jcm@redhat.com>
> > 
> > This patch adds support for ACPI_TABLE_UPGRADE for ARM64
> 
> Hi Catalin, Will,
> 
> Can you review this v3 patch please?  I changed PFN_PHYS(max_pfn) to
> MEMBLOCK_ALLOC_ACCESSIBLE.

I'm inclined to agree with Mark that this is something that should be
done by the bootloader (e.g. GRUB) if it's needed, rather than something
we should support in the kernel. Jon pitched the feature as a developer
aid for triaging problems, so it's not like we're in a state where some
widely available machine cannot currently boot Linux without this.

Having said that, the patch isn't exactly invasive and I suspect it's
only a matter of time before we will actually want something like this.
So I've come full circle on this patch:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
