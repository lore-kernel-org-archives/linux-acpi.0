From: Gong Chen <clumsycg@gmail.com>
Subject: Re: [PATCH 1/1] ACPI: Call ACPI remove handler when handling ACPI
 eject event
Date: Wed, 19 Oct 2011 21:35:46 +0800
Message-ID: <CAMJ_OhjLvsZ3Vir3hVX2Ha+jA-ORX=3PBapY=B+aZP-ynqbB6A@mail.gmail.com>
References: <1318992470-10195-1-git-send-email-pingfank@linux.vnet.ibm.com>
	<1318992470-10195-2-git-send-email-pingfank@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:35334 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647Ab1JSNfr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 Oct 2011 09:35:47 -0400
In-Reply-To: <1318992470-10195-2-git-send-email-pingfank@linux.vnet.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: pingfank@linux.vnet.ibm.com
Cc: linux-acpi@vger.kernel.org, seabios@seabios.org, lenb@kernel.org, shaohua.li@intel.com, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, aliguori@us.ibm.com, dave@linux.vnet.ibm.com

On Wed, Oct 19, 2011 at 10:47 AM,  <pingfank@linux.vnet.ibm.com> wrote:
> From: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
>
> Call the remove handler for ACPI_NOTIFY_EJECT_REQUEST
>
> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
> ---
> =C2=A0drivers/acpi/bus.c =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A02 +-
> =C2=A0drivers/acpi/scan.c =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +-
> =C2=A0include/acpi/acpi_bus.h | =C2=A0 =C2=A02 ++
> =C2=A03 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 437ddbf..d06ec6d 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -764,7 +764,7 @@ static void acpi_bus_notify(acpi_handle handle, u=
32 type, void *data)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case ACPI_NOTIFY_EJECT_REQUEST:
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* TBD */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 acpi_os_hotplug_ex=
ecute(acpi_bus_hot_remove_device, handle);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0case ACPI_NOTIFY_DEVICE_CHECK_LIGHT:
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 449c556..3b97b61 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -83,7 +83,7 @@ acpi_device_modalias_show(struct device *dev, struc=
t device_attribute *attr, cha
> =C2=A0}
> =C2=A0static DEVICE_ATTR(modalias, 0444, acpi_device_modalias_show, N=
ULL);
>
> -static void acpi_bus_hot_remove_device(void *context)
> +void acpi_bus_hot_remove_device(void *context)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct acpi_device *device;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0acpi_handle handle =3D context;
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 6cd5b64..b19c09d 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -310,6 +310,8 @@ extern int unregister_acpi_notifier(struct notifi=
er_block *);
>
> =C2=A0extern int register_acpi_bus_notifier(struct notifier_block *nb=
);
> =C2=A0extern void unregister_acpi_bus_notifier(struct notifier_block =
*nb);
> +extern void acpi_bus_hot_remove_device(void *context);
> +
> =C2=A0/*
> =C2=A0* External Functions
> =C2=A0*/
> --
> 1.7.4.4
>

I preferred the patch from Shen before. Here is the link:
https://lkml.org/lkml/2011/9/24/15
As Bjorn said, "long-term goal to move the hotplug flow out of drivers =
and into
the ACPI core". An arbitrary change in the global level just mess up th=
e codes.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
