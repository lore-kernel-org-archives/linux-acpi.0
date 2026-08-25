Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058B83DDB13
	for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 11:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787658726; cv=none; b=iMdPHq8emQWfKLlMwpklGtRqO99fxaPZ6ai0FYITh7gDKfEyVQUP/+z3gS3VppDOt048VFuT/HJacR90OHbOMImwHf0PCMPIWEGFjKkGPqBl0xcEOJ5T13BiFSDteDJeYU9BQhDLTCbGJ9YFSKgXeq5i9yIPtYLEU0o0drWWyw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787658726; c=relaxed/simple;
	bh=u6ZaqZIVVxWITzZ6dNJnGJDf5hZ9ZdjFyNa1HMurX3g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zp7DKfHnVa+chGnBKxtg0spjq2cWLEuf4uVL9AWYkEQydO0sJ8XBi3YmkFQm0UZeOdLCx5Ktv54ve4s6EM0eXlGpbDp80tAKLlhxvExGzt5MLr9n4FOSh+ybfk7pKRx3mlo5cPtXF/7e6OEEdfJ6aTrGgoiV8GMmysgjSwz43h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOTW1zea; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOTW1zea"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45AF1F00A3E
	for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 11:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787658724;
	bh=MdTFYMfZNi9DitIjw0OlwVsDaq5C/HggGQP9M9G/fA8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JOTW1zeagCzR4rAm9C1ksvZ5lLiVLrHG9PhJCwTE2hv8oAPtZTfGeoij/A1DcR3ho
	 kkSwGe42KPJpjzatSocz6OzfZ2jJ2XkTdhd5ftzIc6TyjprmcqBj2p8Lc6cY2MPgCa
	 WJfzR4d626OKCAdp1d6Vkzpv/2n9S6aRaNz1kqPxMJbmrEIe8HClQS3eU2q0x/LUW4
	 nzl3d4rmnZxRnVK966J+FnOEpiy9NxgEr44aAusVX/WlISU+ah3+J+TrN9602Ahbvc
	 q5X9lcWs/NlJB2FkEARTUNrCxpWfU4msQqo0ZHe1FExiCHXd6GnRWT1XwjF0pn9fu2
	 A86zUGP95PfCw==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-39dbe684115so6001891fa.1
        for <linux-acpi@vger.kernel.org>; Tue, 25 Aug 2026 04:52:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrsT4rEJo0uPHApjTEcRiNi0dMyaUm0Z1VZF4vPEfv1OO+XXM101pcZkVjeokFQjjXWPDfL9thbQnNb@vger.kernel.org
X-Gm-Message-State: AFuF++lj1fW0GdLTT8NuPc6b3VuxInz/AURofrMqtdr5xfFgdeqmWlfO
	AkykifbJKa1CFoax4XOhYPzD5oy0NZbZxxfH3D2dj9ITCEdHAh/0LH9JcXnT1PolElYd6txo/BI
	BvHjnxmV4wqnwoGSnJKvfevVwfoDObuQ=
X-Received: by 2002:a05:651c:1446:b0:3a1:6a25:1780 with SMTP id
 38308e7fff4ca-3a1edb6f906mr11595111fa.9.1787658723062; Tue, 25 Aug 2026
 04:52:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260824211338.3583976-1-sakari.ailus@linux.intel.com> <20260824211338.3583976-4-sakari.ailus@linux.intel.com>
In-Reply-To: <20260824211338.3583976-4-sakari.ailus@linux.intel.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 25 Aug 2026 13:51:18 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ieb2FcANOt0MRMsTrwtbLiUF48W_c=3z3OpNH92d=7vg@mail.gmail.com>
X-Gm-Features: AcwNN1XjcteE35qEbjNvlHLscZXu_ibG4GTIbtB83ieE1mQzAKulTON4rfpobPE
Message-ID: <CAJZ5v0ieb2FcANOt0MRMsTrwtbLiUF48W_c=3z3OpNH92d=7vg@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] ACPI: Support __free() from cleanup.h for ACPI objects
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, 
	Daniel Scally <dan.scally@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 11:13=E2=80=AFPM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Use DEFINE_FREE() to allow ACPI objects to be released automatically.

But at least some of them are allocated by ACPICA functions like
acpi_evaluate_object() and so they have no proper constructors.

> Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> ---
>  include/linux/acpi.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 10d6c6c11bdf..c89390ac6287 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -62,6 +62,8 @@ static inline acpi_handle acpi_device_handle(struct acp=
i_device *adev)
>  #define ACPI_HANDLE_FWNODE(fwnode)     \
>                                 acpi_device_handle(to_acpi_device_node(fw=
node))
>
> +DEFINE_FREE(ACPI_FREE, void *, ACPI_FREE(_T))
> +
>  static inline struct fwnode_handle *acpi_alloc_fwnode_static(void)
>  {
>         struct fwnode_handle *fwnode;
> --
