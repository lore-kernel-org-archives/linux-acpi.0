Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704907;
	b=RFBAbEjVV63ibbUnxW9LwJC0Fkwo/VzqZCWHqTFR+6K18ih4IAc9WByN0kj90/k4k3QU
	 xNnkYCWxds40EotiJM50EJ+LPdOFj1cyQTYXcdR4V/zrXFbz7PhnDkcNatHk4nm36pjeC
	 +g0Nx0N/FuBD89hbN50eoQZbUydevAkfKfVPSMstJY6KYfyBV3JDEejl/UGZELmP0VUYj
	 Sp8OEaDh63BpgJ5sacRmye6wyMTpgiRr1ys0G71ol6W4WPmOk9LxiCgeb2h/C5w+bmRPh
	 u5sMHFeCHL1+M85my4dWaOpNPUL7yyLz9YnyWD7en2BMLPMUdOL0w7h/dtVCz0eA3cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704907;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7PJS4YPTW/2+JkJ8MOH+4k5FYkGwMDLSJYs6Tli8Sqs=;
	b=cPYDNrlNkv5nyr0GbWyvBUrpNFGRg12E9nvwoYrBqzgiNLnI2PnQFVGJKEhs1LdGgAFk
	 r7Z3E/8chHFyZraMZUZyMtzQv7nAuAVcDSBcwf0JFeB/Ckc2vYZapyH6YVvoCJc8JdfE2
	 1AyYdm0OAEG4Dqtr3pBeJsvcc8++a7VECA/iTzDswF4mCfIeqjW5WVRuOJyuLlCNR3G9F
	 x1xmbmuF+zDOm+lUmAq7ZoWervEvr2SFXYHjQ189h9t/ssKaIO3DNILxtCwBPHMc6NvsJ
	 /cpbVDJLRlGHW2TmaGqb7Q9tDgjJ7yU2nvgHIGWfrophCUAiT5vl+bxdSAJ9NR1Zobg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m2NCdfZv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7F3606A321
	for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m2NCdfZv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19041F000D0
	for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 14:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795704906;
	bh=7PJS4YPTW/2+JkJ8MOH+4k5FYkGwMDLSJYs6Tli8Sqs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=m2NCdfZvPnTxM3+6ECqGj1cWrqH8MBe54WVloxOn4Y9tva3ia7Awv/7zxf7kpWFdH
	 3Bg+Zr1xf/DejeiDxxI1m4DZmfbfsy3mNmsQciEqdFKTSbiqUrsIA6i1E9m8CErW8w
	 gsxQ4ulhAwEmLjIjmfTQ5RZeUoZTGQ7zqzsJko3aZ3/zJFg6XX4p3za9qoA8CcoLOC
	 nFEClvbQtGnhsT+SqNiTDX1kOvFVuU4Y/7AVlQbVh0pbuLTNELOmRROHVzRjiKbT6Y
	 GYYrjbQ78mBOZ5aUTJ7A12GwA+m4GVseiKxWw4krlxQMesjFk5daZgarYz9JFwSh4r
	 R/IdOWyBluoBw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5bccecba199so6915503e87.1
        for <linux-acpi@vger.kernel.org>; Thu, 26 Nov 2026 06:55:06 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErEbLcvHmxDGn86oMFtQj4lH9pixXVPXm0gyHiOdLTELh1/5nB0fwApmRcoem1sKoffEMhCLBj8MCokN@vger.kernel.org
X-Gm-Message-State: APuU4Z+RjSiaReSsA4iludiEftc2XUsSDPQKG4muqlyZ14W7xPG3b/FT
	MY7DWxbi0ryek5M9w9T2aZKsnh3E5zlIqFght3lO2Drw26KjuDAmxzd+Uzv+lbzjm2TIpmdEeCv
	bo/CzZZa+Mk8JAIIF+Xs/M5XTzMjOLEo=
X-Received: by 2002:a05:6512:b9d:b0:5c1:513b:5729 with SMTP id
 2adb3069b0e04-5c1bc81a0bbmr7539234e87.51.1795704905312; Thu, 26 Nov 2026
 06:55:05 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122-fdo-gitlab-6061-v1-1-8380b1ec4e09@amd.com>
In-Reply-To: <20261122-fdo-gitlab-6061-v1-1-8380b1ec4e09@amd.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 26 Nov 2026 15:54:53 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gBSKw87PSY2R2N3PNNXihPqS66U7Vk1orFqOtzW+9cOQ@mail.gmail.com>
X-Gm-Features: Aa3M54o63X66mkiIqef_kj1ui40niKeIwHOcDrquhMWzH7MwDm70uUV3N1E35j0
Message-ID: <CAJZ5v0gBSKw87PSY2R2N3PNNXihPqS66U7Vk1orFqOtzW+9cOQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: x86: Work around AMD CPM _L05 notifying a missing
 dGPU on ASUS G513QY
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, Mike Lothian <mike@fireburn.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 22, 2026 at 7:14=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> The AMD CPM D3cold SSDT (OEM table ID "CPMD3CLD") on the ASUS ROG Strix
> G513QY (BIOS G513QY.335) handles the dGPU hotplug GPE with:
>
>   Scope (\_GPE) { Method (_L05) { Notify (\_SB.PCI0.GPP0.VGA, 0x81) } }
>
> On this board the Navi 22 sits behind an on-package PCIe switch and is
> \_SB.PCI0.GPP0.SWUS.SWDS.VGA; \_SB.PCI0.GPP0.VGA is not defined by any
> table.  The interpreter correctly aborts the method:
>
>   ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.GPP0.VGA], A=
E_NOT_FOUND
>   ACPI Error: Aborting method \_GPE._L05 due to previous error (AE_NOT_FO=
UND)
>   ACPI Error: AE_NOT_FOUND, while evaluating GPE method [_L05]
>
> so the Notify is lost and a dGPU in D3cold is never woken for the
> hotplug.

Which presumably doesn't happen in Windows.

Do you know what the difference is?

> Other firmware on the same board (the _L00 handler and the
> ATIF dispatchers) guards both the GPP0.VGA and GPP0.SWUS.SWDS.VGA paths
> with CondRefOf(), so only this method was missed.
>
> Aliasing the missing name is not an option: those guarded branches would
> then both resolve and dispatch to the dGPU twice.  Instead, load a small
> built-in SSDT with a method that notifies the real node and replace _L05
> with a GPE handler that runs it.  The handler defers to a workqueue, as
> AML can't run in interrupt context, and re-arms the level-triggered GPE
> behind the notify queue as ACPICA does for _Lxx methods.
>
> Match the DMI for the G513QY and introduce a new quirk behind a new
> ACPI_AML_QUIRKS option.

I'm totally not a fan of adding AML blobs to the kernel.

It would be better to avoid putting the device in question into D3cold
on the affected system IMV.

> Reported-by: Mike Lothian <mike@fireburn.co.uk>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/6061
> Tested-by: Mike Lothian <mike@fireburn.co.uk>
> Link: https://lore.kernel.org/amd-gfx/20261029151422.56791-1-mike@firebur=
n.co.uk/
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  drivers/acpi/Kconfig          |  16 +++++
>  drivers/acpi/x86/Makefile     |   1 +
>  drivers/acpi/x86/cpm_d3cold.c | 161 ++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 178 insertions(+)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index fa3eb52b22cd8..70a8d3c79a1b5 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -393,6 +393,22 @@ config ACPI_TABLE_OVERRIDE_VIA_BUILTIN_INITRD
>
>           See Documentation/admin-guide/acpi/initrd_table_override.rst fo=
r details
>
> +config ACPI_AML_QUIRKS
> +       bool "Workarounds for known AML bugs in system firmware"
> +       depends on X86
> +       help
> +         Some systems ship AML that cannot work as written, for example =
a
> +         method that notifies a device which does not exist in the names=
pace.
> +         This option builds workarounds for such firmware bugs. Each one=
 is
> +         enabled only on the specific systems it is known to be needed o=
n
> +         (matched by DMI), and loads small built-in tables and/or takes =
over
> +         an ACPI event from the firmware's own method on those systems.
> +
> +         Currently this covers the AMD CPM D3cold dGPU hotplug GPE on th=
e
> +         ASUS ROG Strix G513QY.
> +
> +         Systems that are not on the list are unaffected. If unsure, say=
 N.
> +
>  config ACPI_DEBUG
>         bool "Debug Statements"
>         default y
> diff --git a/drivers/acpi/x86/Makefile b/drivers/acpi/x86/Makefile
> index 63c99509ed9de..04c2c7ffc3a1c 100644
> --- a/drivers/acpi/x86/Makefile
> +++ b/drivers/acpi/x86/Makefile
> @@ -4,5 +4,6 @@ acpi-x86-y              +=3D cmos_rtc.o
>  acpi-x86-$(CONFIG_PCI) +=3D lpss.o
>  acpi-x86-y             +=3D s2idle.o
>  acpi-x86-y             +=3D utils.o
> +acpi-x86-$(CONFIG_ACPI_AML_QUIRKS) +=3D cpm_d3cold.o
>
>  obj-$(CONFIG_X86)      +=3D blacklist.o
> diff --git a/drivers/acpi/x86/cpm_d3cold.c b/drivers/acpi/x86/cpm_d3cold.=
c
> new file mode 100644
> index 0000000000000..8db5d5ba1a2af
> --- /dev/null
> +++ b/drivers/acpi/x86/cpm_d3cold.c
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * cpm_d3cold.c - Work around AMD CPM D3cold tables that notify a missin=
g dGPU
> + *
> + * The AMD CPM D3cold SSDT (OEM table ID "CPMD3CLD") handles the dGPU ho=
tplug
> + * GPE with:
> + *
> + *     Scope (\_GPE) { Method (_L05) { Notify (\_SB.PCI0.GPP0.VGA, 0x81)=
 } }
> + *
> + * On boards where the dGPU sits behind an on-package PCIe switch the de=
vice is
> + * \_SB.PCI0.GPP0.SWUS.SWDS.VGA and \_SB.PCI0.GPP0.VGA does not exist.  =
The
> + * interpreter correctly aborts _L05 with AE_NOT_FOUND, the Notify is lo=
st and
> + * a dGPU in D3cold is never woken for the hotplug.  Other tables from t=
he same
> + * firmware (e.g. the _L00 handler) already guard both paths with CondRe=
fOf().
> + *
> + * Aliasing the missing name is not an option: those other tables would =
then
> + * see both paths and dispatch to the dGPU twice.  Instead, on boards kn=
own to
> + * be affected, load a small SSDT that notifies the real node and run it=
 from a
> + * GPE handler that replaces _L05.
> + *
> + * The built-in SSDT is the following, compiled with iasl:
> + *
> + *     DefinitionBlock ("", "SSDT", 2, "LINUX", "CPML05FX", 1)
> + *     {
> + *         External (\_GPE, DeviceObj)
> + *         External (\_SB.PCI0.GPP0.SWUS.SWDS.VGA, DeviceObj)
> + *
> + *         Scope (\_GPE)
> + *         {
> + *             Method (FX05, 0, NotSerialized)
> + *             {
> + *                 Notify (\_SB.PCI0.GPP0.SWUS.SWDS.VGA, 0x81)
> + *             }
> + *         }
> + *     }
> + */
> +
> +#define pr_fmt(fmt) "ACPI: CPM: " fmt
> +
> +#include <linux/acpi.h>
> +#include <linux/dmi.h>
> +#include <linux/init.h>
> +#include <linux/printk.h>
> +#include <linux/slab.h>
> +
> +#define CPM_D3COLD_GPE         0x05
> +
> +#define CPM_L05_PATH           "\\_GPE._L05"
> +#define CPM_FIX_PATH           "\\_GPE.FX05"
> +#define CPM_MISSING_PATH       "\\_SB.PCI0.GPP0.VGA"
> +#define CPM_DGPU_PATH          "\\_SB.PCI0.GPP0.SWUS.SWDS.VGA"
> +
> +static const u8 cpm_l05_ssdt[] __initconst =3D {
> +       0x53, 0x53, 0x44, 0x54, 0x79, 0x00, 0x00, 0x00, 0x02, 0x7e, 0x4c,=
 0x49,
> +       0x4e, 0x55, 0x58, 0x00, 0x43, 0x50, 0x4d, 0x4c, 0x30, 0x35, 0x46,=
 0x58,
> +       0x01, 0x00, 0x00, 0x00, 0x49, 0x4e, 0x54, 0x4c, 0x28, 0x06, 0x23,=
 0x20,
> +       0xa0, 0x28, 0x00, 0x15, 0x5c, 0x5f, 0x47, 0x50, 0x45, 0x06, 0x00,=
 0x15,
> +       0x5c, 0x2f, 0x06, 0x5f, 0x53, 0x42, 0x5f, 0x50, 0x43, 0x49, 0x30,=
 0x47,
> +       0x50, 0x50, 0x30, 0x53, 0x57, 0x55, 0x53, 0x53, 0x57, 0x44, 0x53,=
 0x56,
> +       0x47, 0x41, 0x5f, 0x06, 0x00, 0x10, 0x2b, 0x5c, 0x5f, 0x47, 0x50,=
 0x45,
> +       0x14, 0x24, 0x46, 0x58, 0x30, 0x35, 0x00, 0x86, 0x5c, 0x2f, 0x06,=
 0x5f,
> +       0x53, 0x42, 0x5f, 0x50, 0x43, 0x49, 0x30, 0x47, 0x50, 0x50, 0x30,=
 0x53,
> +       0x57, 0x55, 0x53, 0x53, 0x57, 0x44, 0x53, 0x56, 0x47, 0x41, 0x5f,=
 0x0a,
> +       0x81
> +};
> +
> +static const struct dmi_system_id cpm_l05_dmi_table[] __initconst =3D {
> +       {
> +               .ident =3D "ASUS ROG Strix G513QY",
> +               .matches =3D {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."=
),
> +                       DMI_MATCH(DMI_BOARD_NAME, "G513QY"),
> +               },
> +       },
> +       {}
> +};
> +
> +static acpi_handle cpm_fix_handle;
> +
> +static void cpm_l05_rearm(void *unused)
> +{
> +       acpi_finish_gpe(NULL, CPM_D3COLD_GPE);
> +}
> +
> +static void cpm_l05_work(void *unused)
> +{
> +       acpi_status status;
> +
> +       status =3D acpi_evaluate_object(cpm_fix_handle, NULL, NULL, NULL)=
;
> +       if (ACPI_FAILURE(status))
> +               pr_err("%s failed: %s\n", CPM_FIX_PATH,
> +                      acpi_format_exception(status));
> +
> +       /*
> +        * Notify() handlers run from the notify workqueue.  As for a fir=
mware
> +        * _Lxx method, only clear and re-enable the level-triggered GPE =
once
> +        * they have been dispatched so it can't storm while the dGPU res=
umes.
> +        */
> +       if (ACPI_FAILURE(acpi_os_execute(OSL_NOTIFY_HANDLER, cpm_l05_rear=
m,
> +                                        NULL)))
> +               cpm_l05_rearm(NULL);
> +}
> +
> +static u32 cpm_l05_gpe_handler(acpi_handle gpe_device, u32 gpe_number,
> +                              void *context)
> +{
> +       /*
> +        * Interrupt context, AML can't run here.  Don't return
> +        * ACPI_REENABLE_GPE: the GPE stays disabled until cpm_l05_rearm(=
).
> +        */
> +       if (ACPI_FAILURE(acpi_os_execute(OSL_GPE_HANDLER, cpm_l05_work, N=
ULL)))
> +               pr_err("unable to queue GPE %02X handler\n", gpe_number);
> +
> +       return ACPI_INTERRUPT_HANDLED;
> +}
> +
> +static int __init cpm_d3cold_l05_init(void)
> +{
> +       struct acpi_table_header *ssdt;
> +       acpi_status status;
> +
> +       if (!dmi_check_system(cpm_l05_dmi_table))
> +               return 0;
> +
> +       /* ACPICA keeps using the table, so it must never be freed */
> +       ssdt =3D kmemdup(cpm_l05_ssdt, sizeof(cpm_l05_ssdt), GFP_KERNEL);
> +       if (!ssdt)
> +               return -ENOMEM;
> +
> +       status =3D acpi_load_table(ssdt, NULL);
> +       if (ACPI_FAILURE(status)) {
> +               pr_err("unable to load fixup table: %s\n",
> +                      acpi_format_exception(status));
> +               kfree(ssdt);
> +               return -ENODEV;
> +       }
> +
> +       status =3D acpi_get_handle(NULL, CPM_FIX_PATH, &cpm_fix_handle);
> +       if (ACPI_FAILURE(status))
> +               return -ENODEV;
> +
> +       status =3D acpi_install_gpe_handler(NULL, CPM_D3COLD_GPE,
> +                                         ACPI_GPE_LEVEL_TRIGGERED,
> +                                         cpm_l05_gpe_handler, NULL);
> +       if (ACPI_FAILURE(status)) {
> +               pr_err("unable to install GPE %02X handler: %s\n",
> +                      CPM_D3COLD_GPE, acpi_format_exception(status));
> +               return -ENODEV;
> +       }
> +
> +       /* Installing the handler dropped the reference taken for _L05 */
> +       status =3D acpi_enable_gpe(NULL, CPM_D3COLD_GPE);
> +       if (ACPI_FAILURE(status))
> +               pr_err("unable to enable GPE %02X: %s\n", CPM_D3COLD_GPE,
> +                      acpi_format_exception(status));
> +
> +       pr_info("%s notifies missing %s, using %s instead\n", CPM_L05_PAT=
H,
> +               CPM_MISSING_PATH, CPM_DGPU_PATH);
> +       return 0;
> +}
> +subsys_initcall_sync(cpm_d3cold_l05_init);
>
> ---
> base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
> change-id: 20261122-fdo-gitlab-6061-d6cbed847dbc
>
> Best regards,
> --
> Mario Limonciello <mario.limonciello@amd.com>
>
>
