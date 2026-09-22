Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A404754A7D2
	for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 13:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083387; cv=none; b=r9KtiZDKH3j6pNU+7iIBnE1YEdjAcqpUH3b8abdn1ebF6s44kdtHRUIjnlT5VXIj30Rmi/zLq/+hty/X1RJU6pKQP11F4O29Zg3yn8EDZKF1sQ9233t9hD223WIcCnEePtm9Pp2UFOA18j/gTev0vsXZl4l5CVqwrx+k8WrHAMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083387; c=relaxed/simple;
	bh=tpw+NrM0fEohLTuiSsco0trLc3BGf8k7iKY+rzZxaxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XtIf5j64dfKffVWigcKg5/HZLirBGOBhu3vVNxQ3/TgHifYwSxO3llot+GysuThCyM805ds3893AXtAqo54ijAe8+B6dsS08wm1YF4/dKSh32q29SLEZvbxHbtah4GUGItAy1q2FB1gPH1zmrEmtlUdjfhPDXYQ/W8kCeAU1n/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KCi8HP2N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KCi8HP2N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49AD31F000FF
	for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 13:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790083386;
	bh=x4qxzTy+TFYs6c6JnzPj3Xj1l2nqASMADmT19w+UmXM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KCi8HP2Nrpys/TcORwa1U/HzUeLQiiP1sAg1zSpcQjcJhI5JqvhML/SFHrYnwihpB
	 ND91zkxgmwXEmoYBoSFSxPv+wO0NKOJOIpySxJqQVM270RPxs9bROl69RxO/dIqqTX
	 Mid1CX6jJrm0Oo++cjTpZ2EyeT0ym5Wf+FITvteOWWZIn/gh5+upAMs9Fqgg9XWU0K
	 l9jK0k8ZYcnIO5Kn2BAmVLjF+ddBF3dzjRSsOcnzp8JnOwV0tR0FXtinhh5h/j3urS
	 WhF0gLP1lrdnsGOtIFyRDXxifaSeSR+jb36YRXQH7NSYxc1cdZ2GduLSh5q6Zm9BC2
	 +1EGUz2HRyOcw==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-3a20f06cce6so9058311fa.1
        for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 06:23:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz/0RfDcaZG61gV7L9ffjaZpoosdvDXUHkTEMc37UzOBVacfBelEzu8PoExa2z5vCSgKS/KgpK1R6Jo@vger.kernel.org
X-Gm-Message-State: AFuF++l8xu3xLojk78SEEB5jN0KnhxJqjbRziIQ2Hzu7hhSp2H5A+oBQ
	gwh9hI9vd+pMG+funpg+RzBq0Ihqd79zhIGzcRQU0qJft3i8vInE5GLSHCKID3bstXui+SgKmTD
	9nEpbusFHTa3KwzEDQ3Of+hNis6VJENQ=
X-Received: by 2002:a05:651c:a332:b0:3a3:61ec:43c2 with SMTP id
 38308e7fff4ca-3a624db5e2fmr8426901fa.19.1790083384666; Tue, 22 Sep 2026
 06:23:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919123131.11443-1-johannes.goede@oss.qualcomm.com>
In-Reply-To: <20260919123131.11443-1-johannes.goede@oss.qualcomm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 22 Sep 2026 15:21:33 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i2Mk4nPQ5GvyzUpa0MQRXtxPbHggce7hFOPTwRDKeqAQ@mail.gmail.com>
X-Gm-Features: AcwNN1XgrbKgulnQGt-o-oPbn6Eipkh7SAM4TYxDlecoUWiyFZZw-Vsr-_TUoQo
Message-ID: <CAJZ5v0i2Mk4nPQ5GvyzUpa0MQRXtxPbHggce7hFOPTwRDKeqAQ@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_ACPI=3A_thermal=3A_Fix_acpi=5Fthermal=5Fguess=5Fof?=
	=?UTF-8?Q?fset=28=29_for_device_with_a_273=2E0=C2=B0K_offset?=
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 19, 2026 at 2:31=E2=80=AFPM Hans de Goede
<johannes.goede@oss.qualcomm.com> wrote:
>
> Some devices round the 273.15=C2=B0 offset between Kelvin and Celsius to
> 273.0 instead of 273.1 or 273.2.
>
> Make acpi_thermal_guess_offset() check for this value too, fixing e.g.
> all zones reporting x.8=C2=B0C to them reporting y.0=C2=B0C instead.
>
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>
> ---
>  drivers/acpi/thermal.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> index dd7666c176a0..3fdc832c11a3 100644
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -738,7 +738,9 @@ static void acpi_thermal_aml_dependency_fix(struct ac=
pi_thermal *tz)
>   */
>  static void acpi_thermal_guess_offset(struct acpi_thermal *tz, long crit=
_temp)
>  {
> -       if (crit_temp !=3D THERMAL_TEMP_INVALID && crit_temp % 5 =3D=3D 1=
)
> +       if (crit_temp !=3D THERMAL_TEMP_INVALID && crit_temp % 5 =3D=3D 0=
)
> +               tz->kelvin_offset =3D 273000;
> +       else if (crit_temp !=3D THERMAL_TEMP_INVALID && crit_temp % 5 =3D=
=3D 1)
>                 tz->kelvin_offset =3D 273100;
>         else
>                 tz->kelvin_offset =3D 273200;
> --

Applied as 7.4 material, thanks!
