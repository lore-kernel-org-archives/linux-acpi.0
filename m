From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [RFC PATCH v2 05/16] mfd: Add ACPI support
Date: Tue, 16 Sep 2014 14:54:40 -0700
Message-ID: <20140916215440.GP25162@lee--X1>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com>
 <1410868367-11056-6-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:47825 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753021AbaIPVys (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Sep 2014 17:54:48 -0400
Received: by mail-pa0-f48.google.com with SMTP id hz1so653567pad.35
        for <linux-acpi@vger.kernel.org>; Tue, 16 Sep 2014 14:54:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1410868367-11056-6-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Aaron Lu <aaron.lu@intel.com>, Darren Hart <dvhart@linux.intel.com>

On Tue, 16 Sep 2014, Mika Westerberg wrote:

> If an MFD device is backed by ACPI namespace, we should allow subdevi=
ce
> drivers to access their corresponding ACPI companion devices through =
normal
> means (e.g using ACPI_COMPANION()).
>=20
> This patch adds such support to the MFD core. If the MFD parent devic=
e
> does not specify any ACPI _HID/_CID for the child device, the child
> device will share the parent ACPI companion device. Otherwise the chi=
ld
> device will be assigned with the corresponding ACPI companion, if fou=
nd
> in the namespace below the parent.
>=20
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Reviewed-by: Darren Hart <dvhart@linux.intel.com>
> ---
> Lee, I tried to get rid of #ifdefs in the below patch but it wasn't
> possible because we are using functions that are not available when
> !CONFIG_ACPI.
>=20
>  Documentation/acpi/enumeration.txt | 27 +++++++++++++++++++++++++
>  drivers/mfd/mfd-core.c             | 40 ++++++++++++++++++++++++++++=
++++++++++
>  include/linux/mfd/core.h           |  3 +++
>  3 files changed, 70 insertions(+)

Acked-by: Lee Jones <lee.jones@linaro.org>

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
