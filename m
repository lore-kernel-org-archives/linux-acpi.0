Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D13B0285C8B
	for <linux-acpi@vger.kernel.org>; Wed, 24 Jun 2026 13:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782306674; cv=none; b=ADHYHk+XKiuXmHkM1qSYxK1Tu/fcSk02V7qrvmT3JjFNJMDFR/VMa4A4Te32lGk8eBZYIgs66OjX4X5NYz+y0mg6xf+14WlpFX15fKV53u6Zlns+Fq9HT4jDrkdG1jJ6GjjXS9Z4/k3iimWt2wawXZOicMj/HvXQUtw7XbZ/aCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782306674; c=relaxed/simple;
	bh=C0J0XusKZIElcWXark7K9bjk8b6SMi2f9px70iFNhAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/QJwD3wzb6NNAzwRUi0giQpWLQ3c1JO2GO+76gFxQRaEDkCCqsH6y+2Gdawdmgg/bwQahGaZruCIzbTuMzwaRna24qHZpQ1OtC484dZfsAp5sc/9bbwTiDAvwalrOJrtStK3TDnAdLxxalPYDKoeeDIWz0qiYVZe8JxmVflssE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HY/pSNyz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HY/pSNyz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D8711F00A3A
	for <linux-acpi@vger.kernel.org>; Wed, 24 Jun 2026 13:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782306672;
	bh=xsgq3ScHDNFwRFdc+fgrt/khXDJ1hKIt3mrYBveO0tA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HY/pSNyzG2rPelY1ZgX7FXA1J85TB8lBb3lJe12XuK2LAldcVRc63vh3iL+WsIlJH
	 sy4UIcpt3jh4ch1xEiJK7Al+XPMMuvaPNso5/UumlV58vZHagfTeLD813SlGa02ER9
	 suB9nE+9jjhCulcV4E0YSaJaWuCWW1nUr0CIDexE+zlVbfHoIsLFr65a2cNBcbNHd4
	 foAkPQxNqKDdmNYnNIb546bnBkRi4dpLUnJ6xvHsG2Gan3p1APtPlp8uSzW0Nl9+0x
	 0DLwHFqLOgU8eBaP967bJOrMv64toddjZKto6w+h3qIt9Ld1EnSuF96h9C1HMVQn/u
	 TPltg28RKCgag==
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5ad49da7123so922452e87.0
        for <linux-acpi@vger.kernel.org>; Wed, 24 Jun 2026 06:11:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rqsrgkj5okY9626UXwIwd+XVd7DArbxU6NACnsoHeajV7NLWPSElddP1Zj+cv2J2+n033OqVThRZXyK@vger.kernel.org
X-Gm-Message-State: AOJu0YzFiIfB9k15Spd8uQbKIUEFOotqVCU+q5VCIXHkbsSa/kaD9IEC
	hqk9GBtnbH0oYshXWjMcUlTlqkFEkQCeDujyPp0hCq9FmtCv6TTKL6D67OlrvyEA/t3if6Ia7D5
	OjKyCHoci+2iRhE4EOEXDMFH2EPAz24E=
X-Received: by 2002:a05:6512:3133:b0:5ad:57dd:1efd with SMTP id
 2adb3069b0e04-5ad69592157mr1527380e87.8.1782306671107; Wed, 24 Jun 2026
 06:11:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617135518.1100698-1-ben.dooks@codethink.co.uk> <CAJZ5v0ji5ps3+-+MJtN-g_k_B3UEQDry9XF6ZUEVD8nyrc-fpw@mail.gmail.com>
In-Reply-To: <CAJZ5v0ji5ps3+-+MJtN-g_k_B3UEQDry9XF6ZUEVD8nyrc-fpw@mail.gmail.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 24 Jun 2026 15:10:55 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0g=0ShZDS_fcs41hVSbpQDft=UQNornRMQMJEXD8kcMmQ@mail.gmail.com>
X-Gm-Features: AVVi8CfjCm3jjEyAczn4cZQxg4DE-4rCA44JsvYaF7lNAaDcQhjxwZbiKIcLjC4
Message-ID: <CAJZ5v0g=0ShZDS_fcs41hVSbpQDft=UQNornRMQMJEXD8kcMmQ@mail.gmail.com>
Subject: Re: [PATCH] PNP: make pnp_eisa_id_to_string() take __be32 id
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ben Dooks <ben.dooks@codethink.co.uk>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 23, 2026 at 4:50=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.or=
g> wrote:
>
> On Wed, Jun 17, 2026 at 3:55=E2=80=AFPM Ben Dooks <ben.dooks@codethink.co=
.uk> wrote:
> >
> > The pnp_eisa_id_to_string() should take a __be32 id as it
> > passes it immediately to be32_to_cpu(). Change the type
> > of this to fix the following sparse warning:
> >
> > drivers/pnp/support.c:42:14: warning: cast to restricted __be32
> >
> > Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> > ---
> >  drivers/pnp/base.h    | 2 +-
> >  drivers/pnp/support.c | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pnp/base.h b/drivers/pnp/base.h
> > index b342570d0236..7b666b6ac40e 100644
> > --- a/drivers/pnp/base.h
> > +++ b/drivers/pnp/base.h
> > @@ -11,7 +11,7 @@ extern const struct bus_type pnp_bus_type;
> >  int pnp_register_protocol(struct pnp_protocol *protocol);
> >
> >  #define PNP_EISA_ID_MASK 0x7fffffff
> > -void pnp_eisa_id_to_string(u32 id, char *str);
> > +void pnp_eisa_id_to_string(__be32 id, char *str);
> >  struct pnp_dev *pnp_alloc_dev(struct pnp_protocol *, int id,
> >                               const char *pnpid);
> >  struct pnp_card *pnp_alloc_card(struct pnp_protocol *, int id, char *p=
npid);
> > diff --git a/drivers/pnp/support.c b/drivers/pnp/support.c
> > index f6c866851769..07c9844680ac 100644
> > --- a/drivers/pnp/support.c
> > +++ b/drivers/pnp/support.c
> > @@ -37,9 +37,9 @@ EXPORT_SYMBOL(pnp_is_active);
> >   * Functionally similar to acpi_ex_eisa_id_to_string(), but that's
> >   * buried in the ACPI CA, and we can't depend on it being present.
> >   */
> > -void pnp_eisa_id_to_string(u32 id, char *str)
> > +void pnp_eisa_id_to_string(__be32 _id, char *str)
> >  {
> > -       id =3D be32_to_cpu(id);
> > +       u32 id =3D be32_to_cpu(_id);
> >
> >         /*
> >          * According to the specs, the first three characters are five-=
bit
> > --
>
> Applied as 7.2-rc material, thanks!

And dropped because it causes sparse to complain:

https://lore.kernel.org/linux-acpi/202606241828.hRy0jZOE-lkp@intel.com/
