Return-Path: <SRS0=NXye=DX=vger.kernel.org=linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AE9AC433DF
	for <linux-acpi@archiver.kernel.org>; Fri, 16 Oct 2020 08:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3454120872
	for <linux-acpi@archiver.kernel.org>; Fri, 16 Oct 2020 08:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390983AbgJPIZs (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 16 Oct 2020 04:25:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:60550 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390721AbgJPIZs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 16 Oct 2020 04:25:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B1459B206;
        Fri, 16 Oct 2020 08:25:46 +0000 (UTC)
Date:   Fri, 16 Oct 2020 10:25:41 +0200
From:   Borislav Petkov <bp@suse.de>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH 2/2] ACPI: DPTF: Add ACPI_DPTF Kconfig menu
Message-ID: <20201016082541.GB8588@zn.tnic>
References: <2206290.MayQypTng0@kreacher>
 <35637045.pmxlVluP8t@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <35637045.pmxlVluP8t@kreacher>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Oct 15, 2020 at 06:59:52PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Add a Kconfig menu for Intel DPTF (Dynamic Platform and Thermal
> Framework), put both the existing participant drivers in it and set
> them to be built as modules by default.
> 
> While at it, do a few assorted cleanups for a good measure.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/dptf/Kconfig |   29 ++++++++++++++++++++++++-----
>  1 file changed, 24 insertions(+), 5 deletions(-)
> 
> Index: linux-pm/drivers/acpi/dptf/Kconfig
> ===================================================================
> --- linux-pm.orig/drivers/acpi/dptf/Kconfig
> +++ linux-pm/drivers/acpi/dptf/Kconfig
> @@ -1,8 +1,25 @@
>  # SPDX-License-Identifier: GPL-2.0
> -config DPTF_POWER
> -	tristate "DPTF Platform Power Participant"
> +
> +menuconfig ACPI_DPTF
> +	bool "Intel DPTF (Dynamic Platform and Thermal Framework) Support"
>  	depends on X86
>  	help
> +	  Intel Dynamic Platform and Thermal Framework (DPTF) is a platform
> +	  level hardware/software solution for power and thermal management.
> +
> +	  As a container for multiple power/thermal technologies, DPTF provides
> +	  a coordinated approach for different policies to effect the hardware
> +	  state of a system.
> +
> +	  For more information see:
> +	  <https://01.org/intel%C2%AE-dynamic-platform-and-thermal-framework-dptf-chromium-os/overview>

Oh wow, they have a "(r)" for all rights reserved *in* *the* *URL*. OMG.

But yeah:

Acked-by: Borislav Petkov <bp@suse.de>

Thx Rafael.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
