From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 9/10] introduce intel_menlow platform specific driver
Date: Mon, 21 Jan 2008 09:53:31 +0000
Message-ID: <20080121095331.GA5333@infradead.org>
References: <1200556278.2935.118.camel@acpi-sony.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pentafluge.infradead.org ([213.146.154.40]:56479 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758308AbYAUJxf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Jan 2008 04:53:35 -0500
Content-Disposition: inline
In-Reply-To: <1200556278.2935.118.camel@acpi-sony.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, sujith.thomas@intel.com

On Thu, Jan 17, 2008 at 03:51:17PM +0800, Zhang Rui wrote:
> From: Thomas Sujith <sujith.thomas@intel.com>
> 
> Intel menlow platform specific driver for thermal management.
> 
> Signed-off-by: Thomas Sujith <sujith.thomas@intel.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/misc/Kconfig        |   10 
>  drivers/misc/Makefile       |    1 
>  drivers/misc/intel_menlow.c |  527 ++++++++++++++++++++++++++++++++++++++++++++

Why is this in drivers/misc?  I don't have a thermal.h in mainline, but
if this is a new subsystem your adding care to create a directory under
drivers/ for it?

> +/*
> +*  intel_menlow.c - Intel menlow Driver for thermal management extension
> +*
> +*  Copyright (C) 2008 Intel Corp
> +*  Copyright (C) 2008 Sujith Thomas <sujith.thomas@intel.com>
> +*  Copyright (C) 2008 Zhang Rui <rui.zhang@intel.com>

Please add a whitespace before the * so they line up.

> +MODULE_AUTHOR("Thomas Sujith");
> +MODULE_AUTHOR("Zhang Rui");

I've never seen a driver with two MODULE_AUTHOR statements before.  Does
this actually work?  What does modinfo -F author say for your module?

