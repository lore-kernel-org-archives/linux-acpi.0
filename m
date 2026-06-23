Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4D631E84E
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782226243; cv=none; b=DiKWGWQLz/IGGFvM3Z8jrxbKutnWQLja06vZvOy7PEMuaMGAHQ+5i9Lh9R2ECl5mF+BkTXricgvVvEI3wyANnzFVqmifNT08eC8OL/82Pvng+HU9xzlE+gxxXq0fiZjMkeTOOqel/+KDuxyojjyPiUMRLmxC6rvjdfyfw6qnHe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782226243; c=relaxed/simple;
	bh=MPNil927Q/39e3udAbN8OPHMkZ/2YKLREetO48wetdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e3FzC2zyUj1R0i3GI2I3Zn3+0rgSEVCUmHihrsDRK6OoE6zKg6+/hu6hWRVBnqutzBJb/56QTN6ItFTuWEI3Pl98cUQG1M2GEDH6r1WeqaNrOd/c8MZFkoFoAWRIRleebiSbq1hrxcOV4gF9RmWaxVgiGtOaMgKSkMPvkkTDIeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEQ7k8zC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEQ7k8zC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3A9C1F00A3D
	for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 14:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782226240;
	bh=fyz5yi/E4FPQf+IeYCnx3xvFLVfhG4OAA0PNbrnWz7c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UEQ7k8zCpTTTBXHYx30zeWiBb/qjx8S6w389uwdjS+Wzi2l2EG+1izZW3KxABPRo+
	 wdrZ8jySkhspTweJH6j5XKOA38LZP4avrOiQCSPPRqbbEtVejOAeBTRf3pr3iVAu0R
	 g2h5k8BKmfKjcAO58mUhm+sk3KoW1UFYlLTtxJnBWinwsy7tXTiKr7sG/s+62fKZTv
	 Dkmjry72ZA042XamEUJEctyHO68P7q2DiKdwkJiX+kPjOSe2tQCAIEkdokmArkg+y4
	 xieOteDY9V/75VxZ2qQxRNVMvZRbbguMcq8FWZKUuL9jITIEfVhzan5AvHNXogmKjQ
	 Fk5iO0PLREnnA==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-39677c80386so63037411fa.3
        for <linux-acpi@vger.kernel.org>; Tue, 23 Jun 2026 07:50:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ898uOVzDs7+PmKAhkV3XHqORi20mjW8rQAH5gWZoNyHi1mrobnNL/tcIlPFFtVWeKhUtxWdTNyVtXF@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Xgp8IZTx0vp47UxhJNb2EeNCvEX/c3uFAvaryTYn60F7k8Jb
	RGaqsdSDPx2RwFhhnPJ70bqsHWmsuXf/YsyphdF8r++/crKybHaTxLEX1VuHHJgEZerlStchomY
	tprgUJHtf/vZvuUUfiwBDHgm05iI4gF8=
X-Received: by 2002:a2e:be94:0:b0:38d:e220:8dc2 with SMTP id
 38308e7fff4ca-39a27e9f49cmr7847651fa.20.1782226239441; Tue, 23 Jun 2026
 07:50:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617135518.1100698-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20260617135518.1100698-1-ben.dooks@codethink.co.uk>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 23 Jun 2026 16:50:27 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0ji5ps3+-+MJtN-g_k_B3UEQDry9XF6ZUEVD8nyrc-fpw@mail.gmail.com>
X-Gm-Features: AVVi8CeF-2P4LlU12ZBSltHLzvfdUY9cYFgp_kYlBmyOFpkfsAiO0v87vKrNNLA
Message-ID: <CAJZ5v0ji5ps3+-+MJtN-g_k_B3UEQDry9XF6ZUEVD8nyrc-fpw@mail.gmail.com>
Subject: Re: [PATCH] PNP: make pnp_eisa_id_to_string() take __be32 id
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 3:55=E2=80=AFPM Ben Dooks <ben.dooks@codethink.co.u=
k> wrote:
>
> The pnp_eisa_id_to_string() should take a __be32 id as it
> passes it immediately to be32_to_cpu(). Change the type
> of this to fix the following sparse warning:
>
> drivers/pnp/support.c:42:14: warning: cast to restricted __be32
>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> ---
>  drivers/pnp/base.h    | 2 +-
>  drivers/pnp/support.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pnp/base.h b/drivers/pnp/base.h
> index b342570d0236..7b666b6ac40e 100644
> --- a/drivers/pnp/base.h
> +++ b/drivers/pnp/base.h
> @@ -11,7 +11,7 @@ extern const struct bus_type pnp_bus_type;
>  int pnp_register_protocol(struct pnp_protocol *protocol);
>
>  #define PNP_EISA_ID_MASK 0x7fffffff
> -void pnp_eisa_id_to_string(u32 id, char *str);
> +void pnp_eisa_id_to_string(__be32 id, char *str);
>  struct pnp_dev *pnp_alloc_dev(struct pnp_protocol *, int id,
>                               const char *pnpid);
>  struct pnp_card *pnp_alloc_card(struct pnp_protocol *, int id, char *pnp=
id);
> diff --git a/drivers/pnp/support.c b/drivers/pnp/support.c
> index f6c866851769..07c9844680ac 100644
> --- a/drivers/pnp/support.c
> +++ b/drivers/pnp/support.c
> @@ -37,9 +37,9 @@ EXPORT_SYMBOL(pnp_is_active);
>   * Functionally similar to acpi_ex_eisa_id_to_string(), but that's
>   * buried in the ACPI CA, and we can't depend on it being present.
>   */
> -void pnp_eisa_id_to_string(u32 id, char *str)
> +void pnp_eisa_id_to_string(__be32 _id, char *str)
>  {
> -       id =3D be32_to_cpu(id);
> +       u32 id =3D be32_to_cpu(_id);
>
>         /*
>          * According to the specs, the first three characters are five-bi=
t
> --

Applied as 7.2-rc material, thanks!
