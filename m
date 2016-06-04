From: "George Spelvin" <linux@sciencehorizons.net>
Subject: Re: [PATCH v2 2/2] lib/uuid.c: eliminate uuid_[bl]e_index arrays
Date: 4 Jun 2016 17:57:48 -0400
Message-ID: <20160604215748.12845.qmail@ns.sciencehorizons.net>
References: <1465057748.11800.53.camel@perches.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from science.sciencehorizons.net ([71.41.210.147]:12125 "HELO
	ns.sciencehorizons.net" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
	with SMTP id S1750938AbcFDV5v (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Jun 2016 17:57:51 -0400
In-Reply-To: <1465057748.11800.53.camel@perches.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: andriy.shevchenko@linux.intel.com, joe@perches.com, linux@sciencehorizons.net
Cc: bjorn@mork.no, devel@acpica.org, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, lv.zheng@intel.com, matt@codeblueprint.co.uk, rafael.j.wysocki@intel.com, robert.moore@intel.com, rv@rasmusvillemoes.dk

Joe Perches wrote:
> And Ingo commented last month:
> https://lkml.org/lkml/2016/4/29/69
>
> Maybe this __uuid_to_bin function should be made public and
> the acpi version in drivers/acpi/acpica/utuuid.c should be
> removed.

I agree with the second part, but not the first; the uuid_le_to_bin()
wrapper is better for the job, and already public.
