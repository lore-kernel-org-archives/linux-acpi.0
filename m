Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7416C25B4E
	for <linux-acpi@archiver.kernel.org>; Tue, 24 Jan 2023 19:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbjAXTeR (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 24 Jan 2023 14:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbjAXTeC (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 24 Jan 2023 14:34:02 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1499651C77;
        Tue, 24 Jan 2023 11:33:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674588794; x=1706124794;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dbY/Ssacko0F5pWXefCI8J8GzLuUDSLhc8AuNexH3uo=;
  b=e+5c+cXgNJdLgP5HJHSKzQkPxedFeaN729jD7cdewXpBCA8gJEtlWQVe
   w0FVahJEsYtXfdbB1P2rc/ydYVyUfUuwbrkcYKzpcibY7PANuXdmPTuQp
   zhKZdo69DSWPrLdLekS+xt4IstH/pBV2fmChvKIFjeFjkBG6pm/elKLjF
   Wopl/WimcyAChhqfUn1XzuQRCFnKGLHE2g1ckuOOVWUV1mEoDPaVRETN/
   ky2WW3VDkw5Krl/Gf14e61Ocg+Rk1PEa4FDuf8XnAEj0bf1YKV4MOEvyM
   YI5XOBxTgzKqw3G4mWgoWwQoBKT5OvIbuPBq3nq/lTpfIu47Few/A/fs9
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="390892232"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="390892232"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2023 11:33:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10600"; a="692694478"
X-IronPort-AV: E=Sophos;i="5.97,243,1669104000"; 
   d="scan'208";a="692694478"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 24 Jan 2023 11:32:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pKP2P-00EVfu-26;
        Tue, 24 Jan 2023 21:32:57 +0200
Date:   Tue, 24 Jan 2023 21:32:57 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     linux-acpi@vger.kernel.org, linux-media@vger.kernel.org,
        rafael@kernel.org, heikki.krogerus@linux.intel.com
Subject: Re: [PATCH v2 4/8] ACPI: property: Generate camera swnodes for ACPI
 and DisCo for Imaging
Message-ID: <Y9AyaYKwbCDTkBZe@smile.fi.intel.com>
References: <20230123134617.265382-1-sakari.ailus@linux.intel.com>
 <20230123134617.265382-5-sakari.ailus@linux.intel.com>
 <Y9Aw5/mSYEadHRKK@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9Aw5/mSYEadHRKK@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jan 24, 2023 at 09:26:31PM +0200, Andy Shevchenko wrote:
> On Mon, Jan 23, 2023 at 03:46:13PM +0200, Sakari Ailus wrote:

...

> 	u8 val8[BITS_TO_BYTES(MAX_LANES(port))];

Here forgot to rename

	u8 val[BITS_TO_BYTES(MAX_LANES(port))];

And it seems also good to have

#define MAX_LANES_BYTES(port)	BITS_TO_BYTES(MAX_LANES(port))

	u8 val[MAX_LANES_BYTES(port)];

...

> 	ret = fwnode_property_count_u8(mipi_port_fwnode, "mipi-img-dlane-polarities");
> 	if (ret < 0) {
> 		acpi_handle_debug(acpi_device_handle(device),
> 				  "no lane polarity provided\n");
> 	} else if (ret < 1 + num_lanes) {
> 		acpi_handle_warn(acpi_device_handle(device),
> 				 "too few lane polarity bytes (%u)\n", bytes);
> 	} else {
> 		// assuming we dropped the union and renamed to val...
> 		ret = fwnode_property_read_u8_array(mipi_port_fwnode,
> 						    "mipi-img-lane-polarities",
> 						    val, sizeof(val));
> 		if (ret) {
> 			...can't read... (debug message?)
> 		} else {
> 			unsigned int i;
> 
> 			for (i = 0; i < 1 + num_lanes; i++)

Here something like

			for (i = 0; i < MAX_LANES_BYTES(port); i++)

But I'm tired for today, please double check. I hope you got the idea.

> 				bitmap_set_value8(polarity, val[i], i * BITS_PER_BYTE);
> 
> 			// assuming that lane_polarities is zeroed by default...
> 			for_each_set_bit(i, polarity, 1 + num_lanes)
> 				port->lane_polarities[i] = 1;
> 		}
> 	}

-- 
With Best Regards,
Andy Shevchenko


