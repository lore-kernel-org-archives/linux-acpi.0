Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B107493D33
	for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818242; cv=none; b=GmeYLk36984gafcVJtCWLOtN0kI9p6E4Q9lcAEZcidSP6ngQZLffIP1gN1Txa5hlWbUnCdn6eslpmzbN4bJaX05H0Muv43BaEbqXqavRfKeY9EgFr5nMwUEhowKXdWlxCP8BmVyEFSQdbB/+oVgGLljt9t9hKLHl211ZVe+rHqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818242; c=relaxed/simple;
	bh=Rm+AoVWth0l9xvOJCC5NXQ8zQdcFD25bmivCEWeAjTk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=po2YmoYdGDaPUnBNzmpLJi87YmmbR5ChDD3uJ5Hr3ADfGtPqiEMF8v5I4yInUyP7UfKW2HfddqYGVNdgaG+5KMkVq2QUlzSjwdkUR6hw5d8y2qQLaR1GeoWjsrQAnqy4k8PxyScLob1+2uZMBlmwGyCftn7EOMCgG/ztEeYablM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5p+S3dS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5p+S3dS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0E21F0089C
	for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 15:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791818240;
	bh=7k9wLBTJR6qE3ai0dOeNauze3y32DWDC7I1FjsJrBqg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=n5p+S3dS+313JiWtpsESkJxGG5CvZJ1MgLA3EkbALDwjEafHfxwUw+Usgh39RClrU
	 /m+2K0oOJIiSATL6WHlITIkdxEbe6Jxta7c8v37GiTL1B7d0YwPM4zoyLzGWlwkknQ
	 GcRvtb9QUIAG86Dblt09PB2PolPibzdyHMfhncNSWusturhx1Svf9V3lZRjUWaphaV
	 mhtfe8eTlxkG50Z2rp8kxufBEPaG1K6BfY8wzsIDs0ayQ9tk0d0dH8gOtVMwZ3/eCp
	 GPa5qsA9fe96pqxgyANU6FV3ID0i/Itco6UT0VhkCI2ctJO/ulK3MTMy2yDovGauqC
	 DuW7Phk9nxO7Q==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5bcd17f3a93so1666179e87.2
        for <linux-acpi@vger.kernel.org>; Mon, 12 Oct 2026 08:17:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBykYjCCZMAQvL78Gkv/jNE+qog8f9YN1DGTcuYHIlHqnvA80Tg2nN+nb77rpnWHkmv9TxuSb6G+hwCv@vger.kernel.org
X-Gm-Message-State: AFq9FYIyKaR8L7g56lewQdul4fk+sG1oRUAm11h8k4u0ZWYfBU0YiqFq
	l8ckhbwrWl+YB+tZQwz8LGZxfLjwS7fHaQiP2JzoSoayJA3WeCEXMr9u//vCuiGY6aGBWIKPLmO
	gjS659+gmK/dFnve7YHb13Yg3RCHDGSs=
X-Received: by 2002:a05:6512:3192:b0:5b8:f197:ea18 with SMTP id
 2adb3069b0e04-5bcde6cae0amr3160057e87.38.1791818238431; Mon, 12 Oct 2026
 08:17:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923082932.1049270-1-uajain@igalia.com> <20260923082932.1049270-2-uajain@igalia.com>
In-Reply-To: <20260923082932.1049270-2-uajain@igalia.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Mon, 12 Oct 2026 17:15:14 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i0UPcGiiAxNbjUnzn=8D2jcTCo_wtM8aMbOKhqb37EDA@mail.gmail.com>
X-Gm-Features: AclHuK-8eFg2xvB8WzSOZUOKOQbhO8bChN6AQjnOraOZQkwsL5TlOaIi2psfNWM
Message-ID: <CAJZ5v0i0UPcGiiAxNbjUnzn=8D2jcTCo_wtM8aMbOKhqb37EDA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] acpi: battery: Query Battery charge time ("_BCT") method
To: Umang Jain <uajain@igalia.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 10:28=E2=80=AFAM Umang Jain <uajain@igalia.com> wro=
te:
>
> Add plumbing for querying the Battery Charge Time ("_BCT") method.
> If present, set ACPI_BATTERY_BCT_PRESENT in battery flags to denote
> that the method is supported in ACPI.
>
> Signed-off-by: Umang Jain <uajain@igalia.com>
> ---
>  drivers/acpi/battery.c | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
> index 670853ec3a4d..a1b7a821abaf 100644
> --- a/drivers/acpi/battery.c
> +++ b/drivers/acpi/battery.c
> @@ -76,6 +76,7 @@ MODULE_DEVICE_TABLE(acpi, battery_device_ids);
>  enum {
>         ACPI_BATTERY_ALARM_PRESENT,
>         ACPI_BATTERY_XINFO_PRESENT,
> +       ACPI_BATTERY_BCT_PRESENT,
>         ACPI_BATTERY_QUIRK_PERCENTAGE_CAPACITY,
>         /* On Lenovo Thinkpad models from 2010 and 2011, the power unit
>          * switches between mWh and mAh depending on whether the system
> @@ -110,6 +111,7 @@ struct acpi_battery {
>
>         struct mutex property_lock; /* Protects properties below. */
>         unsigned long update_time;
> +       unsigned long long charge_time;

This doesn't need to be unsigned long long.  As per the spec, unsigned
int should be sufficient.

>         int revision;
>         int rate_now;
>         int capacity_now;
> @@ -613,6 +615,10 @@ static int acpi_battery_get_state(struct acpi_batter=
y *battery)
>         int result =3D 0;
>         acpi_status status =3D 0;
>         struct acpi_buffer buffer =3D { ACPI_ALLOCATE_BUFFER, NULL };
> +       union acpi_object arg0 =3D { ACPI_TYPE_INTEGER };
> +       struct acpi_object_list args =3D { 1, &arg0 };
> +
> +       arg0.integer.value =3D 100;

Please move the definitions of the variables related to _BCT
evaluation to the code block where it gets evaluated.

>
>         lockdep_assert_held(&battery->property_lock);
>
> @@ -638,6 +644,15 @@ static int acpi_battery_get_state(struct acpi_batter=
y *battery)
>         battery->update_time =3D jiffies;
>         kfree(buffer.pointer);
>
> +       if (test_bit(ACPI_BATTERY_BCT_PRESENT, &battery->flags)) {
> +               status =3D acpi_evaluate_integer(battery->device->handle,=
 "_BCT",
> +                                              &args, &battery->charge_ti=
me);

Currently, you only need to evaluate _BCT to implement the quirk in
the second patch AFAICS, so it is not useful to evaluate _BCT if the
quirk is not going to be used.  Any chance to rearrange the code to
avoid evaluating _BCT when it is not needed?

> +       if (ACPI_FAILURE(status))
> +               acpi_handle_info(battery->device->handle,
> +                                "_BCT evaluation failed: %s",
> +                                acpi_format_exception(status));

Missing indentation.

> +       }
> +
>         /* For buggy DSDTs that report negative 16-bit values for either
>          * charging or discharging current and/or report 0 as 65536
>          * due to bad math.
> @@ -1083,6 +1098,8 @@ static int acpi_battery_update(struct acpi_battery =
*battery, bool resume)
>                         if (result)
>                                 return result;
>                         acpi_battery_init_alarm(battery);
> +                       if (acpi_has_method(battery->device->handle, "_BC=
T"))
> +                               set_bit(ACPI_BATTERY_BCT_PRESENT, &batter=
y->flags);
>                 }
>
>                 result =3D acpi_battery_get_state(battery);
> --
