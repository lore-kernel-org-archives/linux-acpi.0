Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DBBC7EE43
	for <linux-acpi@archiver.kernel.org>; Tue,  6 Jun 2023 23:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbjFFXys (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Tue, 6 Jun 2023 19:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234129AbjFFXyq (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 6 Jun 2023 19:54:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EBE21732;
        Tue,  6 Jun 2023 16:54:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0ED39AB6;
        Tue,  6 Jun 2023 16:55:30 -0700 (PDT)
Received: from [192.168.122.164] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AB953F587;
        Tue,  6 Jun 2023 16:54:44 -0700 (PDT)
Message-ID: <888baa97-ac71-18ca-ad21-eae19ef241f1@arm.com>
Date:   Tue, 6 Jun 2023 18:54:35 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/3 v2] Update ACPI documentation for Arm systems
Content-Language: en-US
To:     Jose Marinho <jose.marinho@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <James.Morse@arm.com>,
        Rob Herring <Rob.Herring@arm.com>,
        Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Hanjun Guo <guohanjun@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-acpi@vger.kernel.org
References: <20230606093528.1494344-1-jose.marinho@arm.com>
From:   Jeremy Linton <jeremy.linton@arm.com>
In-Reply-To: <20230606093528.1494344-1-jose.marinho@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

Hi,

On 6/6/23 04:35, Jose Marinho wrote:
> This set of patches updates the Linux kernel ACPI documentation for Arm
> systems. The intent is to integrate the developments in the BBR
> specification that happened over the last couple of years.

Thanks for doing this, it has been sorely needed. The changes all look 
good to me too, so:

Reviewed-by: Jeremy Linton <jeremy.linton@arm.com>


Now all that said, at some point it will be worthwhile to reopen the 
discussion around a few of the more "controversial" parts of this 
document so they better reflect the current state of machines utilizing 
ACPI.


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
>   - Clarify that the RAS tables are conditionaly required when ACPI
>     Platform Error Interfaces are required: Hanjun Guo.
>   - Clarify that HMAT is required if NUMA is supported and the system
>     contains heterogeneous memory: Hanjun Guo.
> 
> 
> Jose Marinho (3):
>    Documentation/arm64: Update ARM and arch reference
>    Documentation/arm64: Update references in arm-acpi
>    Documentation/arm64: Update ACPI tables from BBR
> 
>   Documentation/arm64/acpi_object_usage.rst |  81 ++++++++++-
>   Documentation/arm64/arm-acpi.rst          | 168 ++++++++++++++--------
>   2 files changed, 183 insertions(+), 66 deletions(-)
> 

