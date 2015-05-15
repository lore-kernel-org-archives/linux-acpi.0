From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: [Linux-nvdimm] [PATCH v2 03/20] nd_acpi, nfit-test: manufactured NFITs for interface development
Date: Fri, 15 May 2015 16:25:34 -0400
Message-ID: <x49pp61wptt.fsf@segfault.boston.devel.redhat.com>
References: <20150428181203.35812.60474.stgit@dwillia2-desk3.amr.corp.intel.com>
	<20150428182428.35812.95800.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47026 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934443AbbEOUZj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 May 2015 16:25:39 -0400
In-Reply-To: <20150428182428.35812.95800.stgit@dwillia2-desk3.amr.corp.intel.com>
	(Dan Williams's message of "Tue, 28 Apr 2015 14:24:29 -0400")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@ml01.01.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> +config NFIT_TEST
> +	tristate "NFIT TEST: Manufactured NFIT for interface testing"
> +	depends on DMA_CMA
> +	depends on LIBND=m
> +	depends on ND_ACPI
> +	depends on m
> +	help
> +	  For development purposes register a manufactured
> +	  NFIT table to verify the resulting device model topology.
> +	  Note, this module arranges for ioremap_cache() to be
> +	  overridden locally to allow simulation of system-memory as an
> +	  io-memory-resource.
> +
> +	  Note, this test expects to be able to find at least 256MB of
> +	  CMA space (CONFIG_CMA_SIZE_MBYTES, cma=) or it will fail to
> +	  load.
> +
> +	  Say N unless you are doing development of the 'nd' subsystem.
> +

Too many TLAs.  I'm guessing CMA means Conventional Memory Area to you.
To me it means contiguous memory allocator.  Anyway, please define
acronyms when you use them, especially in help text.  The help text also
doesn't really explain where it will find this memory.  Would it be
possible to provide more direction there?

I don't have any useful commentary on the patch itself.  I do wonder if
you shouldn't move this to the end, as it's hardly an integral part of
the patch set.

Cheers,
Jeff
