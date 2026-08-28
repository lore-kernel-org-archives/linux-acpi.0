Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF483B05BB
	for <linux-acpi@vger.kernel.org>; Fri, 28 Aug 2026 09:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787911141; cv=none; b=Y7c8YcTkleEvZg1GbbZOlbl5FiausZxIkqf334PSXt365qH9y0HBkFMQZn4Px8IrbTejLGDnh1nkK56Q3X9m6quVOGHBBF7bS8w3EvXE1F3cAoLsKPKnbdJz236q6smMtGROQQJDv9mIchqautBq3KWRLsa/3A3QBrcZrJTcJQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787911141; c=relaxed/simple;
	bh=4Gw+xvK1zff6Jw8C+AR+tG13riL7oBrW2dziuVmc6Jk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gTrqiceY4C4qw5v1SicKYFUsj7T5DpjvdhN69WO+So/LGfWFaCiIShnscjCI/YnIgGVMc2d4aUJEej5GLh+TezzkLGyJCxPHJl9XJMJLSkgBPwQYwEW+mpc6c5j6Ed9FJEcopO5GqihcCV94SSvawQUaqgSsrpK7G4Ih1rfv1qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K2RqFouy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K2RqFouy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C5831F00A3A
	for <linux-acpi@vger.kernel.org>; Fri, 28 Aug 2026 09:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787911135;
	bh=WLNLKbNx4UMYvJLUu3Pn2H6lYbTaqbRs2pu7vc93kIo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=K2RqFouyJgxglGOny2TwkV5xlYV2K/sEJ2Ap0e3d20bM/dfVNPZu2xSq1+lFCzUzt
	 Sw0YN+ZHegJluL9aw+zZ2PL86gVwR9JeRThLmJN8oU9gtwnV4GlhDlIVdDj8T+t1y8
	 xw3ShFAqaQk7DURunFUHiiXdAK/s/FX9cl+lviPZwtl/OKfFvdmZxIGXErsPDoUuiH
	 uFVZ4QjFf2s/R3iTTMIrpLBza5GbugEOIb5Lzljz9pKVV7L+YAP7qUJjJzGPdw+0E5
	 8iSfwKIJPt036g/7wd93kctCOoCaeoxNDmwEtqIbbzB1gc/Ofcm6qnNZSW2LBPef9O
	 O+gPysHCVDN9Q==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-39faf9e2c62so3623671fa.3
        for <linux-acpi@vger.kernel.org>; Fri, 28 Aug 2026 02:58:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpNJ0FzqH1vgkqnSb0zJkYL5c7BYetTG9dOC4aUGXYlFIhbXUiZDQbl//7oPwNwDhA7OA3+lzge5073@vger.kernel.org
X-Gm-Message-State: AFuF++mCZO/weitq2yLu3vKVC+Drr/xidvGLantjWs3tx0gWEQFIjjnI
	DmUihvHBNt1X8BOI7rYy/W+qpubYx0XPK4a3szwP+x3RYaot6sJYnvRciTNIUvhbeMqfg2wJWLg
	WzsQc3pqRAgSJoh9Ba5cXbliOihmwc2A=
X-Received: by 2002:a05:651c:199e:b0:3a1:8c8c:3872 with SMTP id
 38308e7fff4ca-3a30188d003mr9327231fa.7.1787911133539; Fri, 28 Aug 2026
 02:58:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828084328.257703-1-sakari.ailus@linux.intel.com> <20260828084328.257703-2-sakari.ailus@linux.intel.com>
In-Reply-To: <20260828084328.257703-2-sakari.ailus@linux.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 28 Aug 2026 11:58:05 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h4Pm0RRk3sauoGjjq1y-YNuKhH2RvFNY8k6ywZdoE64A@mail.gmail.com>
X-Gm-Features: AcwNN1WpE-PEo382cm97ZojLO5mR4viG3sx8YOpRmte6IDKcfK_IS0jUVSCpHLs
Message-ID: <CAJZ5v0h4Pm0RRk3sauoGjjq1y-YNuKhH2RvFNY8k6ywZdoE64A@mail.gmail.com>
Subject: Re: [PATCH 1/3] media: ipu-bridge: Drop redundant ACPI_PTR() usage
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, linux-acpi@vger.kernel.org, rafael@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 10:43=E2=80=AFAM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> The ipu-bridge depends on CONFIG_ACPI, therefore ACPI_PTR(ptr) always
> yields ptr. Drop all use of ACPI_PTR() in the ipu-bridge.
>
> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  drivers/media/pci/intel/ipu-bridge.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/media/pci/intel/ipu-bridge.c b/drivers/media/pci/int=
el/ipu-bridge.c
> index f9efa501e8cf..cdd654efd1dd 100644
> --- a/drivers/media/pci/intel/ipu-bridge.c
> +++ b/drivers/media/pci/intel/ipu-bridge.c
> @@ -17,7 +17,7 @@
>  #include <media/ipu-bridge.h>
>  #include <media/v4l2-fwnode.h>
>
> -#define ADEV_DEV(adev) ACPI_PTR(&((adev)->dev))
> +#define ADEV_DEV(adev) &(adev)->dev
>
>  /*
>   * 92335fcf-3203-4472-af93-7b4453ac29da
> @@ -239,12 +239,12 @@ static struct acpi_device *ipu_bridge_get_ivsc_acpi=
_dev(struct acpi_device *adev
>         for (i =3D 0; i < ARRAY_SIZE(ivsc_acpi_ids); i++) {
>                 const struct acpi_device_id *acpi_id =3D &ivsc_acpi_ids[i=
];
>                 struct acpi_device *consumer, *ivsc_adev;
> -               acpi_handle handle =3D acpi_device_handle(ACPI_PTR(adev))=
;
> +               acpi_handle handle =3D acpi_device_handle(adev);
>
>                 for_each_acpi_dev_match(ivsc_adev, acpi_id->id, NULL, -1)
>                         /* camera sensor depends on IVSC in DSDT if exist=
 */
>                         for_each_acpi_consumer_dev(ivsc_adev, consumer)
> -                               if (ACPI_PTR(consumer->handle) =3D=3D han=
dle) {
> +                               if (consumer->handle =3D=3D handle) {
>                                         acpi_dev_put(consumer);
>                                         return ivsc_adev;
>                                 }
> @@ -322,8 +322,7 @@ static int ipu_bridge_read_acpi_buffer(struct acpi_de=
vice *adev, char *id,
>         acpi_status status;
>         int ret =3D 0;
>
> -       status =3D acpi_evaluate_object(ACPI_PTR(adev->handle),
> -                                     id, NULL, &buffer);
> +       status =3D acpi_evaluate_object(adev->handle, id, NULL, &buffer);
>         if (ACPI_FAILURE(status))
>                 return -ENODEV;
>
> @@ -379,7 +378,7 @@ static enum v4l2_fwnode_orientation ipu_bridge_parse_=
orientation(struct acpi_dev
>         enum v4l2_fwnode_orientation orientation;
>         struct acpi_pld_info *pld =3D NULL;
>
> -       if (!acpi_get_physical_device_location(ACPI_PTR(adev->handle), &p=
ld)) {
> +       if (!acpi_get_physical_device_location(adev->handle, &pld)) {
>                 dev_warn(ADEV_DEV(adev), "_PLD call failed, using default=
 orientation\n");
>                 return V4L2_FWNODE_ORIENTATION_EXTERNAL;
>         }
> @@ -785,7 +784,7 @@ static int ipu_bridge_connect_sensor(const struct ipu=
_sensor_config *cfg,
>         int ret;
>
>         for_each_acpi_dev_match(adev, cfg->hid, NULL, -1) {
> -               if (!ACPI_PTR(adev->status.enabled))
> +               if (!adev->status.enabled)
>                         continue;
>
>                 if (bridge->n_sensors >=3D IPU_MAX_PORTS) {
> @@ -821,7 +820,7 @@ static int ipu_bridge_connect_sensor(const struct ipu=
_sensor_config *cfg,
>                         goto err_free_swnodes;
>                 }
>
> -               sensor->adev =3D ACPI_PTR(acpi_dev_get(adev));
> +               sensor->adev =3D acpi_dev_get(adev);
>
>                 primary =3D acpi_fwnode_handle(adev);
>                 primary->secondary =3D fwnode;
> @@ -881,7 +880,7 @@ static int ipu_bridge_ivsc_is_ready(void)
>                         &ipu_supported_sensors[i];
>
>                 for_each_acpi_dev_match(sensor_adev, cfg->hid, NULL, -1) =
{
> -                       if (!ACPI_PTR(sensor_adev->status.enabled))
> +                       if (!sensor_adev->status.enabled)
>                                 continue;
>
>                         adev =3D ipu_bridge_get_ivsc_acpi_dev(sensor_adev=
);
> --
> 2.47.3
>
