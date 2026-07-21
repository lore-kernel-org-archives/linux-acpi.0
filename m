Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDBD39A7FD
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 19:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784661051; cv=none; b=UpJVHEkdAdsJzrukQhEDYNN47QPM/CSpCFNr7ONpMI5aaqUQP/keQyB4a7PbmPpQNXo4VjakE2RakJsEEv/nid9aiCuRc55lAhARSVVcL5PPdG3NQcXxg5ed/9D9HdHMNBp78fYugRHJ7UA/6GCN9SIJZWLXSfQkINZE9Q1T/W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784661051; c=relaxed/simple;
	bh=j8KiH6EQ1lym59qNYMlAoDtQS8lVG0Famynb0hjdySo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CfZnpwm50AuS6f64PGcdeuH3w6mGv0mkQmboF/4UdoHnbxef/3jEXzGyoR3ahgOTbIRoLYLSIPIXYvCtz7imTh36YJSNkQDU+dgn8bQ7+a2q0/Y2dupeZLFdTr0N1vh4l4wQzMm7xPf45K1gMoa8B4H4YVBgYmERJAx6rdZXBIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QN75EZ4s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QN75EZ4s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB791F00A3F
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 19:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784661049;
	bh=tNtHHVFwGpxQHaVpMXKF8FRmpeZ8wZl2sb4A1ijCd6s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=QN75EZ4s+pECSeY+AiTQ8ykVak65il0Z/+rk5+eBINPjctUSh34PwrZphOiK3egli
	 IkRtmCdZeXjwXfx73U3yzYUJKDeIEYqaR4acWaNw9xO/W6McuKN0EDEUs8tpjZYpnG
	 x5bRGM426AlTRwqf/TiUYED0sfrHQCDJ8WrJwFDOpYIe5ePm1urDkIZFQzdDBmTxo+
	 1Dt9woBsL2q/8226DOZkpr73WKLUOnYdNwRS75oAWxR9Y2nUcAguzYdldllnKQkvkt
	 iGz9hfIJbNROxoal7vPyQAZVTy5q7nHwd+4E7dd6pr0CLLwDhDWsVS92rzUSlAzP/k
	 +MkCYvfB2m2bA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b013aa02b2so5644894e87.0
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 12:10:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RprDZgmgi3eXUsmrPJG4qqb4Wsq3YWIBxu1PWhnqzEbMVwe2sbEe5BFjMoe+u6leFqCDTk/JcygusgM@vger.kernel.org
X-Gm-Message-State: AOJu0YwyaQMDcdLy4KTUpmb95+fqGoSAAbZdQGfoy6g/BxL0w/qPt7ks
	K46I3vVrztd73rw/tIWR/n+D4bxvvAI56xyaBiEy4xhbzA2CcyLump6CluPpYcky5PqrDQQBzBm
	1rIzl8d8LuGpg5r9i+iLCWEa+LX/Va18=
X-Received: by 2002:a05:6512:1287:b0:5ae:a500:e368 with SMTP id
 2adb3069b0e04-5b2a9b6e05bmr198262e87.3.1784661048138; Tue, 21 Jul 2026
 12:10:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717063713.3638059-1-maobibo@loongson.cn> <20260717063713.3638059-2-maobibo@loongson.cn>
In-Reply-To: <20260717063713.3638059-2-maobibo@loongson.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 21 Jul 2026 21:10:35 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j4w01XhqQ1EHKCMXOs=v-cddPu=NtdtX3wL7vAi6Y9Rg@mail.gmail.com>
X-Gm-Features: AUfX_mzo6bTT_wAyHF9BAu_bjJXrJRhvsHrxVulWaK89ORoD5JeRVhgH6vEsSzA
Message-ID: <CAJZ5v0j4w01XhqQ1EHKCMXOs=v-cddPu=NtdtX3wL7vAi6Y9Rg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ACPI: LoongArch: Add acpi_arch_[late]_init()
To: Bibo Mao <maobibo@loongson.cn>
Cc: Huacai Chen <chenhuacai@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>, Saket Dumbre <saket.dumbre@intel.com>, linux-kernel@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-acpi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, lixianglai@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 8:44=E2=80=AFAM Bibo Mao <maobibo@loongson.cn> wrot=
e:
>
> LoongArch IOMMU scanning flow is similar with virtio-iommu,
> there is early init and late_init. In early init function, PCI
> ACS is enabled if there is IOMMU table, and late_init is called
> after PCI device scanning, where IOVT table scanning function is
> executed.
>
> Here add acpi_arch_init() and acpi_arch_late_init() API on LoongArch,
> now they are both empty, In the future, IOVT table parsing will be
> added.
>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  drivers/acpi/Makefile           |  2 +-
>  drivers/acpi/bus.c              |  2 ++
>  drivers/acpi/loongarch/Makefile |  2 ++
>  drivers/acpi/loongarch/init.c   | 11 +++++++++++
>  include/linux/acpi.h            |  1 +
>  5 files changed, 17 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/acpi/loongarch/Makefile
>  create mode 100644 drivers/acpi/loongarch/init.c
>
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index d1b0affb844f..91584a3c1e01 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -131,6 +131,6 @@ obj-y                               +=3D dptf/
>  obj-$(CONFIG_ARM64)            +=3D arm64/
>
>  obj-$(CONFIG_ACPI_VIOT)                +=3D viot.o
> -
> +obj-$(CONFIG_LOONGARCH)                +=3D loongarch/
>  obj-$(CONFIG_RISCV)            +=3D riscv/
>  obj-$(CONFIG_X86)              +=3D x86/
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index a30a904f6535..5f6924b9e29d 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -1571,6 +1571,7 @@ struct kobject *acpi_kobj;
>  EXPORT_SYMBOL_GPL(acpi_kobj);
>
>  void __weak __init acpi_arch_init(void) { }
> +void __weak __init acpi_arch_late_init(void) { }
>
>  static int __init acpi_init(void)
>  {
> @@ -1609,6 +1610,7 @@ static int __init acpi_init(void)
>         acpi_wakeup_device_init();
>         acpi_debugger_init();
>         acpi_setup_sb_notify_handler();
> +       acpi_arch_late_init();
>         acpi_viot_init();
>         return 0;
>  }
> diff --git a/drivers/acpi/loongarch/Makefile b/drivers/acpi/loongarch/Mak=
efile
> new file mode 100644
> index 000000000000..d3764139dfaf
> --- /dev/null
> +++ b/drivers/acpi/loongarch/Makefile
> @@ -0,0 +1,2 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-y                                  +=3D init.o
> diff --git a/drivers/acpi/loongarch/init.c b/drivers/acpi/loongarch/init.=
c
> new file mode 100644
> index 000000000000..b11aa5c7d928
> --- /dev/null
> +++ b/drivers/acpi/loongarch/init.c
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/acpi.h>
> +
> +void __init acpi_arch_init(void)
> +{
> +}
> +
> +void __init acpi_arch_late_init(void)
> +{
> +}
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 60ab50cb8930..c6a180341c2d 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -1617,6 +1617,7 @@ static inline int acpi_pptt_get_cpumask_from_cache_=
id(u32 cache_id,
>  #endif
>
>  void acpi_arch_init(void);
> +void acpi_arch_late_init(void);
>
>  #ifdef CONFIG_ACPI_PCC
>  void acpi_init_pcc(void);
> --

Please fold this one into the patch in which the new function is actually u=
sed.

Thanks!
