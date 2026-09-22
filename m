Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC7E544D73
	for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 17:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790098602; cv=none; b=hnke7DpBFJyGtR1pagEw5w3Rlo9wt82iT/DDKLNG5ChOzBc9SAPgCrWhmEhQ8XZsZedSrc92Vu66HcrwI1rHMn96HuTsR9UwLCAIXIKGTANx78aZwc3GiHEKFSLAYiveBG1kFr2U2OoY9R4UH3zvAW9dx4NCoHlfu+htaGLeAro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790098602; c=relaxed/simple;
	bh=/iX1Ql4wg/WfBFscUMWwgxg/C8oEw7LG81FQ7imVB6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHtqWHpYk0/K2DSOfVjfrMd7WLZj2OlqPK/yMjsChp4Ke9ZhQJ1rtmU9rlqD+JYK9KWCeVjPjRyC3kwm8Tnwi08q27SLjeNXpKvYib+cuNmwnzaIYGJtbNkDoscWot4gibzPdvnz1q6xlyPuGH++nAfbdCfy5zgjbD65q7kPTI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYdwr1qW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYdwr1qW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A501F00899
	for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 17:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790098600;
	bh=UH+HPU6Wp2V3+TpJgaxkTLBVBWCLThA+hX9nQYsp+1o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PYdwr1qWnAUFLY460A7dMjMuiYqtug3oH623qeHg90zL3CNcx8UTJrp3HXb+S5q+F
	 kv9jHlPliAqGPft3Yd9Fqa1MC7FrIy8Pt0BjN3L7bE1IJbD/O8Ky2XFQT1DbuEaYLy
	 C7bjK1zEQ185cIsz/XO4723YJs3w6vSnpTuE/RsDpOo2A0IynyLs1kFY1BTrcdExwW
	 qH+LYLVev3H9pAew9A7m8AHhpCB+dMzaX0+Rm8mnkk9ntqnyWaVDKMsfju68GUpVQP
	 ESvrGPzpgXxgjfi7QcMKHrYcS11S40Sy7VA0+IssFqTvTC4ZJBaoy4WoUbQ25gRO2u
	 OCuenC925hR3A==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8b402f4e3so3562e87.2
        for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 10:36:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwFyvRJBZTo3WWoCxRuRivu2NcauWtsGaoDiJW/n4VjgvYcLroFq35fqCfpl3MWZr3etDuMMp+TU9Xc@vger.kernel.org
X-Gm-Message-State: AFuF++lR3IVMH6YX7Jcg9UnaX+KIUXOhUj6WnnFGAvIPRVD+sfR5RZku
	9QSjnI1f26yr+lODSIePZg5DEudyjKACce6iE0nVq48QYGEqIs3fTwiskRZ5l3egiGKP4/0RqBE
	tUbl7fkHchX3Ta9EZ14K2Cg6dqtQ78bY=
X-Received: by 2002:a05:6512:b22:b0:5b8:99b0:6565 with SMTP id
 2adb3069b0e04-5b8d895f50fmr3935e87.6.1790098598928; Tue, 22 Sep 2026 10:36:38
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8325277ff0484ab869fecf662a7ea356cd00bcde.1790090794.git.robin.murphy@arm.com>
In-Reply-To: <8325277ff0484ab869fecf662a7ea356cd00bcde.1790090794.git.robin.murphy@arm.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 22 Sep 2026 19:35:06 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g4k6FhyQMypkRyVJMkSBUsmeuetJuxRA826PcA7Mo5Hg@mail.gmail.com>
X-Gm-Features: AcwNN1WGPjd9cGyQNCQKyf989BMen53cRmRY9jgkEnugPAg2ejN5LaWKAsDvdYE
Message-ID: <CAJZ5v0g4k6FhyQMypkRyVJMkSBUsmeuetJuxRA826PcA7Mo5Hg@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: Provide !ACPI stub for acpi_device_uid()
To: Robin Murphy <robin.murphy@arm.com>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 5:26=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> While the likes of acpi_dev_uid_to_integer() and acpi_dev_uid_match()
> already have stubs for !ACPI, the basic acpi_device_uid() getter does
> not. Although calls in portable drivers should already be conditional
> on a valid acpi_device in a manner which would usually lead to compile-
> time elimination anyway, add a stub for the sake of completeness.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>
> ---
> v2: Distinct non-const definition to avoid further theoretical issues
> ---
>  include/acpi/acpi_bus.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 1a45e0d521d8..d686d09f1678 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -964,6 +964,11 @@ static inline const char *acpi_device_hid(struct acp=
i_device *device)
>         return "";
>  }
>
> +static inline char *acpi_device_uid(struct acpi_device *device)
> +{
> +       return NULL;
> +}
> +
>  static inline bool
>  acpi_get_physical_device_location(acpi_handle handle, struct acpi_pld_in=
fo **pld)
>  {
> --

Applied as 7.4 material, thanks!
