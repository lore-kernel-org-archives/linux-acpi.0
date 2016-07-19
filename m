From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V10 4/9] vfio: platform: add support for ACPI probe
Date: Tue, 19 Jul 2016 11:29:34 -0400
Message-ID: <055ee380-a6a2-7272-28cb-f463eb663a11@codeaurora.org>
References: <1468883367-2854-1-git-send-email-okaya@codeaurora.org>
 <1468883367-2854-5-git-send-email-okaya@codeaurora.org>
 <20160718180049.78db3dfb@t450s.home>
 <b4655a0ba9152e6b2951e379e1615dad@codeaurora.org>
 <20160718182448.7b11a7af@t450s.home>
 <73439c6b-c9fc-6a5d-c90c-6b8d5cd5f3f5@codeaurora.org>
 <20160719092819.0334c607@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:49113 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbcGSP3h (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 19 Jul 2016 11:29:37 -0400
In-Reply-To: <20160719092819.0334c607@t450s.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, eric.auger@redhat.com, linux-acpi@vger.kernel.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Baptiste Reynal <b.reynal@virtualopensystems.com>, linux-kernel@vger.kernel.org

On 7/19/2016 11:28 AM, Alex Williamson wrote:
> On Tue, 19 Jul 2016 10:49:54 -0400
> Sinan Kaya <okaya@codeaurora.org> wrote:
> 
>> On 7/18/2016 8:24 PM, Alex Williamson wrote:
>>>>> nit, might make sense to replace EPERM with ENOENT and use EINVAL here.  
>>>>>>>     
>>>>>
>>>>> Sure, will take carr of it.
>>>>>
>>>>> Anything else I need to take care of?  
>>> Not that I see, maybe just send a new version of this patch if the
>>> changes don't trickle through too much.  Thanks,  
>>
>> I posted V11 with the discussed change. 
>>
>> [PATCH V11 0/9] vfio, platform: add ACPI support
>>
>> Do you see this making to 4.8 kernel?
> 
> 
> I hope so, I'll try to get it into my next branch within the next day
> or so.  Thanks,
> 
> Alex
> 

Thank you.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
