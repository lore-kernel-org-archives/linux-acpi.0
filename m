From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [Linux-nvdimm] [PATCH 03/21] nd_acpi: initial core
 implementation and nfit skeleton
Date: Tue, 28 Apr 2015 05:53:05 -0700
Message-ID: <20150428125305.GB30852@infradead.org>
References: <20150418013256.25237.96403.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150418013530.25237.28383.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:33830 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965465AbbD1MxG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 28 Apr 2015 08:53:06 -0400
Content-Disposition: inline
In-Reply-To: <20150418013530.25237.28383.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@ml01.01.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, linux-kernel@vger.kernel.org

On Fri, Apr 17, 2015 at 09:35:30PM -0400, Dan Williams wrote:
> new file mode 100644
> index 000000000000..5fa74f124b3e
> --- /dev/null
> +++ b/drivers/block/nd/Kconfig
> @@ -0,0 +1,44 @@
> +config ND_ARCH_HAS_IOREMAP_CACHE
> +	depends on (X86 || IA64 || ARM || ARM64 || SH || XTENSA)
> +	def_bool y

As mentioned before please either define this symbol in each
arch Kconfig, or just ensure every architecture proides a stub.

But more importantly it doesn't seem like you're actually using
ioremap_cache anywhere.  Allowing a cached ioremap would be a very
worthwile addition to the pmem drivers once we have the proper
memcpy functions making it safe, and is one of the high priority
todo items for the pmem driver.

> +
> +menuconfig NFIT_DEVICES
> +	bool "NVDIMM (NFIT) Support"

Please just call all the symbolc and file names nvdimm instead of nfit
or nd to make eryones life simpler for the generic code.  Just use the
EFI/ACPI terminology in those parts that actually parse those tables.
