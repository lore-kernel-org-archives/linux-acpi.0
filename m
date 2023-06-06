Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176FBC7EE24
	for <linux-acpi@archiver.kernel.org>; Tue,  6 Jun 2023 13:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbjFFNh7 (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 6 Jun 2023 09:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237706AbjFFNh6 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Jun 2023 09:37:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A216912D;
        Tue,  6 Jun 2023 06:37:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E80052F4;
        Tue,  6 Jun 2023 06:38:40 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F31443F793;
        Tue,  6 Jun 2023 06:37:53 -0700 (PDT)
Date:   Tue, 6 Jun 2023 14:37:51 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jose Marinho <jose.marinho@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        James Morse <James.Morse@arm.com>,
        Rob Herring <Rob.Herring@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Hanjun Guo <guohanjun@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH 0/3 v2] Update ACPI documentation for Arm systems
Message-ID: <20230606133751.q3sbluevbnypkvfb@bogus>
References: <20230606093528.1494344-1-jose.marinho@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606093528.1494344-1-jose.marinho@arm.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, Jun 06, 2023 at 10:35:25AM +0100, Jose Marinho wrote:
> This set of patches updates the Linux kernel ACPI documentation for Arm
> systems. The intent is to integrate the developments in the BBR
> specification that happened over the last couple of years.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Jeremy Linton <Jeremy.Linton@arm.com>
> Cc: James Morse <James.Morse@arm.com>
> Cc: Rob Herring <Rob.Herring@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Hanjun Guo <guohanjun@huawei.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-doc@vger.kernel.org
> Cc: linux-acpi@vger.kernel.org
> 
> v2:
>  - Clarify that the RAS tables are conditionaly required when ACPI
>    Platform Error Interfaces are required: Hanjun Guo.
>  - Clarify that HMAT is required if NUMA is supported and the system
>    contains heterogeneous memory: Hanjun Guo.
>

LGTM overall, thanks for updating.

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
