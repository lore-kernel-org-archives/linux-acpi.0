Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DC7C7EE2D
	for <linux-acpi@archiver.kernel.org>; Tue, 23 May 2023 15:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236906AbjEWPQz (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 23 May 2023 11:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237505AbjEWPQo (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 23 May 2023 11:16:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AC34910D4;
        Tue, 23 May 2023 08:16:14 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5474D139F;
        Tue, 23 May 2023 08:16:36 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03F0D3F840;
        Tue, 23 May 2023 08:15:48 -0700 (PDT)
Date:   Tue, 23 May 2023 16:15:46 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        coresight@lists.linaro.org, suzuki.poulose@arm.com,
        Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>,
        Steve Clevenger <scclevenger@os.amperecomputing.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH V4 4/6] coresight: etm4x: Change etm4_platform_driver
 driver for MMIO devices
Message-ID: <20230523151546.bpvrrqvp2xho2i5w@bogus>
References: <20230523044553.1525048-1-anshuman.khandual@arm.com>
 <20230523044553.1525048-5-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523044553.1525048-5-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On Tue, May 23, 2023 at 10:15:51AM +0530, Anshuman Khandual wrote:
> Add support for handling MMIO based devices via platform driver. We need to
> make sure that :
> 
> 1) The APB clock, if present is enabled at probe and via runtime_pm ops

Was mainly interested in the above to ensure it works smoothly once migrate
to this with ACPI. The changes look good to me.

So,

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
