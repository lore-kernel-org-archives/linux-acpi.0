From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V8 4/9] vfio: platform: add support for ACPI probe
Date: Wed, 13 Jul 2016 17:01:32 -0400
Message-ID: <20f7d42e-8d15-49ad-6c6a-eda489546f20@codeaurora.org>
References: <1466437879-32182-1-git-send-email-okaya@codeaurora.org>
 <1466437879-32182-5-git-send-email-okaya@codeaurora.org>
 <20160623123410.647b3be0@t450s.home>
 <604722bb-5e82-851f-c1a1-cb34b55bf77d@codeaurora.org>
 <20160713140956.5aad0904@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:56085 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbcGMVBg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Jul 2016 17:01:36 -0400
In-Reply-To: <20160713140956.5aad0904@t450s.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Williamson <alex.williamson@redhat.com>
Cc: kvm@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, eric.auger@redhat.com, linux-acpi@vger.kernel.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Baptiste Reynal <b.reynal@virtualopensystems.com>, linux-kernel@vger.kernel.org

On 7/13/2016 4:09 PM, Alex Williamson wrote:
>> et me explain the rationale.
>> > 
>> > As you know, there can be two kernel build combinations. One build where 
>> > ACPI is not selected in Kconfig and another one with the ACPI Kconfig.
>> > 
>> > In the first case, CONFIG_ACPI is stubbed out in this file and DT user
>> > will not see any kind of messages from ACPI. 
>> > 
>> > In the second case, both DT and ACPI is compiled in but the system is booting with
>> > any of these combinations. 
>> > 
>> > If the firmware is DT type, then acpi_disabled is 1. The ACPI probe routine
>> > terminates immediately without any messages. 
>> > 
>> > If the firmware is ACPI type, then acpi_disabled is 0. All other checks are valid
>> > checks. We cannot claim that this system is DT.
> 
> Thanks, this sort of information and assumption should be documented in
> a comment since not all of us care whether a DT device can appear in an
> ACPI config or not.  Also note that acpi_disabled and ACPI_COMPANION
> are defined regardless of CONFIG_ACPI, so really we only need to wrap
> acpi_device_hid() in an #ifdef, we could skip the separate stub.
> Thanks,

Sure, I'll add the sentences above as a comment to top of the probe function.

I also got rid of stub vfio_platform_acpi_probe function and moved CONFIG_ACPI
inside the vfio_platform_acpi_probe function as you suggested.

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
