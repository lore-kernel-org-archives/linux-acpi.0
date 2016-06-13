From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V6 7/8] vfio: platform: check reset call return code
 during open
Date: Sun, 12 Jun 2016 23:12:41 -0400
Message-ID: <575E24A9.2070204@codeaurora.org>
References: <1464472878-27176-1-git-send-email-okaya@codeaurora.org>
 <1464472878-27176-8-git-send-email-okaya@codeaurora.org>
 <5ae51f93-d141-00bf-f58f-40fbf7b1307d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:37537 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933130AbcFMDMq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 12 Jun 2016 23:12:46 -0400
In-Reply-To: <5ae51f93-d141-00bf-f58f-40fbf7b1307d@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Auger Eric <eric.auger@redhat.com>, kvm@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, eric.auger@linaro.org
Cc: linux-acpi@vger.kernel.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Baptiste Reynal <b.reynal@virtualopensystems.com>, Alex Williamson <alex.williamson@redhat.com>, linux-kernel@vger.kernel.org

On 6/7/2016 4:21 PM, Auger Eric wrote:
>> -		vfio_platform_call_reset(vdev, NULL);
>> > +		ret = vfio_platform_call_reset(vdev, &extra_dbg);
>> > +		if (ret && vdev->reset_required) {
>> > +			dev_warn(vdev->device, "reset driver is required and reset call failed in open (%d) %s\n",
>> > +				 ret, extra_dbg ? extra_dbg : "");
>> > +			goto err_irq;
> I am afraid you need to tear down the resources allocated by vfio_platform_irq_init. 
> 
> Best Regards
> 
> Eric

I added this to the error path and replaced the goto above with err_rst.

+err_rst:
+        vfio_platform_irq_cleanup(vdev);
err_irq:
        vfio_platform_regions_cleanup(vdev);

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
