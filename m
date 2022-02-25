Return-Path: <linux-acpi-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1597C433EF
	for <linux-acpi@archiver.kernel.org>; Fri, 25 Feb 2022 14:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbiBYO5k (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Fri, 25 Feb 2022 09:57:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiBYO5h (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Feb 2022 09:57:37 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC2315BE74
        for <linux-acpi@vger.kernel.org>; Fri, 25 Feb 2022 06:56:54 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F17EE12FC;
        Fri, 25 Feb 2022 06:56:53 -0800 (PST)
Received: from bogus (unknown [10.57.3.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE37D3F5A1;
        Fri, 25 Feb 2022 06:56:52 -0800 (PST)
Date:   Fri, 25 Feb 2022 14:56:02 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-acpi@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>,
        Ray.Huang@amd.com
Subject: Re: [PATCH 1/2] PSCI: cpuidle: Move the `has_lpi` check to the
 beginning of the function
Message-ID: <20220225145602.63pjqkrhadcrzh2k@bogus>
References: <20220225031255.3647599-1-mario.limonciello@amd.com>
 <20220225031255.3647599-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225031255.3647599-2-mario.limonciello@amd.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Thu, Feb 24, 2022 at 09:12:54PM -0600, Mario Limonciello wrote:
> Currently the first thing checked is whether the PCSI cpu_suspend function
> has been initialized.
> 
> Another change will be overloading `acpi_processor_ffh_lpi_probe` and
> calling it sooner.  So make the `has_lpi` check the first thing checked
> to prepare for that change.
>

You need to cc arm64 maintainers and get their ack to merge this via ACPI
tree.

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
