Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9192B11F;
	Wed,  6 Dec 2023 12:06:39 -0800 (PST)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1fb00ea5e5fso31678fac.1;
        Wed, 06 Dec 2023 12:06:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701893199; x=1702497999;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6mVbvY07pYkHiiTlTxRIvGxjEhdqNcxwJtsKTQ/nDDI=;
        b=Y5Kb0DrZwJYkuyUS8sKcDGhmbtMvXYtTXp3xlE+BHFSWhfoTSJnzRyL5E3qx3KC85/
         IfqcFhwguRlp4C1ClU9mk15JngbZmWKGm5UArQFnxdskO16clO9AOrEUUoxRiJ64FvET
         BVt8d/AVeR9K/BhPkalFMur4WbSNP5GXkIRwlat+BaiWI5IH4W7i47AOVfR/gM5PkLGs
         uEewEIbo6LIMewlLpbU2G/UG4SpVsISyVtBTz/Vbv3lInss5Kq0OrF994KTVnijqK/0u
         jsxyu+1YA1LvfCa/sxyBeUiPHkzc8x3/mF38EDS31zJg+yTxlbTH9j41zRT1A+4JCDZP
         jnHw==
X-Gm-Message-State: AOJu0Yy5yEMgfCYSHDM6qf90YSQ5GJ793Fhvzo9rvFhrw44clZkTcW/4
	pfIpQI42Aqsop1C3JlQRWUgFZ2eKifkSla7Ro00=
X-Google-Smtp-Source: AGHT+IGthp27aptuc4fyPROK3wyhklWrVg614LHtbRm9zhpKyVxhKv8tZAf9o1PArE9oDkUW1PL6jL3Z7rTqTmX4Fzg=
X-Received: by 2002:a05:6870:b4a0:b0:1fb:5e42:5096 with SMTP id
 y32-20020a056870b4a000b001fb5e425096mr2496696oap.5.1701893198784; Wed, 06 Dec
 2023 12:06:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231129071514.31486-1-liuhaoran14@163.com>
In-Reply-To: <20231129071514.31486-1-liuhaoran14@163.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 Dec 2023 21:06:28 +0100
Message-ID: <CAJZ5v0hjGtgJYzixRmhrQZdDFYFw+-EWLJV-Ms27Z=UGO-8J2w@mail.gmail.com>
Subject: Re: [PATCH] [ACPI] fan_core: Add error handling in fan_set_state_acpi4
To: Haoran Liu <liuhaoran14@163.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 29, 2023 at 8:15=E2=80=AFAM Haoran Liu <liuhaoran14@163.com> wr=
ote:
>
> This patch introduces error handling for the acpi_driver_data
> call within the fan_set_state_acpi4 function in
> drivers/acpi/fan_core.c. Previously, the function did not account
> for potential null returns from acpi_driver_data, which could
> lead to instability if encountered.

This needs to explain why/how it is possible for acpi_driver_data() to
return NULL in fan_set_state_acpi4().

> Signed-off-by: Haoran Liu <liuhaoran14@163.com>
> ---
>  drivers/acpi/fan_core.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/acpi/fan_core.c b/drivers/acpi/fan_core.c
> index 9dccbae9e8ea..f2553a47a705 100644
> --- a/drivers/acpi/fan_core.c
> +++ b/drivers/acpi/fan_core.c
> @@ -154,6 +154,12 @@ static int fan_set_state_acpi4(struct acpi_device *d=
evice, unsigned long state)
>         u64 value =3D state;
>         int max_state;
>
> +       if (!fan) {
> +               pr_err("%s: No ACPI fan data "
> +                       "associated with the device\n", __func__);
> +               return -ENODEV;
> +       }
> +
>         if (fan->fif.fine_grain_ctrl)
>                 max_state =3D 100 / fan->fif.step_size;
>         else
> --
> 2.17.1
>
