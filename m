Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511223AF678
	for <linux-acpi@vger.kernel.org>; Wed, 15 Apr 2026 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776272977; cv=none; b=XmqG9GVCPi3k+8/zootG50pmpLr0kh2LfyY8AQTg7ncUK/vaHnE0z465NC4WrDDEnCVhI53wqDK1XZyksP7b8jF77+bsPU6gaF5YAR/xxHwYUOqB99Q+Nl6nFGx6BAsnieOr18T0UxiX6j6WghG5eFkg43viWLGLfIkdM+ltrW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776272977; c=relaxed/simple;
	bh=evVNg2mwISfuua7/LnejCpCCTdzRjZGYd06vxhXutik=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QvcLC+IuGivRsDIH/2AKind3MkHMpdKuf4brsMFJkxu7VKYBAzY1tUDZUaevjJ2SOD/IlXofCyIvMKU7vJkAMyyAqEed/Y90iiObzqfcF6r0klYIrqWnybthgHFQOqmc4XuqCpyGa2cEnmINf7w6lgUPIbNcL30g3ZXoPvN+LsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GtYo5oxl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GtYo5oxl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A18C4AF09
	for <linux-acpi@vger.kernel.org>; Wed, 15 Apr 2026 17:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776272977;
	bh=evVNg2mwISfuua7/LnejCpCCTdzRjZGYd06vxhXutik=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GtYo5oxlzi2OTkkiIr3LNPAfjPcB0PQ5zyBAnx9FlB7f1lRAOIG/HJAxBvlyLRPF7
	 bc6g+O+gb/Z6QRskbK/ZGfLWaLLEu2RzxYCFPDBxc8Jzj9P30MaShDuKId/VhcTo6W
	 1guwM70bIWKW7f++dE9e5DA86IWvvFc3sJ4i8E7f6h8ljukshHt2KlyMkZlDaSvicy
	 8adLQajM+6NURJXF5NfoLl72GRrcLV7Eul+RGdHqorOvbxTzvzq5acBiGAOWGHRLHA
	 tmtnvw1rjQxvlIQ+hNZD2QKlnzp5lLXoeZEyoJSd5Ss+C/W+aH53TafPeixlYlhfWt
	 Ig5Fp8N5VJthA==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-679b072ed3aso3207717eaf.1
        for <linux-acpi@vger.kernel.org>; Wed, 15 Apr 2026 10:09:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9/wIhJNJXsKWXzvs7p3qEd+/w9G+k2YMDnutp2tL/Fp3uJDpXpmKDx1MrSmaARCimQKQbakyCZyM7h@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7v7K3F88uDkQx/w6OLVEaXOLIXDqhGc0p/9+ROpT4sNeFlnS7
	q1Um3wkTI0OmDRuzF0RH/AcG9k5p+pKTwMrPhVzOX2U2EvH0CDJ53Y6aAq0sY5hzwOp8lYgToLL
	S/dtNBUmzaeLz/EUkL4qjA/+Bd4nJsVU=
X-Received: by 2002:a05:6820:1f07:b0:67e:160c:36ab with SMTP id
 006d021491bc7-68be6624f57mr11276879eaf.26.1776272976075; Wed, 15 Apr 2026
 10:09:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413135343.2884481-1-lgs201920130244@gmail.com>
In-Reply-To: <20260413135343.2884481-1-lgs201920130244@gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 15 Apr 2026 19:09:24 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i4j4T_O67_xRXNV75bwGrPTbUrpPjBA-jepz+MGoseQw@mail.gmail.com>
X-Gm-Features: AQROBzC96gVUmjkZescl7wYhARDhHqJnwbrTvvAyPF5nojbA3e097dTNTeoA8wk
Message-ID: <CAJZ5v0i4j4T_O67_xRXNV75bwGrPTbUrpPjBA-jepz+MGoseQw@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: scan: Use acpi_dev_put() in object add error paths
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Lin Ming <ming.m.lin@intel.com>, 
	Hugh Dickins <hugh.dickins@tiscali.co.uk>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 13, 2026 at 3:54=E2=80=AFPM Guangshuo Li <lgs201920130244@gmail=
.com> wrote:
>
> After acpi_init_device_object(), the lifetime of struct acpi_device is
> managed by the driver core through reference counting.
>
> Both acpi_add_power_resource() and acpi_add_single_object() call
> acpi_init_device_object() and then invoke acpi_device_add(). If that
> fails, their error paths call the release callback directly instead of
> dropping the device reference through acpi_dev_put().
>
> This bypasses the normal device lifetime rules and frees the object
> without releasing the reference acquired by device_initialize(), which
> may lead to a refcount leak.
>
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review.
>
> Fix both error paths by using acpi_dev_put() and let the release
> callback handle the final cleanup.
>
> Fixes: 781d737c7466 ("ACPI: Drop power resources driver")
> Fixes: 718fb0de8ff88 ("ACPI: fix NULL bug for HID/UID string")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v3:
>   - Note that the issue was identified by my static analysis tool
>   - and confirmed by manual review
>
> v2:
>   - Use acpi_dev_put() instead of put_device()
>   - Fix acpi_add_single_object() together with acpi_add_power_resource()
>   - Update the subject and commit message accordingly
>
>  drivers/acpi/power.c | 2 +-
>  drivers/acpi/scan.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
> index 361a7721a6a8..542e182f94f1 100644
> --- a/drivers/acpi/power.c
> +++ b/drivers/acpi/power.c
> @@ -991,7 +991,7 @@ struct acpi_device *acpi_add_power_resource(acpi_hand=
le handle)
>         return device;
>
>   err:
> -       acpi_release_power_resource(&device->dev);
> +       acpi_dev_put(device);
>         return NULL;
>  }
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index 416d87f9bd10..5124ed02debc 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -1910,7 +1910,7 @@ static int acpi_add_single_object(struct acpi_devic=
e **child,
>                 result =3D acpi_device_add(device);
>
>         if (result) {
> -               acpi_device_release(&device->dev);
> +               acpi_dev_put(device);
>                 return result;
>         }
>

Applied as 7.1-rc material, thanks!

> --
> 2.43.0
>
