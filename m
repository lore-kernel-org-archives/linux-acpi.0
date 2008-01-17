From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 9/10] introduce intel_menlow platform specific driver
Date: Thu, 17 Jan 2008 09:18:24 +0100
Message-ID: <20080117081824.GA3284@uranus.ravnborg.org>
References: <1200556278.2935.118.camel@acpi-sony.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from pasmtpa.tele.dk ([80.160.77.114]:57569 "EHLO pasmtpA.tele.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752323AbYAQIST (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 17 Jan 2008 03:18:19 -0500
Content-Disposition: inline
In-Reply-To: <1200556278.2935.118.camel@acpi-sony.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, sujith.thomas@intel.com

>  
> +config INTEL_MENLOW
> +        tristate "Thermal Management driver for Intel menlow platform"
> +        depends on ACPI_THERMAL
> +	default n

default n is not needed - it is default.

	Sam
