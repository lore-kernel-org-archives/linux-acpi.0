Return-Path: <linux-acpi-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63EC1C77B72
	for <linux-acpi@archiver.kernel.org>; Thu, 20 Apr 2023 04:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjDTEXV (ORCPT <rfc822;linux-acpi@archiver.kernel.org>);
        Thu, 20 Apr 2023 00:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjDTEXU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Apr 2023 00:23:20 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81823595
        for <linux-acpi@vger.kernel.org>; Wed, 19 Apr 2023 21:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681964599; x=1713500599;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XukRQffyaLcurPj0MIxT2KBrbiwJQ4mOpE0STVWyGKg=;
  b=D9d/oHHCkeEzPSmAXssT+wf7ZNyeQRhOY9vmmt2PnfEgim+/mjmopzLv
   yXVSh5QUGNlsxDHs4gHT74FqYdxGcEUN3rezavbDJOoAQ4B3E6SnSxNnA
   doREAzdf00g68/Q+llcRo1/eAXUocOSdb+84gG0d+V9sv+urjRDLWn9iD
   DmngB36z+lSgBdyXfaxlwqGpAn1eDQFg7lIP8eC1rdpsKYCWBhx/J0MvV
   wjAoB+FOwllti26Kn4tLUsVpyWwo+hYDE9GU9GPmh+cEFblGjSvd5rJrL
   RKdaE0wmiJ40rxjuRccB2FYS8wV75A3DgZkJdv+Jl+EHB34dCbnagNWOt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="345630233"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="345630233"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 21:23:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10685"; a="781099157"
X-IronPort-AV: E=Sophos;i="5.99,211,1677571200"; 
   d="scan'208";a="781099157"
Received: from allen-box.sh.intel.com (HELO [10.239.159.127]) ([10.239.159.127])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Apr 2023 21:23:15 -0700
Message-ID: <da60a120-e1dd-3b61-d6c4-ba0d955e2339@linux.intel.com>
Date:   Thu, 20 Apr 2023 12:23:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     baolu.lu@linux.intel.com, Kevin Tian <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH 08/11] iommu: Always destroy the iommu_group during
 iommu_release_device()
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev,
        Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Will Deacon <will@kernel.org>
References: <8-v1-8aecc628b904+2f42-iommu_probe_jgg@nvidia.com>
From:   Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <8-v1-8aecc628b904+2f42-iommu_probe_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-acpi.vger.kernel.org>
X-Mailing-List: linux-acpi@vger.kernel.org

On 4/20/23 12:11 AM, Jason Gunthorpe wrote:
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index dbaf3ed9012c45..a82516c8ea87ad 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -569,7 +569,6 @@ static void __iommu_group_remove_device(struct device *dev)
>   			dev->iommu_group = NULL;
>   		goto out;

Nit, given that below line has been removed, can above simply be a
loop break?

>   	}
> -	WARN(true, "Corrupted iommu_group device_list");
>   out:
>   	mutex_unlock(&group->mutex);

Best regards,
baolu

