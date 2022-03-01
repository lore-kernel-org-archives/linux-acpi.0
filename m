Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAF9C433EF
	for <linux-acpi@archiver.kernel.org>; Tue,  1 Mar 2022 13:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiCANKy (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 1 Mar 2022 08:10:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbiCANKy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Mar 2022 08:10:54 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EDDF1EAF4
        for <linux-acpi@vger.kernel.org>; Tue,  1 Mar 2022 05:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646140213; x=1677676213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PvYJWHU3idRCxIN/SlnnspdyikZwcgWZbtGWjpLqPAU=;
  b=CE5Z+sF1NMs7/redc+WrbHnFjTVI1jJzO0vFGofZvM//JJ18JbOc02n1
   WTCFrc88dpAi9J21gh5NTu8KF0wmfcYUdPzZXZYpJI2B3b+o3Vx85woyQ
   P4htc9jXYLj8/XReC19AQh4VZEYECQOjkZgO+CKfRhFVl3ClIBSHyQJJ2
   /hvkkQD+rMS/B0rBP310TZpeMaDNlArhpj8UmRZwlQX1gYyeK0fFysicU
   se6bLZppE/97CzwiFVRpauR3FcaEKj7fFXiHWIUlN40m73Efdgv/VPAUb
   6bY9XxLTvfaCVs0bR0uqnNMjdeN3tTXnLFxasDyVlWjF+HN7d/9ZOPyF/
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="253054627"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="253054627"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 05:10:13 -0800
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="709046562"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.162])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 05:10:09 -0800
Received: by lahna (sSMTP sendmail emulation); Tue, 01 Mar 2022 15:07:56 +0200
Date:   Tue, 1 Mar 2022 15:07:56 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Xiaomeng.Hou@amd.com,
        Aaron.Liu@amd.com, Ray.Huang@amd.com, hdegoede@redhat.com
Subject: Re: [PATCH v4 2/3] ACPI: bus: Allow negotiating OSC capabilities
Message-ID: <Yh4Yphj7mLhC1igw@lahna>
References: <20220301124908.1931221-1-mario.limonciello@amd.com>
 <20220301124908.1931221-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301124908.1931221-2-mario.limonciello@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Mar 01, 2022 at 06:49:07AM -0600, Mario Limonciello wrote:
> Currently when capabilities have been masked by firmware during a
> negotiation with OSC_QUERY_ENABLE set they're silently ignored
> by the caller.  If the caller calls `acpi_run_osc` again without
> query set and the same capabilities, then they instead get a failure
> possibly leading to downstream problems.
> 
> So instead when query is set return AE_SUPPORT which callers can then
> use for determining that capabilities were masked.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
