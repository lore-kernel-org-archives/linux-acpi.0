From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Add Panasonic Laptop ACPI extras driver
Date: Wed, 23 Jul 2008 12:28:44 -0400
Message-ID: <20080723122645.ZZRA012@mailhub.coreip.homeip.net>
References: <20080722005301.GF8744@prithivi.gnumonks.org> <20080722144348.ZZRA012@mailhub.coreip.homeip.net> <20080723115307.GF8464@prithivi.gnumonks.org> <20080723083830.ZZRA012@mailhub.coreip.homeip.net> <20080723153921.GC4026@prithivi.gnumonks.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.29]:22525 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbYGWQ2u (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 Jul 2008 12:28:50 -0400
Received: by yw-out-2324.google.com with SMTP id 9so1070375ywe.1
        for <linux-acpi@vger.kernel.org>; Wed, 23 Jul 2008 09:28:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080723153921.GC4026@prithivi.gnumonks.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Harald Welte <laforge@gnumonks.org>
Cc: Andi Kleen <ak@linux.intel.com>, linux-acpi@vger.kernel.org

On Wed, Jul 23, 2008 at 11:39:21AM -0400, Harald Welte wrote:
>  
> +config ACPI_PANASONIC
> +	tristate "Panasonic Laptop Extras"
> +	depends on X86

Also needs "depends on INPUT" otherwise "make randconfig" guys will come
after you with venegance ;)

Sorry for not noticing this before.

-- 
Dmitry
