From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/3] ACPI: move ACPI_SYSTEM_HID to acpi_drivers.h
Date: Thu, 17 Mar 2016 02:50:19 +0100
Message-ID: <CAJZ5v0jewRqgvi7Ei939ddafnNJEQw+cv2cjGWrFNK2pZ0-2rQ@mail.gmail.com>
References: <1458157022-18633-1-git-send-email-pprakash@codeaurora.org>
	<1458157022-18633-2-git-send-email-pprakash@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f194.google.com ([209.85.217.194]:35137 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751802AbcCQBuV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Mar 2016 21:50:21 -0400
Received: by mail-lb0-f194.google.com with SMTP id wn5so4176939lbb.2
        for <linux-acpi@vger.kernel.org>; Wed, 16 Mar 2016 18:50:20 -0700 (PDT)
In-Reply-To: <1458157022-18633-2-git-send-email-pprakash@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prashanth Prakash <pprakash@codeaurora.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, harba@codeaurora.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>

On Wed, Mar 16, 2016 at 8:37 PM, Prashanth Prakash
<pprakash@codeaurora.org> wrote:
> From: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>
>
> ACPI_SYSTEM_HID is defined in drivers/acpi/bus.c out-of-band.
>
> Move the definition to include/acpi/acpi_drivers.h, together
> with other Linux specific HIDs, so that it can be used by other
> code.
>
> Signed-off-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
> ---
>  drivers/acpi/scan.c         | 3 ++-
>  include/acpi/acpi_drivers.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 407a376..358e3c8 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -13,6 +13,8 @@
>  #include <linux/nls.h>
>  #include <linux/dma-mapping.h>
>
> +#include <acpi/acpi_drivers.h>
> +
>  #include <asm/pgtable.h>
>
>  #include "internal.h"
> @@ -22,7 +24,6 @@ ACPI_MODULE_NAME("scan");
>  extern struct acpi_device *acpi_root;
>
>  #define ACPI_BUS_CLASS                 "system_bus"
> -#define ACPI_BUS_HID                   "LNXSYBUS"

No.

This is not a valid device ID and should never be used as such.

Thanks,
Rafael
