Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61174C2D0E4
	for <linux-acpi@archiver.kernel.org>; Thu, 19 Nov 2020 13:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0447D22255
	for <linux-acpi@archiver.kernel.org>; Thu, 19 Nov 2020 13:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgKSNjp (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 19 Nov 2020 08:39:45 -0500
Received: from mga18.intel.com ([134.134.136.126]:31000 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbgKSNjp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 19 Nov 2020 08:39:45 -0500
IronPort-SDR: PjvZHtmNwVKS4koAbI8rSyZuAOF9ZMyPTFKy6N2uQqlQag0SOVcX9WTjb8vFfoeXAxVxOg7JAJ
 6xexPtg+EfbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9809"; a="159060287"
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="159060287"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 05:39:44 -0800
IronPort-SDR: qmO9at6lIvf1VQofucHqKo4928urj40vKFCphf8Pa+VPm8R4L2bmqkU4LLMz1ZsQe6HmeVLxzp
 7S1hXpPimlug==
X-IronPort-AV: E=Sophos;i="5.77,490,1596524400"; 
   d="scan'208";a="357380931"
Received: from paasikivi.fi.intel.com ([10.237.72.42])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2020 05:39:41 -0800
Received: by paasikivi.fi.intel.com (Postfix, from userid 1000)
        id E3E2420AA6; Thu, 19 Nov 2020 15:39:39 +0200 (EET)
Date:   Thu, 19 Nov 2020 15:39:39 +0200
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Alexander A . Klimov" <grandmaster@al2klimov.de>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] docs: ACPI: dsd: enable hyperlink in final references
Message-ID: <20201119133939.GW3940@paasikivi.fi.intel.com>
References: <20201119125801.719775-1-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201119125801.719775-1-f.suligoi@asem.it>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Nov 19, 2020 at 01:58:01PM +0100, Flavio Suligoi wrote:
> For inline web links, no special markup are needed.
> 
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>

Thanks!

Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

-- 
Sakari Ailus
