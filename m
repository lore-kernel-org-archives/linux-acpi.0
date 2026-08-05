Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC45F3B4E88
	for <linux-acpi@vger.kernel.org>; Wed,  5 Aug 2026 16:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948389; cv=none; b=pnicS8jPHr9ZSb4F9n8AhSbOrQ2V/QKG9ELHP4U5WjJEWVmnZBpdc5ZuAw77GpeHdLyMYsdFU3MtWnlcpEqTL9juAuiN0dOST+wlskpUSCtMz+TsxtYTRe3I+JcAV0YW14foQBddw6mQ0Psgl/wXTOxbhO2rbAhZ6UrUBUGCzLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948389; c=relaxed/simple;
	bh=icSBlX5Bn6PnoDrrPwFCn+zO/g7q3+sDiGHwIKmhxmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HG2jlqBlSMO6NuzPEFlIq81zP7ztL34eCY4f//wj/H0vMecaCIikCgJrDhxfNWEPTZ7GyT/fPLou6HOT8o+jd+GDYxr1EPVufuzc1lgOaPck7a9/0TlFcmgW5uyKJz5xnIofWxxG1t3U6pY1Q1Qn9ev+ugMuCzdSg5dVcFPi7+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUUUovKw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUUUovKw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935DC1F00A3D
	for <linux-acpi@vger.kernel.org>; Wed,  5 Aug 2026 16:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785948388;
	bh=+Ye8b+wsZIA2qG9lNMZfJMyCZTt+P4r6Wvz905OiOMI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=eUUUovKwv9uxwqttLQAVJjeTRkikfHTamyYCz8NXkLN4cJ+zm33qmIuGvpyrbKOFl
	 LnNtxGwRwTeOKg4alfsVK/MLJynEixLaPZAy9TzP8SI2xdSzuWu7efYXSx5M4oI63m
	 Kpm6srWOBdc4mnqnaI++JkbDbwbWWI8JKwFzb9ai6FXCBbU6HHIhKFqhbDYgFe1kG/
	 f+yQuUUNjdJdFuGeAMbkTwQ+kjow8FPAoTOgO+77iFyOmITTepxQ2SPe8KUmiiOcSi
	 n5gqx6lqmMRPHVixzArW23xmmOUZibHOE/GSUmzGsLLTpLiX0K6YxlcNwM4d+t6KAH
	 5ZyR4YKtIocaw==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b015b2d792so1130739e87.3
        for <linux-acpi@vger.kernel.org>; Wed, 05 Aug 2026 09:46:28 -0700 (PDT)
X-Gm-Message-State: AOJu0YyE/UDYAk8ynT3Bbzpze12AeamIl6l4IBUQGYIM3447FA7RHtUo
	MniYbByGSbDKoxYUZfdvLZULLR/+GWAaXlVhQztNxLrIAqiJTj7cBPLRkDJhHYqF7mN+v7rwTcz
	1etAd1dhBkTaGlQhnH2AVkvRoanqArbc=
X-Received: by 2002:a05:6512:b91:b0:5b2:e947:b3f9 with SMTP id
 2adb3069b0e04-5b2f4cc9324mr1083863e87.26.1785948387055; Wed, 05 Aug 2026
 09:46:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722131553.2117835-1-sudeep.holla@kernel.org> <20260722131553.2117835-2-sudeep.holla@kernel.org>
In-Reply-To: <20260722131553.2117835-2-sudeep.holla@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 5 Aug 2026 18:46:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hdxtuEbFQdwRe=T+Q2xRki+uN9PP7PPw7AdW4Obe3fqA@mail.gmail.com>
X-Gm-Features: AUfX_mzDCkRCv6uCTLFlvOrFSsuEeF3hnYAkpAif_GgMK46WdV30q3YbLj2U8Is
Message-ID: <CAJZ5v0hdxtuEbFQdwRe=T+Q2xRki+uN9PP7PPw7AdW4Obe3fqA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ACPICA: Fix PCC OperationRegion command offsets
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	acpica-devel@lists.linux.dev, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Saket Dumbre <saket.dumbre@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 3:16=E2=80=AFPM Sudeep Holla <sudeep.holla@kernel.o=
rg> wrote:
>
> ACPI 6.3, section 5.5.2.4.7.3, states that the PCC Operation
> Region is associated with the region of shared memory that follows the
> PCC signature.
>
> The generic and extended PCC shared memory layouts include the 4-byte
> signature at offset 0, so their raw shared memory COMMAND fields are at
> offsets 4 and 12 respectively. Since AML field offsets for the PCC
> OperationRegion are relative to the region after that signature, ACPICA
> must look for those COMMAND fields at OperationRegion offsets 0 and 8.
>
> Adjust the generic and master subspace command checks to use those
> OperationRegion-relative offsets. Otherwise writes to the COMMAND field
> can fail to invoke the PCC address space handler at the offset described
> by the PCC OperationRegion definition.
>
> Fixes: aa6ec56b574d ("ACPICA: ACPI 6.3: add PCC operation region support =
for AML interpreter")
> Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> ---
>  drivers/acpi/acpica/exfield.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfield.=
c
> index 9a55524ed8f4..a7fac63938b3 100644
> --- a/drivers/acpi/acpica/exfield.c
> +++ b/drivers/acpi/acpica/exfield.c
> @@ -45,12 +45,13 @@ static const u8 acpi_protocol_lengths[] =3D {
>
>  /*
>   * The following macros determine a given offset is a COMD field.
> - * According to the specification, generic subspaces (types 0-2) contain=
s a
> - * 2-byte COMD field at offset 4 and master subspaces (type 3) contains =
a 4-byte
> - * COMD field starting at offset 12.
> + * According to the specification, the PCC OperationRegion begins after
> + * the PCC signature. The raw shared memory COMD offsets of 4 for generi=
c
> + * subspaces (types 0-2) and 12 for master subspaces (type 3) therefore
> + * appear at OperationRegion offsets 0 and 8.
>   */
> -#define GENERIC_SUBSPACE_COMMAND(a)     (4 =3D=3D a || a =3D=3D 5)
> -#define MASTER_SUBSPACE_COMMAND(a)      (12 <=3D a && a <=3D 15)
> +#define GENERIC_SUBSPACE_COMMAND(a)     ((a) < 2)
> +#define MASTER_SUBSPACE_COMMAND(a)      (((a) - 8) < 4)
>
>  /***********************************************************************=
********
>   *
> --

Can you please see the corresponding upstream ACPICA pull request?
There are concerns regarding it.

Thanks!
