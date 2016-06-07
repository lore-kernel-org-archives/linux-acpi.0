From: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH V6 0/8] vfio, platform: add ACPI support
Date: Tue, 7 Jun 2016 22:37:56 +0200
Message-ID: <48fe5e46-af9d-79e4-e298-6ba0f2a1d3c1@redhat.com>
References: <1464472878-27176-1-git-send-email-okaya@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:35911 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753333AbcFGUiG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 7 Jun 2016 16:38:06 -0400
In-Reply-To: <1464472878-27176-1-git-send-email-okaya@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sinan Kaya <okaya@codeaurora.org>, kvm@vger.kernel.org, timur@codeaurora.org, cov@codeaurora.org, jcm@redhat.com, eric.auger@linaro.org
Cc: linux-acpi@vger.kernel.org, agross@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Sinan,
Le 29/05/2016 =E0 00:01, Sinan Kaya a =E9crit :
> The device tree code checks for the presence of a reset driver and ca=
lls
> the of_reset function pointer by looking up the reset driver as a mod=
ule.
>=20
> ACPI defines _RST method to perform device level reset. After the _RS=
T
> method is executed, the OS can resume using the device.
>=20
> This patch checks the presence of _RST method and calls the _RST
> method when reset is requested.
>=20
> Changes from V5:
> 1. Handle reset function call failures in open and release (new patch=
).
> 2. Bring out extra debug information when failure happens (new patch)=
=2E
> 3. Address review comments from Eric in ACPI _RST patch.

I think you need a respin to fix the deallocation issue in 7/8 + 1st pa=
tch missing.
Afterwards I don't have any other comments at that point. I will test t=
he
dt non-regression tomorrow.

Thanks

Eric


> Sinan Kaya (8):
>   vfio: platform: move reset call to a common function
>   vfio: platform: determine reset capability
>   vfio: platform: add support for ACPI probe
>   vfio: platform: add extra debug info argument to call reset
>   vfio: platform: call _RST method when using ACPI
>   vfio, platform: make reset driver a requirement by default
>   vfio: platform: check reset call return code during open
>   vfio: platform: check reset call return code during release
>=20
>  drivers/vfio/platform/vfio_amba.c             |   5 +
>  drivers/vfio/platform/vfio_platform.c         |   5 +
>  drivers/vfio/platform/vfio_platform_common.c  | 169 ++++++++++++++++=
++++++----
>  drivers/vfio/platform/vfio_platform_private.h |   2 +
>  4 files changed, 159 insertions(+), 22 deletions(-)
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
