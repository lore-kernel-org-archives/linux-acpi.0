From: Sinan Kaya <okaya@codeaurora.org>
Subject: Re: [PATCH V7 0/9] vfio, platform: add ACPI support
Date: Mon, 13 Jun 2016 12:08:12 -0400
Message-ID: <575EDA6C.9010806@codeaurora.org>
References: <1465792001-27960-1-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1465792001-27960-1-git-send-email-okaya@codeaurora.org>
Sender: kvm-owner@vger.kernel.org
To: kvm@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, alex.williamson@redhat.com, eric.auger@linaro.org
Cc: linux-acpi@vger.kernel.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Baptiste Reynal <b.reynal@virtualopensystems.com>
List-Id: linux-acpi@vger.kernel.org

Hi Baptiste,

On 6/13/2016 12:26 AM, Sinan Kaya wrote:
> 
> Sinan Kaya (9):
>   vfio: platform: rename reset function
>   vfio: platform: move reset call to a common function
>   vfio: platform: determine reset capability
>   vfio: platform: add support for ACPI probe
>   vfio: platform: add extra debug info argument to call reset
>   vfio: platform: call _RST method when using ACPI
>   vfio, platform: make reset driver a requirement by default
>   vfio: platform: check reset call return code during open
>   vfio: platform: check reset call return code during release
> 
>  drivers/vfio/platform/vfio_amba.c             |   5 +
>  drivers/vfio/platform/vfio_platform.c         |   5 +
>  drivers/vfio/platform/vfio_platform_common.c  | 195 +++++++++++++++++++++-----
>  drivers/vfio/platform/vfio_platform_private.h |   8 +-
>  4 files changed, 176 insertions(+), 37 deletions(-)
> 
Cov and I exchanged some emails with Alex last week. I think
there is a general expectation for you to review the series since
you are the subsystem maintainer.

I'm looking forward to hear your feedback on the series.
Sinan

-- 
Sinan Kaya
Qualcomm Technologies, Inc. on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project
