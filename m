From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V7 0/9] vfio, platform: add ACPI support
Date: Tue, 14 Jun 2016 11:38:24 -0400
Message-ID: <576024F0.5020700@codeaurora.org>
References: <1465792001-27960-1-git-send-email-okaya@codeaurora.org>
 <575EDA6C.9010806@codeaurora.org>
 <CAN9JPjH6uSvGgY6aS5GDhxi5aTCfXhirFk7wNxvwTxXbV9jtzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:43520 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752106AbcFNPi2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 14 Jun 2016 11:38:28 -0400
In-Reply-To: <CAN9JPjH6uSvGgY6aS5GDhxi5aTCfXhirFk7wNxvwTxXbV9jtzw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Baptiste Reynal <b.reynal@virtualopensystems.com>
Cc: "open list:VFIO DRIVER" <kvm@vger.kernel.org>, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, Alex Williamson <alex.williamson@redhat.com>, Eric Auger <eric.auger@linaro.org>, linux-acpi@vger.kernel.org, Andy Gross <agross@codeaurora.org>, linux-arm-msm@vger.kernel.org, "moderated list:ARM SMMU DRIVER" <linux-arm-kernel@lists.infradead.org>

On 6/14/2016 11:29 AM, Baptiste Reynal wrote:
> Hi Sinan,
> 
> Although I don't have the hardware to test them, I reviewed your
> patches and they look fine to me.
> 
> Regards,
> Baptiste

Thanks, I tested ACPI. Eric is testing DT in order not to break
existing functionality.

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
