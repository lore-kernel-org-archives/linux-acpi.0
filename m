From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V8 0/9] vfio, platform: add ACPI support
Date: Thu, 23 Jun 2016 11:03:17 -0400
Message-ID: <576BFA35.2080207@codeaurora.org>
References: <1466437879-32182-1-git-send-email-okaya@codeaurora.org>
 <44afaabd-8393-fa97-ab61-664cd169bd9f@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <44afaabd-8393-fa97-ab61-664cd169bd9f@redhat.com>
Sender: kvm-owner@vger.kernel.org
To: Auger Eric <eric.auger@redhat.com>, kvm@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, alex.williamson@redhat.comAlex Williamson <alex.williamson@redhat.com>, Baptiste Reynal <b.reynal@virtualopensystems.com>
Cc: linux-acpi@vger.kernel.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

Hi Alex, Eric;

On 6/23/2016 3:58 AM, Auger Eric wrote:
> Hi Sinan,
> 
> On 20/06/2016 17:51, Sinan Kaya wrote:
>>
> I tested with device tree and I did not find any issue:
> Tested-by: Eric Auger <eric.auger@redhat.com>
> 
> For the whole series:
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 

Thanks to Eric for reviewing and testing this.

> Please note this will collide with "[PATCH V3] vfio: platform: support
> No-IOMMU mode" (s/iommu_group_put/vfio_iommu_group_put)

Alex, can you pull the series into 4.8 kernel?

I can fix the conflict by another version or you can fix the
conflict during merge.

Let me know your preference.
Sinan

> 
> Best Regards
> 
> Eric
> 


-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
