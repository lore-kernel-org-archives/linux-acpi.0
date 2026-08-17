Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E648D255F2C
	for <linux-acpi@vger.kernel.org>; Mon, 17 Aug 2026 05:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786942956; cv=pass; b=N+KST2OTE/fL9tFJr6O3EKUx5xSQNuKBhsX1yyEx9I5GZVeKzvve0O2C+UknuW/Xpprr3rWF2jc24CJ+1lZ2/BLGRLK3QWBDUhmh+RgKyYTnGMQquG9Tq/mR0RUtBhhkJrD1+CkOMvOblXdWzY4Ft9cdCyMObXnw/ic5AsqQCZM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786942956; c=relaxed/simple;
	bh=/vnlXw1vg51WClqglYSoXDRtRgD3/bNrYVr/0IH3+kY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rg3admtmd19B6c2YzYLvC+21RKbGF3J+WXfo3xtDTvceTkmFPXwKRo6aKhG5ptsibMhkoiOQWr3ylse46yTeHFhSiHTjaGRpNoYNc7lOhFPsKFq2lHzkJ1Un3QPHZg9QgxRHfVckUmma2F5req+ir6iQTH1BrGZGD+yol694N00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b=IDXII/hI; arc=pass smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.b="IDXII/hI"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-4798bea72f9so1847794f8f.1
        for <linux-acpi@vger.kernel.org>; Sun, 16 Aug 2026 22:02:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786942953; cv=none;
        d=google.com; s=arc-20260327;
        b=aQbnmAuOE84HoQiaus8RF4AaN0y420HryekJOh7hHG7McO+IuTU2QGfHS3shr8KBan
         JirjZiOP05l/Y76wXiyHGJwIuwOYjNgt5TSncOhuhZLK+l2nQQ0q+Dx4oD54yTyMqurC
         BoUA9S5Ze8gxxxHupRCOfitAL5J8GxyRA1Y+vUy6XUYfyMLD7Yfoe3NCwDx8LyXEGWd9
         V9s3qGcfDFHMwTNA7SRaFUQKLrXtvX4+DcVvkwKwhbkhJNiQI2UH6WqkpSQU23eGxUlr
         c9pXbuIoJ5da/scGj2A++b5eUNt+FW20er9WpID3xgx1sXpyGVCkatddXFOHR9NUdXWH
         j3hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qoYi18RDSR4LawRHK5O3loQLaPLqT9tLcA3hUir4WQY=;
        fh=fEqQJaOa+By7/jrNapAmsSelxuU/ITWBZ78qowWjkx0=;
        b=X8JZjlO/MtiZOcjYkbmMbokiM5+tLKi/4+UqYdTEkiRdDVpWNrejJYxaAKXbibu6fL
         0RerEdEzlhLmi5qzmhpfSzAvUXtc2R62skWmWe6iJkE2ZNuye5yIKKQQW9ggAyLqNipW
         r4c5FMz6+fuDm2aQaejJ2VmiIQeYabYfrBUGAaDh7fwqc3yEXEj6UuPcCLtEhv1KW6ZL
         YQUgSf71/fcvOEgh1AaLrL7ZPA89sFRWtgrqLBS2/kgw7ZJ0mW/vSu3Y2pxpSpWXEDJD
         Tyj5YubZZKmx00FDzQXuQI78Zp7SqL+IfIgFqDGsvGyBtclrG6pw0UDklubzgMA9zq1w
         Q7OA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1786942953; x=1787547753; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qoYi18RDSR4LawRHK5O3loQLaPLqT9tLcA3hUir4WQY=;
        b=IDXII/hIrYYNBEUqAQ2HC0Sbt6lU1ITMF0ql3R60uq1nSjPl7hmz20sUPdyfLWeiLn
         ga5t0BXPdBLBbOZGwK0mCGzgFKlq53rPIH3PCZe42gAjWRaTFSCJsVKy20+Q/QCOIfDa
         v2AMV4efAPXN1kno3XC3lVW1XPifC4sSDMc1GcXC0G41IEwZMY2azfyuFWi4MABKWVV9
         YkCWkq9z3YGnb3qa4ch41VHOMO5EuY+h/Vd9k/cwf/NKpV22ry5QFS6lMJiltBrCnNp8
         Cq0W6tC6oSp709e9/hRzZr161A+Qd4InYbkuXr7RFXN6BUaed/WeJRfJLz1+yFK/uCav
         6YTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786942953; x=1787547753;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qoYi18RDSR4LawRHK5O3loQLaPLqT9tLcA3hUir4WQY=;
        b=E1jw0hwzVqHIMlh+rjHNGEDFcsGtYOiITpWDEQwqlpPvd5PBlVCNaCSQOMEfMvnT4d
         pgTT/+PITAVXMdivv93ONAf+DzKku46wPxCPpqslgtqxWPiHPgJKTRGK/bKELQ5ncaCO
         SYAhUNjWN4lTXsoliDUXiU/uzAotIEApKYGAQG9r5timHr1gzT7iLnlmz2FMpEwUHu+f
         oGnEDp3rGQHZfBt65q7jEjX5tII885uu2hTsYmr4E3i6129uiaqho8XGzg2Zh80sJiuq
         6iYQX0Ba3fdfFlmoS9iEdy84De/U2S0IOfokmJ1Yt1aFnPKEokm+9VipVjNjDGcQweZh
         WqGw==
X-Forwarded-Encrypted: i=1; AHgh+RobraOdc3rwIYZuOIOP/8k/uB1IFGKE/svLQY7SEG/35nNUw9lxu1TlNWdl3xql+BCnYkky24c8gSrb@vger.kernel.org
X-Gm-Message-State: AOJu0YwU6Gdco59ilypWXGNU6J4Kh+ZXZrXAy3tEpWzKH4UNHRoG2LNC
	2xpGr+ItKJ52yH8hor9vwo72EJ0881giEC8uiYj10QUcnIFNaiDjZORkMAHawg/VMuhOonpGYZZ
	5wNQESjTDcQssNPHTbivUJcqW6apvIsEgkhQYr/xs/g==
X-Gm-Gg: AR+sD10fdUT3lfBiSk/pFHmhuW/CLbfkieos1dTN7ErLQpl7uzeg1naTLvKx9FdoR6F
	HEof9n0Z4I+hcFy2pw2wMq7NU0EByfaamPe8lCJIwfvmZsIXCd8yB6cE0ukz4LbJFfFN9WvS0eM
	E8Wxc8mhT5eXJF3C2xA5r16Q05klS62vkItIGaeOQTD3t+2i8EWoobxxzqAtua6n+Zxs0EE4MzC
	R295x/Jt2jOCjuvYwWlEDnpmtTENXZG3y0RluDkwZGl1+Vj4uaZ95l6qVm+XqEa8zBFrJJsI5fn
	YIZiSWnKqJxNOePcw561Dm0SrSVLZQ82cpY5K5ksVuIXx9jRTgBoCrUHgHChpzZ2RI1NKL54I7D
	bOvlDVBoXjLcTV6to0MhC1BFgszY+mRTRckHs4b/zW3nFZvZjaaYZ/dNO5YYbqJg=
X-Received: by 2002:a05:6000:2588:b0:47f:97f6:d39a with SMTP id
 ffacd0b85a97d-48160799ccemr36697191f8f.17.1786942952631; Sun, 16 Aug 2026
 22:02:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513084325.2176952-1-himanshu.chauhan@oss.qualcomm.com> <20260513084325.2176952-9-himanshu.chauhan@oss.qualcomm.com>
In-Reply-To: <20260513084325.2176952-9-himanshu.chauhan@oss.qualcomm.com>
From: Anup Patel <anup@brainfault.org>
Date: Mon, 17 Aug 2026 10:32:21 +0530
X-Gm-Features: AcwNN1WIHMlsMJLB7hUwYKC927a3ggaJ6kZFcGlSqz813vIhEHmZTD8KTFxo-cU
Message-ID: <CAAhSdy2LkwC_FBFWP3M66X-mY8WwpSHiOCOKf=e4Fri=gkt27Q@mail.gmail.com>
Subject: Re: [PATCH v4 08/10] riscv: Introduce HEST SSE notification handlers
To: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-efi@vger.kernel.org, 
	acpica-devel@lists.linux.dev, paul.walmsley@sifive.com, palmer@dabbelt.com, 
	lenb@kernel.org, james.morse@arm.com, tony.luck@intel.com, ardb@kernel.org, 
	conor@kernel.org, cleger@rivosinc.com, robert.moore@intel.com, 
	sunilvl@oss.qualcomm.com, anup.patel@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 13, 2026 at 2:18=E2=80=AFPM Himanshu Chauhan
<himanshu.chauhan@oss.qualcomm.com> wrote:
>
> Add config option to enable SSE in APEI. When it is enabled, functions
> to register/unregister a ghes entry with SSE are avilable along with
> low and high priority event handers. If a SSE notification type is
> determined, a ghes common handler to handle an error event is registered.
>
> Signed-off-by: Himanshu Chauhan <himanshu.chauhan@oss.qualcomm.com>
> ---
>  drivers/acpi/apei/Kconfig |  5 ++
>  drivers/acpi/apei/ghes.c  | 99 ++++++++++++++++++++++++++++++++++-----
>  2 files changed, 93 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
> index 428458c623f0..895a843d0e36 100644
> --- a/drivers/acpi/apei/Kconfig
> +++ b/drivers/acpi/apei/Kconfig
> @@ -46,6 +46,11 @@ config ACPI_APEI_SEA
>         depends on ARM64 && ACPI_APEI_GHES
>         default y
>
> +config ACPI_APEI_SSE
> +       bool
> +       depends on RISCV && RISCV_SBI_SSE && ACPI_APEI_GHES
> +       default y
> +
>  config ACPI_APEI_MEMORY_FAILURE
>         bool "APEI memory error recovering support"
>         depends on ACPI_APEI && MEMORY_FAILURE
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 8edc2c8db1bb..1baa8ddd10ea 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -17,6 +17,8 @@
>   *   Author: Huang Ying <ying.huang@intel.com>
>   */
>
> +#include <linux/err.h>
> +#include <linux/riscv_sbi_sse.h>
>  #include <linux/arm_sdei.h>
>  #include <linux/kernel.h>
>  #include <linux/moduleparam.h>
> @@ -100,6 +102,11 @@
>  #define FIX_APEI_GHES_SDEI_CRITICAL    __end_of_fixed_addresses
>  #endif
>
> +#ifndef CONFIG_RISCV_SBI_SSE
> +#define FIX_APEI_GHES_SSE_LOW_PRIORITY __end_of_fixed_addresses
> +#define FIX_APEI_GHES_SSE_HIGH_PRIORITY        __end_of_fixed_addresses
> +#endif
> +
>  static ATOMIC_NOTIFIER_HEAD(ghes_report_chain);
>
>  static inline bool is_hest_type_generic_v2(struct ghes *ghes)
> @@ -1662,6 +1669,63 @@ static int apei_sdei_unregister_ghes(struct ghes *=
ghes)
>         return sdei_unregister_ghes(ghes);
>  }
>
> +#if defined(CONFIG_ACPI_APEI_SSE)
> +/* SSE Handlers */
> +static int __ghes_sse_callback(struct ghes *ghes,
> +                              enum fixed_addresses fixmap_idx)
> +{
> +       if (!ghes_in_nmi_queue_one_entry(ghes, fixmap_idx)) {
> +               irq_work_queue(&ghes_proc_irq_work);
> +
> +               return 0;
> +       }
> +
> +       return -ENOENT;
> +}
> +
> +/* Low priority */
> +static int ghes_sse_lo_callback(u32 event_num, void *arg, struct pt_regs=
 *regs)
> +{
> +       static DEFINE_RAW_SPINLOCK(ghes_notify_lock_sse_lo);
> +       struct ghes *ghes =3D arg;
> +       int err;
> +
> +       raw_spin_lock(&ghes_notify_lock_sse_lo);
> +       err =3D __ghes_sse_callback(ghes, FIX_APEI_GHES_SSE_LOW_PRIORITY)=
;
> +       raw_spin_unlock(&ghes_notify_lock_sse_lo);
> +
> +       return err;
> +}
> +
> +/* High priority */
> +static int ghes_sse_hi_callback(u32 event_num, void *arg, struct pt_regs=
 *regs)
> +{
> +       static DEFINE_RAW_SPINLOCK(ghes_notify_lock_sse_hi);
> +       struct ghes *ghes =3D arg;
> +       int err;
> +
> +       raw_spin_lock(&ghes_notify_lock_sse_hi);
> +       err =3D __ghes_sse_callback(ghes, FIX_APEI_GHES_SSE_HIGH_PRIORITY=
);
> +       raw_spin_unlock(&ghes_notify_lock_sse_hi);
> +
> +       return err;
> +}
> +
> +static int apei_sse_register_ghes(struct ghes *ghes)
> +{
> +       return sse_register_ghes(ghes, ghes_sse_lo_callback,
> +                                ghes_sse_hi_callback);
> +}
> +
> +static int apei_sse_unregister_ghes(struct ghes *ghes)
> +{
> +       return sse_unregister_ghes(ghes);
> +}
> +#else /* CONFIG_ACPI_APEI_SSE */
> +static int apei_sse_register_ghes(struct ghes *ghes) { return -EOPNOTSUP=
P; }
> +static int apei_sse_unregister_ghes(struct ghes *ghes) { return -EOPNOTS=
UPP; }
> +#endif
> +
>  static int ghes_probe(struct platform_device *ghes_dev)
>  {
>         struct acpi_hest_generic *generic;
> @@ -1708,6 +1772,14 @@ static int ghes_probe(struct platform_device *ghes=
_dev)
>                 pr_warn(GHES_PFX "Generic hardware error source: %d notif=
ied via local interrupt is not supported!\n",
>                         generic->header.source_id);
>                 goto err;
> +       case ACPI_HEST_NOTIFY_SSE:
> +               if (!IS_ENABLED(CONFIG_ACPI_APEI_SSE)) {
> +                       pr_warn(GHES_PFX "Generic hardware error source: =
%d notified via SSE is not supported\n",
> +                               generic->header.source_id);
> +                       rc =3D -EOPNOTSUPP;
> +                       goto err;
> +               }
> +               break;
>         default:
>                 pr_warn(FW_WARN GHES_PFX "Unknown notification type: %u f=
or generic hardware error source: %d\n",
>                         generic->notify.type, generic->header.source_id);
> @@ -1775,6 +1847,17 @@ static int ghes_probe(struct platform_device *ghes=
_dev)
>                 if (rc)
>                         goto err;
>                 break;
> +
> +       case ACPI_HEST_NOTIFY_SSE:
> +               rc =3D apei_sse_register_ghes(ghes);
> +               if (rc) {
> +                       pr_err(GHES_PFX "Failed to register for SSE notif=
ication on vector %d\n",
> +                              generic->notify.vector);
> +                       goto err;
> +               }
> +               pr_err(GHES_PFX "Registered SSE notification on vector %d=
\n",
> +                      generic->notify.vector);

This needs to be pr_info() instead of pr_err().

> +               break;
>         default:
>                 BUG();
>         }
> @@ -1804,7 +1887,6 @@ static int ghes_probe(struct platform_device *ghes_=
dev)
>
>  static void ghes_remove(struct platform_device *ghes_dev)
>  {
> -       int rc;
>         struct ghes *ghes;
>         struct acpi_hest_generic *generic;
>
> @@ -1838,16 +1920,11 @@ static void ghes_remove(struct platform_device *g=
hes_dev)
>                 ghes_nmi_remove(ghes);
>                 break;
>         case ACPI_HEST_NOTIFY_SOFTWARE_DELEGATED:
> -               rc =3D apei_sdei_unregister_ghes(ghes);
> -               if (rc) {
> -                       /*
> -                        * Returning early results in a resource leak, bu=
t we're
> -                        * only here if stopping the hardware failed.
> -                        */
> -                       dev_err(&ghes_dev->dev, "Failed to unregister ghe=
s (%pe)\n",
> -                               ERR_PTR(rc));
> -                       return;
> -               }
> +               apei_sdei_unregister_ghes(ghes);
> +               break;
> +
> +       case ACPI_HEST_NOTIFY_SSE:
> +               apei_sse_unregister_ghes(ghes);
>                 break;
>         default:
>                 BUG();
> --
> 2.43.0
>
>

Regards,
Anup
