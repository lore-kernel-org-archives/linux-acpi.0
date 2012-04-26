From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/4] ACPI: Set hotplug _OST support bit to _OSC
Date: Thu, 26 Apr 2012 09:16:17 -0600
Message-ID: <CAErSpo6Ofm8qHUophN+oXrsKKfnJXvaEJUfFkEFwbXLfb4xZ=g@mail.gmail.com>
References: <1334096510-17319-1-git-send-email-toshi.kani@hp.com> <1334096510-17319-2-git-send-email-toshi.kani@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:35000 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756047Ab2DZPQk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 26 Apr 2012 11:16:40 -0400
Received: by lahj13 with SMTP id j13so1075500lah.19
        for <linux-acpi@vger.kernel.org>; Thu, 26 Apr 2012 08:16:38 -0700 (PDT)
In-Reply-To: <1334096510-17319-2-git-send-email-toshi.kani@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Apr 10, 2012 at 4:21 PM, Toshi Kani <toshi.kani@hp.com> wrote:
> Added macro definitions of _OST source event and status codes.
> Also renamed OSC_SB_CPUHP_OST_SUPPORT to OSC_SB_HOTPLUG_OST_SUPPORT
> since this _OSC bit is not specific to CPU hotplug. =A0This bit is
> defined in table 6-147 of ACPI 5.0 as follows.
>
> =A0Bits: =A0 =A0 =A0 3
> =A0Field Name: Insertion / Ejection _OST Processing Support
> =A0Definition: This bit is set if OSPM will evaluate the _OST
> =A0 =A0 =A0 =A0 =A0 =A0 =A0object defined under a device when process=
ing
> =A0 =A0 =A0 =A0 =A0 =A0 =A0insertion and ejection source event codes.
>
> This patch sets OSC_SB_HOTPLUG_OST_SUPPORT to the platform-wide
> OSPM capabilities when CONFIG option of ACPI CPU hotplug or memory
> hotplug is enabled.
>
> Signed-off-by: Toshi Kani <toshi.kani@hp.com>
> ---
> =A0drivers/acpi/bus.c =A0 | =A0 =A05 +++++
> =A0include/linux/acpi.h | =A0 26 +++++++++++++++++++++++++-
> =A02 files changed, 30 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 3263b68..a492d64 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -544,6 +544,11 @@ static void acpi_bus_osc_support(void)
> =A0 =A0 =A0 =A0capbuf[OSC_SUPPORT_TYPE] |=3D OSC_SB_PPC_OST_SUPPORT;
> =A0#endif
>
> +#if defined(CONFIG_ACPI_HOTPLUG_CPU) || defined(CONFIG_ACPI_HOTPLUG_=
MEMORY) ||\
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0defined(CONFIG_ACPI_HOTPLUG_MEMORY_M=
ODULE)
> + =A0 =A0 =A0 capbuf[OSC_SUPPORT_TYPE] |=3D OSC_SB_HOTPLUG_OST_SUPPOR=
T;
> +#endif

This seems a bit strange to me.  For one thing, the _OSC discussion
doesn't seem to indicate that _OST support is specific to CPU or
memory hotplug.  If we tell the platform that we support _OST, the
platform can assume that we'll evaluate _OST for *any* device, which
is not the case.  I guess this is just another reason why we need
hotplug support in the ACPI core, not in the individual drivers.  Then
we wouldn't have the ifdefs at all.

The second thing is that the kernel should be correct at every point
in a patch series.  In this case, if only patch [1/4] is applied, we
claim to support _OST, but we actually don't.  So I think the patches
that add support for evaluating _OST should be first, and this one
should be last.  Or even better, a single patch could enable _OST
evaluation and add this _OSC bit at the same time.

Bjorn

> +
> =A0 =A0 =A0 =A0if (!ghes_disable)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0capbuf[OSC_SUPPORT_TYPE] |=3D OSC_SB_A=
PEI_SUPPORT;
> =A0 =A0 =A0 =A0if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB", &handl=
e)))
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index f421dd8..4127df8 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -277,7 +277,7 @@ acpi_status acpi_run_osc(acpi_handle handle, stru=
ct acpi_osc_context *context);
> =A0#define OSC_SB_PAD_SUPPORT =A0 =A0 =A0 =A0 =A0 =A0 1
> =A0#define OSC_SB_PPC_OST_SUPPORT =A0 =A0 =A0 =A0 2
> =A0#define OSC_SB_PR3_SUPPORT =A0 =A0 =A0 =A0 =A0 =A0 4
> -#define OSC_SB_CPUHP_OST_SUPPORT =A0 =A0 =A0 8
> +#define OSC_SB_HOTPLUG_OST_SUPPORT =A0 =A0 8
> =A0#define OSC_SB_APEI_SUPPORT =A0 =A0 =A0 =A0 =A0 =A016
>
> =A0extern bool osc_sb_apei_support_acked;
> @@ -309,6 +309,30 @@ extern bool osc_sb_apei_support_acked;
>
> =A0extern acpi_status acpi_pci_osc_control_set(acpi_handle handle,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 u32 *mask, u32 req);
> +
> +/* _OST General Processing Status Code */
> +#define ACPI_OST_SC_SUCCESS =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00=
x0
> +#define ACPI_OST_SC_NON_SPECIFIC_FAILURE =A0 =A0 =A0 0x1
> +#define ACPI_OST_SC_UNRECOGNIZED_NOTIFY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A00x2
> +
> +/* _OST OS Shutdown Processing (0x100) Status Code */
> +#define ACPI_OST_SC_OS_SHUTDOWN_DENIED =A0 =A0 =A0 =A0 0x80
> +#define ACPI_OST_SC_OS_SHUTDOWN_IN_PROGRESS =A0 =A00x81
> +#define ACPI_OST_SC_OS_SHUTDOWN_COMPLETED =A0 =A0 =A00x82
> +#define ACPI_OST_SC_OS_SHUTDOWN_NOT_SUPPORTED =A00x83
> +
> +/* _OST Ejection Request (0x3, 0x103) Status Code */
> +#define ACPI_OST_SC_EJECT_NOT_SUPPORTED =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A00x80
> +#define ACPI_OST_SC_DEVICE_IN_USE =A0 =A0 =A0 =A0 =A0 =A0 =A00x81
> +#define ACPI_OST_SC_DEVICE_BUSY =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A00x82
> +#define ACPI_OST_SC_EJECT_DEPENDENCY_BUSY =A0 =A0 =A00x83
> +#define ACPI_OST_SC_EJECT_IN_PROGRESS =A0 =A0 =A0 =A0 =A00x84
> +
> +/* _OST Insertion Request (0x200) Status Code */
> +#define ACPI_OST_SC_INSERT_IN_PROGRESS =A0 =A0 =A0 =A0 0x80
> +#define ACPI_OST_SC_DRIVER_LOAD_FAILURE =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A00x81
> +#define ACPI_OST_SC_INSERT_NOT_SUPPORTED =A0 =A0 =A0 0x82
> +
> =A0extern void acpi_early_init(void);
>
> =A0extern int acpi_nvs_register(__u64 start, __u64 size);
> --
> 1.7.7.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
