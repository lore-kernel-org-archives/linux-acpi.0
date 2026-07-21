Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D8525B090
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 12:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784636692; cv=none; b=s7pRjmL2rzJD0WNp8Sin9KjpbZk8E0Jw8sv/9CpT7zt1O7IvlSaaS2LjHnDrBQQ4O506S9rOhfngt5ZP3QMGWiL72w6q4Swe35Zdp8SA8SFsyHPAlIQh91IxtXmISmOw2vwwWVNRWCP4+qC7h4tEAu0WXI0JLW3+eNmFidn7Ltw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784636692; c=relaxed/simple;
	bh=xCj/uLjCyk5Vo1Yw/Oh8ZGfshGGCL1rxu6AN8vQSxHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J9wjp3pU5QER7SVG6xijQJgFjXheDkHmkLqnxvTCqTfJ0FScbCk/jWx4YxfkCnNYyJeyEQSnsaqioni1VQfzpxet7e1wr086ZK4nISy4vWeyg3DswHWG850bVsnj/Xb5FWV2tOAu4I98Hp9Kki5yRykQbOcI/hkKknRgohPnrmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n36ZgD/J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n36ZgD/J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8D71F00A3E
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 12:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784636691;
	bh=KawtIA94ik5HxyTa/hmILJYqp75zatY9AOc1LY8FQ7E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=n36ZgD/J/DJ6W4imrSHq7VXXnh2lZMIAQwqQXHWaaq4ycfq35V1kvNKmekLH1lH2M
	 6Kg54Ni1sO/GX4eqsHJtru0xmGfN++J/R8zMwwOo8lZq2uqMrvQ6Iuc9JCpVk87+Dw
	 UJmBgDGMPalQEgEKCFmZhXxxgrMIGp1Nc/K8WQThm2NZdAKvgLWw9/KzspIBOMrNyl
	 fGFm2qAQIDN7gFXBsBSDcncHP/zdrjZhXdnAo4Yglvln/dX4QpXPMSm5GsqngHfZ6W
	 f8+3MtqJVyWYM1psEJiUakQat7o5xQ7tv8H+BNy0ew0qEk5eMnzf35nbgA3udQrebB
	 uxtdfx0XelhxA==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-39c908d6cb6so100057291fa.1
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 05:24:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro6zsAM2oGhYnADkGtlFpnj1CGwzS6nhBiU853siq+v3UeCTcQSu2wrj4dXRUFiHMGwb6GThaMkfBq+@vger.kernel.org
X-Gm-Message-State: AOJu0YxEo7k/JZfazH3ie4PBFfYfK9ob94Bh1A+QLSUaHXmDPPsPlnMt
	T3QFxqk5bPhAchC39LI5/yWd5DJ2PjMqqy0Tk18x7Hbx8LCjTP3kIXPmbDevSZkQtKWhp9GXN+L
	Xsnz72plXPqdJwsXFQI+rl8T46a8wasA=
X-Received: by 2002:a2e:a99b:0:b0:39a:cfe7:d224 with SMTP id
 38308e7fff4ca-39eb287f10emr35824701fa.30.1784636689854; Tue, 21 Jul 2026
 05:24:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630-b4-acpi-v1-1-a9f59c04d221@kernel.org>
In-Reply-To: <20260630-b4-acpi-v1-1-a9f59c04d221@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 21 Jul 2026 14:24:30 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jaRjxMBxpjAxZiKUXqdZ9W-d7yNC=4ifwA87YUOrdxWA@mail.gmail.com>
X-Gm-Features: AUfX_mxAK7A3TH3wQk93Zll9tA8OYKnbfa0WfFqey7JRWYnrWOXL32o-SJAaR6k
Message-ID: <CAJZ5v0jaRjxMBxpjAxZiKUXqdZ9W-d7yNC=4ifwA87YUOrdxWA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: NVS: replace __get_free_page() with kmalloc()
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 12:56=E2=80=AFPM Mike Rapoport (Microsoft)
<rppt@kernel.org> wrote:
>
> suspend_nvs_alloc() allocates shadow pages for saving and restoring
> ACPI Non-Volatile Storage regions across suspend/resume.
>
> These buffers can be allocated with kmalloc() as there's nothing special
> about them to go directly to the page allocator.
>
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
>
> Performance difference between kmalloc() and __get_free_pages() is not
> measurable as both allocators take an object/page from a per-CPU list for
> fast path allocations.
>
> For the slow path the performance is anyway determined by the amount of
> reclaim involved rather than by what allocator is used.
>
> Replace use of __get_free_page() with kmalloc() and free_page() with
> kfree().
>
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@re=
dhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
> This is a (tiny) part of larger work of replacing page allocator calls
> with kmalloc:
>
> My initial intention a few month ago was to remove ugly casts [1], but th=
en
> willy pointed out that Linus objected to something like this [2] and it
> looks like more than a decade old technical debt.
>
> [1] https://lore.kernel.org/all/20251018093002.3660549-1-rppt@kernel.org/
> [2] https://lore.kernel.org/all/CA+55aFwp4iy4rtX2gE2WjBGFL=3DNxMVnoFeHqYa=
2j1dYOMMGqxg@mail.gmail.com/
>
> Also in git:
> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git gfp-to-kma=
lloc/acpi
> ---
>  drivers/acpi/nvs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/nvs.c b/drivers/acpi/nvs.c
> index 6eaad7dd0241..12aee4102696 100644
> --- a/drivers/acpi/nvs.c
> +++ b/drivers/acpi/nvs.c
> @@ -133,7 +133,7 @@ void suspend_nvs_free(void)
>
>         list_for_each_entry(entry, &nvs_list, node)
>                 if (entry->data) {
> -                       free_page((unsigned long)entry->data);
> +                       kfree(entry->data);
>                         entry->data =3D NULL;
>                         if (entry->kaddr) {
>                                 if (entry->unmap) {
> @@ -156,7 +156,7 @@ int suspend_nvs_alloc(void)
>         struct nvs_page *entry;
>
>         list_for_each_entry(entry, &nvs_list, node) {
> -               entry->data =3D (void *)__get_free_page(GFP_KERNEL);
> +               entry->data =3D kmalloc(PAGE_SIZE, GFP_KERNEL);
>                 if (!entry->data) {
>                         suspend_nvs_free();
>                         return -ENOMEM;
>
> ---

Applied as 7.3 material, thanks!
