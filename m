From: Paul Bolle <pebolle@tiscali.nl>
Subject: Re: [PATCH 03/21] nd_acpi: initial core implementation and nfit
 skeleton
Date: Sat, 18 Apr 2015 21:41:03 +0200
Message-ID: <1429386063.16771.157.camel@x220>
References: <20150418013256.25237.96403.stgit@dwillia2-desk3.amr.corp.intel.com>
	 <20150418013530.25237.28383.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from lb1-smtp-cloud3.xs4all.net ([194.109.24.22]:36091 "EHLO
	lb1-smtp-cloud3.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753905AbbDRTlI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 18 Apr 2015 15:41:08 -0400
In-Reply-To: <20150418013530.25237.28383.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Robert Moore <robert.moore@intel.com>, linux-kernel@vger.kernel.org

On Fri, 2015-04-17 at 21:35 -0400, Dan Williams wrote:
> --- /dev/null
> +++ b/drivers/block/nd/Kconfig

> +	depends on (X86 || IA64 || ARM || ARM64 || SH || XTENSA)

I've only skimmed this series. I still noticed this patch contains the
only Kconfig typo I know by heart. Because I think you meant to say:
	depends on (X86 || IA64 || ARM || ARM64 || SUPERH || XTENSA)

Is that right?


Paul Bolle

