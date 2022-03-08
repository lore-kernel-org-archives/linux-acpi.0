Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6FDC433EF
	for <linux-acpi@archiver.kernel.org>; Tue,  8 Mar 2022 16:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348306AbiCHQiT (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 8 Mar 2022 11:38:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343646AbiCHQiR (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Mar 2022 11:38:17 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7927951313;
        Tue,  8 Mar 2022 08:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646757440; x=1678293440;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=btvnkhxXFqfWw8ZMKN2ldljwzrOFUhDvoy3lW8cUN8I=;
  b=oCmarJ+RXHCgduXbFNl3vRxsFfB9hZQNzAhYV4yLzUnWqH/5pGDJCUZ5
   b4OX5xDZ1NE9zGzdmpX87MqIT9fTbHz/SObUUXYeFI4atdAfSEHOM+g4x
   THaWJDEWj+6qYYkNt9lwjwbsAArujBxj2GTt4dTrnqt8q0pRRRBRzIqjd
   dr2HJI3SM7qRhuZFczXkFgA3PCZR2VRZmuqKt0DmwRRGqcKPh65dOc+58
   exDaLt5QGDqVsCyqh19k1EDvZ80kmjAh4D/2MOn1dbQIPV3IKgw12rQpq
   H0DPtwfvQ4NpYEwAsejy1+GP50N0l6CVYxtgYOjZ+i0/miwtwH52uXtrn
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="317962349"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="317962349"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 08:37:16 -0800
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="643711428"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 08:37:12 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 08 Mar 2022 18:36:05 +0200
Date:   Tue, 8 Mar 2022 18:36:05 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Corbet <corbet@lwn.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v1 1/1] ACPI: docs: gpio-properties: Unify ASL style for
 GPIO examples
Message-ID: <YieF9eUnY5l3tT+a@lahna>
References: <20220308140559.46932-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308140559.46932-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 08, 2022 at 04:05:59PM +0200, Andy Shevchenko wrote:
> GPIO examples of ASL in the board.rst, enumeration.rst and gpio-properties.rst
> are not unified. Unify them for better reader experience.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
