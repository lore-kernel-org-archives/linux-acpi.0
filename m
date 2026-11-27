Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793788;
	b=Nee9s+LP2pPbKPE2Eh3xFcp7uJfDUUluZwBoK11r/hjLBbVCxUhCC46RivMnywd0z2/A
	 JdTvYHxmpLBogwaC3+6rHW+tK6Xjt+Al30PH4+vU2UnAFUiVX+4SAcV9RIThU4xIu2SvJ
	 wKmPSxrmnalhKvMxFQSdB2/Rql+eNmAStdva5XivWS4lAtExDrz3rRpaEo4cxyoDMwQ6W
	 J7offHQtpaZ0K8N0QvTiKOIrqK/BeC69tI7L0kHNtle3N35/e2u3DnwL8bzBpzOY44sxZ
	 vr/qjUogzGhaGcIbHQGqFAEs61B6Z/vf1g7oFrmgCFc3LjNe+jscVqQi87ryocMByLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793788;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=w2jVZGlmJLc00xihx82mAnoTJNcff4nr2CNxxcQOC0I=;
	b=dfRSQs2Gk8Igg8XlDzl0q2/9/vNEQ30a7Ue/sDSJXowglLXBfCxGh5B4+uOclg6e8bER
	 wsIT9jv7t7GKfVXrt2fJR4KMry4DKVntfyQ0DvwymVV58CK5wVKDTuhog9eETDL94ceWe
	 77wRtiqTa1K2t9Zv6l5T5vBxCXpub+UTVkiXZpZ4b5Ur0aq7cutzz+XPyJ4ulvqQZHW0l
	 uhLvYesGe3qc5L1H87cd04TgEcpzopSkq1mnsp46NFWuiYCxh4xjXe78VPZSOIh95Yx5C
	 RepwWQoOnqyVkRXEz8qMWGlkvK0ByUy+DQNYLyOHu6ClAodNqVCNmB3W2Z2uINs9SSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cHOScReJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E63606A321
	for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2026 15:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cHOScReJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD861F0089C
	for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2026 15:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795793787;
	bh=w2jVZGlmJLc00xihx82mAnoTJNcff4nr2CNxxcQOC0I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cHOScReJP7aCKzihZUtxDQndRJd1u34XMvId/PTaM0E2FnwPYtNG0V3S1cHO3dvDz
	 laFcghqOcITv99OHKGEIy6gC7DsJrUYh+piDZysbk4SPw3TckRJZkbH4AXkx8njzds
	 JwjkG8tA8IsJejF4u9d4wCEe30Y1oR1HnljEm4oVmRnUiwahl8tcLBMbMbOzxEKGL7
	 yXIP9zuXtpAZaKdXXe50yKaoMbC7qjRmmcxWVuBmM0F5xZu3CgiPo1NhRArOyyFYqK
	 Mb45h3zBzHpUvJB72ZhOhqhAgavJcWQr7sdapoEG9stuin26W0cMAcNzHI+IOBr59Q
	 Wwa+UjhkcsyoA==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5c07c7306e1so7048005e87.1
        for <linux-acpi@vger.kernel.org>; Fri, 27 Nov 2026 07:36:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErF/RCxhTse9xAOEpZFAohxFggKnCUQDTtULXmwWHvSYUKM1DKO38rgEBiedzXMhQDDWQU+XNk21u0uj@vger.kernel.org
X-Gm-Message-State: APuU4Z8ExbjNu1NF55DQgCv0MxAQQ+Lp++LOO3Dfrn3b+8ud3Wcx90DH
	jSA5xp8GjoLBlU8Z9krlo7f8RPBofWFK5Yp4LS0s8tb44avyhrSSU7i09AtpYFsJS7u7RVqh9ne
	A7zuVOxswj9n/LVRn8mWqXw0KN7317lI=
X-Received: by 2002:a05:6512:238a:b0:5bf:a6e9:4cc with SMTP id
 2adb3069b0e04-5c1bc680e91mr6776625e87.1.1795793785922; Fri, 27 Nov 2026
 07:36:25 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261126060825.910-1-luob87709@gmail.com>
In-Reply-To: <20261126060825.910-1-luob87709@gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 27 Nov 2026 16:36:12 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0giAORstOTeds2bPpQVVJQ2aC7D4ah9oAMDEZvvBEraPQ@mail.gmail.com>
X-Gm-Features: Aa3M54qcbFiW2XenZglxjjFI7zAb5v3QRPSrOYk6ZuWdkJtnn3jMQpgjnmU47n0
Message-ID: <CAJZ5v0giAORstOTeds2bPpQVVJQ2aC7D4ah9oAMDEZvvBEraPQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: APEI: GHES: sync ghes_proc_irq_work before freeing ghes
To: "Bin Luo (University of Electronic Science and Technology of China)" <luob87709@gmail.com>
Cc: rafael@kernel.org, tony.luck@intel.com, bp@alien8.de, guohanjun@huawei.com, 
	mchehab@kernel.org, xueshuai@linux.alibaba.com, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 26, 2026 at 7:08=E2=80=AFAM Bin Luo (University of Electronic
Science and Technology of China) <luob87709@gmail.com> wrote:
>
> NMI, SEA, and SDEI handlers enqueue estatus nodes holding a raw
> estatus_node->ghes pointer onto ghes_estatus_llist and schedule
> ghes_proc_irq_work to run ghes_proc_in_irq().
>
> During ghes_remove(), ghes_nmi_remove(), ghes_sea_remove(), and
> apei_sdei_unregister_ghes() stop further callbacks and synchronize RCU,
> but do not synchronize ghes_proc_irq_work before ghes_fini() and
> kfree(ghes). In addition, ghes_in_nmi_spool_from_list() calls
> irq_work_queue(&ghes_proc_irq_work) after rcu_read_unlock(), leaving a
> window where synchronize_rcu() can finish before the irq_work is queued.
>
> Move irq_work_queue(&ghes_proc_irq_work) inside the RCU read-side
> critical section in ghes_in_nmi_spool_from_list(), and call
> irq_work_sync(&ghes_proc_irq_work) in the NMI, SEA, and SDEI removal
> paths so all queued estatus nodes for the removed source are drained
> before ghes is freed.
>
> Fixes: 67eb2e990767 ("ACPI, APEI, GHES, printk support for recoverable er=
ror via NMI")
> Signed-off-by: Bin Luo (University of Electronic Science and Technology o=
f China) <luob87709@gmail.com>

Sashiko has feedback on this:

https://sashiko.dev/#/patchset/20261126060825.910-1-luob87709%40gmail.com

Please address it or if it doesn't need to be addressed, please let me know=
 why.

> ---
> Found by code inspection. Compile-tested on x86_64 with W=3D1 and KASAN
> (drivers/acpi/apei/ghes.o); not runtime-tested on APEI/NMI hardware.
>
>  drivers/acpi/apei/ghes.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> index 5d888c8..75dd603 100644
> --- a/drivers/acpi/apei/ghes.c
> +++ b/drivers/acpi/apei/ghes.c
> @@ -1483,10 +1483,10 @@ static int __maybe_unused ghes_in_nmi_spool_from_=
list(struct list_head *rcu_list
>                 if (!ghes_in_nmi_queue_one_entry(ghes, fixmap_idx))
>                         ret =3D 0;
>         }
> -       rcu_read_unlock();
>
>         if (IS_ENABLED(CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG) && !ret)
>                 irq_work_queue(&ghes_proc_irq_work);
> +       rcu_read_unlock();
>
>         return ret;
>  }
> @@ -1600,6 +1600,7 @@ static void ghes_sea_remove(struct ghes *ghes)
>         mutex_unlock(&ghes_list_mutex);
>         ghes_unmap_error_status(ghes);
>         synchronize_rcu();
> +       irq_work_sync(&ghes_proc_irq_work);
>  }
>  #else /* CONFIG_ACPI_APEI_SEA */
>  static inline int ghes_sea_add(struct ghes *ghes) { return -EINVAL; }
> @@ -1663,10 +1664,11 @@ static void ghes_nmi_remove(struct ghes *ghes)
>         ghes_unmap_error_status(ghes);
>
>         /*
> -        * To synchronize with NMI handler, ghes can only be
> -        * freed after NMI handler finishes.
> +        * To synchronize with NMI handler and any queued estatus work,
> +        * ghes can only be freed after both complete.
>          */
>         synchronize_rcu();
> +       irq_work_sync(&ghes_proc_irq_work);
>  }
>  #else /* CONFIG_HAVE_ACPI_APEI_NMI */
>  static inline int ghes_nmi_add(struct ghes *ghes) { return -EINVAL; }
> @@ -1921,6 +1923,7 @@ static void ghes_remove(struct platform_device *ghe=
s_dev)
>                                 ERR_PTR(rc));
>                         return;
>                 }
> +               irq_work_sync(&ghes_proc_irq_work);
>                 break;
>         default:
>                 BUG();
> --
> 2.43.0
>
>
