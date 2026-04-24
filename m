Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6931C3537DF
	for <linux-acpi@vger.kernel.org>; Fri, 24 Apr 2026 13:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038232; cv=none; b=rLmv4QpReO6w+F44VZqY1rfFkeO8lsUoQHQJHWaGJl1kUkT0rxpQksVvQALdqoSKCJ6dnY98TrLwhVp+N8F5qMl/5DvNiYhVmSa3/iaRbQD9qsS29Ky6cO5/uZcmZK0pIM5v/e4vjUV2gpcILK6Wgi0ox6/FI+UhAxi2Yr9rpJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038232; c=relaxed/simple;
	bh=FmgGAit9uRzGO3xet/eqN3lq9GCGYLBym1lCLJ8IQnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2ngNnELUmXG3T4H3OxaDZDIg8zdffLl/ne049BHTDH5zCVfdYVisNWyg80blm3l7wDthobMRfs/hxnS43CM1fRHHDJy+rxXG+3+nkv6IyM64TY+j/tXNet6Xw/+SzvN5GL62+ZjL/ARcJWWNs3sI6+HCWXi02eFqU8ky9MAfdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8qWr7ih; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8qWr7ih"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C76BC2BCB9
	for <linux-acpi@vger.kernel.org>; Fri, 24 Apr 2026 13:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777038232;
	bh=FmgGAit9uRzGO3xet/eqN3lq9GCGYLBym1lCLJ8IQnE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V8qWr7iheavDDIt7GjSEl9WDNWLMb22S73zvMgEtDJLPx0JFnj7/I5gCewhl9hn4E
	 n/AtJ14boFmI1DuakxkNA+3iO7KkSJNOt7ZCk/IxqqMxPGnH+S+1eDYsUEfsPdcYHE
	 f7/KtpGLDIDiw9+QWHVnprGM36VUJGKCP/QXY1juMtJ4Lpd+kWR4Ik1CEwD2dhFYcd
	 xRvIqYE2NyQfrezpx3DkoyDZofmOXkI6peRsJ1DwX4/p5fdIioyMYCPv22DjKd+QZr
	 4nwBY2WbMjuV03WdaOfiS1ubaKCwKnzrPF1EJJFw/AuWwMnK38sdEAqaR8FVgMMabj
	 j0as8ExhHCyLg==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38e7b8e3f38so66199961fa.3
        for <linux-acpi@vger.kernel.org>; Fri, 24 Apr 2026 06:43:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8PnB8fia9roEEIgGSFM9tcc9vTUuIicqwKlVdhFELpD5jlcCDSz4gNvjfF+eLJmh2BObNfcglfaue8@vger.kernel.org
X-Gm-Message-State: AOJu0YyhWN5/zpKeRIcaICBvPx0uiGYDDSb7Nb1eJBBHFNjObQUGiYy9
	axfJK7BeEiIJW7UCyH3nItQxHQhdpDvTDf1yP1MSpsOTrvXni5IXhv6ERJ5RcRaoV5C6PX2Doo2
	MJi53JtQUv3upXtFei8K2oEhEzzBRMucFVjDUMmGyHQ==
X-Received: by 2002:a05:651c:4187:b0:38e:4a7:89f1 with SMTP id
 38308e7fff4ca-38ec7ad6e60mr69108141fa.19.1777038230928; Fri, 24 Apr 2026
 06:43:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424124250.92890-1-bartosz.golaszewski@oss.qualcomm.com> <aetxEcjE8wD4-ZyV@ashevche-desk.local>
In-Reply-To: <aetxEcjE8wD4-ZyV@ashevche-desk.local>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 24 Apr 2026 15:43:39 +0200
X-Gmail-Original-Message-ID: <CAMRc=Mem3m8JZXafL9xrUvWZWuFaCofkNEdVYLNMgC+3N0i21g@mail.gmail.com>
X-Gm-Features: AQROBzB9I2et5uO4ft2dMETpT-FqzFM7i0Btesh4vot0plW7fkjDkI-V3t1YkK8
Message-ID: <CAMRc=Mem3m8JZXafL9xrUvWZWuFaCofkNEdVYLNMgC+3N0i21g@mail.gmail.com>
Subject: Re: [PATCH] software node: provide wrappers around kobject_get/put()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 3:33=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Apr 24, 2026 at 02:42:50PM +0200, Bartosz Golaszewski wrote:
> > Make the code more readable by avoid constant dereferencing of the
> > swnode's kobject when managing references. Provide wrappers that take
> > struct swnode * as argument and make them hide that logic.
>
> ...
>
> > +static void swnode_get(struct swnode *swnode)
> > +{
> > +     kobject_get(&swnode->kobj);
> > +}
>
> Isn't a pattern to return the object itself so the code can bump the refe=
rence
> in a single statement (if appropriate)?
>

Typically yeah but nobody here would use it right now. I can change it
if you prefer it.

>
> ...
>
> >       list_for_each_entry(child, &swnode->children, entry) {
> >               if (!strcmp(childname, kobject_name(&child->kobj))) {
> > -                     kobject_get(&child->kobj);
> > +                     swnode_get(child);
>
> Becomes inconsistent with kobject_name()...
>

What do you mean?

> >                       return &child->fwnode;
> >               }
> >       }
>
> ...
>
> >               swnode =3D kobj_to_swnode(k);
> >               if (parent =3D=3D swnode->node->parent && swnode->node->n=
ame &&
> >                   !strcmp(name, swnode->node->name)) {
> > -                     kobject_get(&swnode->kobj);
> > +                     swnode_get(swnode);
>
> Also not sure. Maybe use 'k'?
>

I'm not following either, please rephrase.

Bart
