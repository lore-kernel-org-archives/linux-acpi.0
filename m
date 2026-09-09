Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E0F241CB7
	for <linux-acpi@vger.kernel.org>; Wed,  9 Sep 2026 15:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788967089; cv=none; b=ZBhluYjtxEEO/XzMa/vQ1A5BhE481h6WIMbeIJJHK5IWlHMBXV+NILZpST7DgfCguEAlaHXCwp1ularyURPH57hSNlJip1wq/H07bBJ3SGpV3cGfkK6q3kXIGxM9gDt0/gb1W6s1pArgqnFvWjlBTiPViAodixTFlutdtbTZq/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788967089; c=relaxed/simple;
	bh=e4avd8W6h3CHEFt8wxakMpkcDez90eq+QXXtVfI1/Vc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tXMh/yo/SXvvWITJBGG0LHH4AYMRnx0Leff6pYe7jUiTXg5BVWF7OMyNwKdqc2W0CCKDzWtW1l/YW7EMKI12c4n8D2LHU62n1VK7vWxJl7AvV5jlI2bIFvRcBlFQ+KNsRJsu3lwxurwZoTBzusdyuHYYQDst3ivcq0M6TzfcP7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enoYgBZs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enoYgBZs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D72F1F00A3D
	for <linux-acpi@vger.kernel.org>; Wed,  9 Sep 2026 15:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788967088;
	bh=RACoOXuh30Y5sKO6ycgHm1b/3nOIIcawlJfb57IABzE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=enoYgBZseRapVpuCLXSWuGnaZcpDc19fOaDYzYI7pnpqh0ekqNwIE0rrMzKjANLgY
	 nqDCXAN78ToF0chnhkOYSkDZF17u2r3UPr3ztSuUNm0WGBRim7XZMi9urv3WX+wsRN
	 o0aW0w0siwViZrY81q21wHu2R2lNT+aL+ehdUpNtyj3+ifYa2KFj6rX3PvjLJKe1ZO
	 aB/cs6wR21+COfjriON+Tn+oKG74gmdTsp5SAZrOEG1RmTUceGPv1t+oB0FmVMSI6+
	 xF+UNZY8NFfiFnBKOnI1Duiot00Jb4tTIRqOrw5t1bkHzwMEgIFnMVzWk6eOETfycp
	 4f4UghLrvDzkg==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a302c23fb2so3033101fa.2
        for <linux-acpi@vger.kernel.org>; Wed, 09 Sep 2026 08:18:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxamEW2Rbs+JeDlt1KI+8zi/vxBwYiYQZGKY1/RyTVEvVkKhS/+ltFkg0pa3WAjyhLAsXpe8ujKr9Jw@vger.kernel.org
X-Gm-Message-State: AFuF++kex+uIdPs3McqIqIzeCw5CSCwHlqLySdbWVct9qz0shKSlQm0u
	TMzuuZxfzIPCiz4xWdF6FBELE2aGfvPeykbRscVPNyFP+FKIlv5W5AR1REP8GfmM8Zv3HhKizz6
	haOJ3NbP0KsuJWuMel91EULIJIHuqhns=
X-Received: by 2002:a2e:bc87:0:b0:396:7547:439e with SMTP id
 38308e7fff4ca-3a58d44d9e9mr1994491fa.7.1788967085423; Wed, 09 Sep 2026
 08:18:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908014645.4165221-1-lijun01@kylinos.cn>
In-Reply-To: <20260908014645.4165221-1-lijun01@kylinos.cn>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 9 Sep 2026 17:16:54 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jQ+dBQX0WhKJgR6QqnAufVFAbH-bFK_Vg8+9Y05aoveA@mail.gmail.com>
X-Gm-Features: AcwNN1VVHAUwPE8NE8jH2SAJsa4c8isb2k7OrWo9E--2ID_-pp-DH__RRWhEk08
Message-ID: <CAJZ5v0jQ+dBQX0WhKJgR6QqnAufVFAbH-bFK_Vg8+9Y05aoveA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: button: replace SIMPLE_DEV_PM_OPS with DEFINE_SIMPLE_DEV_PM_OPS
To: Li Jun <lijun01@kylinos.cn>
Cc: rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 8, 2026 at 3:47=E2=80=AFAM Li Jun <lijun01@kylinos.cn> wrote:
>
> Replace `#ifdef CONFIG_PM_SLEEP` boilerplate with the modern
> `DEFINE_SIMPLE_DEV_PM_OPS()` macro in the acpi_button driver.

This is not a replacement, it just makes the code previously under the
#ifdef to be compiled and never used.

> Signed-off-by: Li Jun <lijun01@kylinos.cn>
> ---
>  drivers/acpi/button.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index cdbb1023a8ee..15fc5d2ae467 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -161,14 +161,10 @@ static const struct dmi_system_id dmi_lid_quirks[] =
=3D {
>  static int acpi_button_probe(struct platform_device *pdev);
>  static void acpi_button_remove(struct platform_device *pdev);
>
> -#ifdef CONFIG_PM_SLEEP
>  static int acpi_button_suspend(struct device *dev);
>  static int acpi_button_resume(struct device *dev);
> -#else
> -#define acpi_button_suspend NULL
> -#define acpi_button_resume NULL
> -#endif
> -static SIMPLE_DEV_PM_OPS(acpi_button_pm, acpi_button_suspend, acpi_butto=
n_resume);
> +
> +static DEFINE_SIMPLE_DEV_PM_OPS(acpi_button_pm, acpi_button_suspend, acp=
i_button_resume);

Does this compile with CONFIG_PM_SLEEP unset?

Regardless, I don't see much point in making these changes TBH.

>  static struct platform_driver acpi_button_driver =3D {
>         .probe =3D acpi_button_probe,
> --
