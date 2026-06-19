Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60A22C15BE
	for <linux-acpi@vger.kernel.org>; Fri, 19 Jun 2026 18:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781893398; cv=none; b=cAHL09o6Pkj8EgaigEwzEuVUTfw2Lwy37cS19fmtNtIZXWnJaxX5lKysByqFCi6svLsf324VSNIq9r0RtR4Lt4y00d9UMYrOrnybH9QhoWmqQeqB2V5rM87Wo7v0V5uLkWpdaM+WzGCrPhDnqjvRJhBMC1qR6+syhGXCLUIUr88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781893398; c=relaxed/simple;
	bh=ldhuD1LStPTm96nrgZudUL/Q0HT0KpdgIDlEUGRp8qc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nkNNSwnU5UtFLHNNR3eB6NegfmFnB51tmkOy7lQTJYUWSwczjRA1C3bCWTirBvTv0C8OnALYrOxaYvIMWS/PMwTwJySVOvdiyWY+YrYZ1Sfc9AG0K8HBrdFHBM6aYWXnUgwMaYU0vNDied28G804oRcc6WACpjxj18wv2qURzBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nw5hkh7/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nw5hkh7/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60DAD1F00A3A
	for <linux-acpi@vger.kernel.org>; Fri, 19 Jun 2026 18:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781893397;
	bh=P4wCKhd1ybUPnLdDKeMkDo34FIUsXf4ZWzzGHTxFllc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nw5hkh7/hHtjK4v7j4IGav0YSb2vWWZ9R0iDm3xWlaBuCDoaEbyKku7CYfnbCNh6P
	 UiWaBjyteVdzjTE64WOgvGslkKmcyBeYCSbknilNhIX/AMAGvXsaiRm/7bKPTOFK+h
	 3R0Y/AqS/V1ZjBbqRwyrkoDpHjug64s91kZG04+Zg0MiKJw95VkjhlP0dWQT6xSVj9
	 JFyq9uF+Q3hv1orelXwTrE2071jZXaFZYEImnIt1m4eMglOTi44vj9sSb3UbgyxzOK
	 mJZWzeUumAcmTdFbk7JddVj5HHAVSC9zIxpyJ6HRCRLVB1HzUsJfgYdNcsl2npUFFP
	 DCUEq/YN1o/0A==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5ad578c49afso1061062e87.3
        for <linux-acpi@vger.kernel.org>; Fri, 19 Jun 2026 11:23:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9Zi7kAZ1oWMMEU2+xKE9tKt9TyEqsbeR/dDB9A3cissIr9e0OoAqJJs95YkKJ2GrOqlPyd+gkPguhh@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3CDXLmk+VrsndPDiFXyo9L7TLqmysEFpyiy5zObcc8987D5LR
	w/C5GcJQ84qANy7BsiDiQcp2tMM74uDOkW9m3qmQVGBAlDYQcvy4ymdTA4Acju8Q0qirakL+wDi
	3Tu3x6qID4UwgnPmFiA+zc3lBS9MUt0k=
X-Received: by 2002:a05:6512:24d4:b0:5aa:8824:156a with SMTP id
 2adb3069b0e04-5ad562cefc4mr1120477e87.46.1781893395866; Fri, 19 Jun 2026
 11:23:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617090555.2648709-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20260617090555.2648709-1-andriy.shevchenko@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 19 Jun 2026 20:23:02 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0haSE7HarM+1c3PDKqBvEVcjw97umkRcZqzqNtqOzU_zg@mail.gmail.com>
X-Gm-Features: AVVi8CeMVYH3lji2juD_1-mDEcQLMCXGYQl_ShLHSQA0ccVOLcrH5fb-Q3rxUtQ
Message-ID: <CAJZ5v0haSE7HarM+1c3PDKqBvEVcjw97umkRcZqzqNtqOzU_zg@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] ACPI: resource: Amend kernel-doc style
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 11:06=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The functions are referred as func() in the kernel-doc. The % (percent)
> character makes the rendering for constants as described in the respectiv=
e
> documentation. Amend all these.
>
> Fixes: 8e345c991c8c ("ACPI: Centralized processing of ACPI device resourc=
es")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/acpi/resource.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index bc8050d8a6f5..56df4599d360 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -871,7 +871,7 @@ bool acpi_dev_resource_interrupt(struct acpi_resource=
 *ares, int index,
>  EXPORT_SYMBOL_GPL(acpi_dev_resource_interrupt);
>
>  /**
> - * acpi_dev_free_resource_list - Free resource from %acpi_dev_get_resour=
ces().
> + * acpi_dev_free_resource_list - Free resource from acpi_dev_get_resourc=
es().
>   * @list: The head of the resource list to free.
>   */
>  void acpi_dev_free_resource_list(struct list_head *list)
> @@ -991,7 +991,7 @@ static int __acpi_dev_get_resources(struct acpi_devic=
e *adev,
>   *
>   * The resultant struct resource objects are put on the list pointed to =
by
>   * @list, that must be empty initially, as members of struct resource_en=
try
> - * objects.  Callers of this routine should use %acpi_dev_free_resource_=
list() to
> + * objects.  Callers of this routine should use acpi_dev_free_resource_l=
ist() to
>   * free that list.
>   *
>   * The number of resources in the output list is returned on success, an=
 error
> @@ -1032,7 +1032,7 @@ static int is_memory(struct acpi_resource *ares, vo=
id *not_used)
>   * The resultant struct resource objects are put on the list pointed to
>   * by @list, that must be empty initially, as members of struct
>   * resource_entry objects.  Callers of this routine should use
> - * %acpi_dev_free_resource_list() to free that list.
> + * acpi_dev_free_resource_list() to free that list.
>   *
>   * The number of resources in the output list is returned on success,
>   * an error code reflecting the error condition is returned otherwise.
> --

Applied as 7.2-rc material, thanks!
