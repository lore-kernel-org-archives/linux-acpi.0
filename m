Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021A92F83B5
	for <linux-acpi@vger.kernel.org>; Wed,  6 May 2026 19:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778095575; cv=none; b=YTlIDblhBAgs9qgo6606jJFuFvF+wpS4RCRfXO5hCicZIq2Psd3n7ZcA1Rq2EdK2k25Fq3N/5bmgRDFEGcvA38ntKo+RYbJLa99lwmjfYAKnQpWQAiFz8dSk1OLtZNBBbIiainLTbVRFRXZ3klnlW3nUYS5iVAEao5R53Wxglco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778095575; c=relaxed/simple;
	bh=SHjwx8WAVtwlWVCkuLYCj4e2j7SsWE8uM4rrhcuQlZ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uhB1aLpTLLkflzPsbgShVS5wEe3RXbaaW1gfYrenPGkah42DgpMglbVAHrgV08lNZ97sjn5kNjsrJ22M8cbjehWH+p0o9MpZmTckllv6HFPN7yhnAZsRV89wg5srznaZ7NQpoedWyxdGPJGrAtMit6n4M7nP6m8aqK5jWM6aw4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXrpt+uF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXrpt+uF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBEBC2BCF5
	for <linux-acpi@vger.kernel.org>; Wed,  6 May 2026 19:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778095574;
	bh=SHjwx8WAVtwlWVCkuLYCj4e2j7SsWE8uM4rrhcuQlZ0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=BXrpt+uFj10aSYQHL8oQZHM2AqEsM0UKWSDgWWwYsKqxp2ilIUWNZjFo0jFBelIAj
	 fnhToU0a9U35cDet+0LuUH5z5V3sYbG2kg7GhjeyQyiAN/Z4bVikdHzO3TOtzkfT7v
	 10F1xiE3jNSZt4OYJA5QzYYhiBn3e766EIm6crYRWbdQAcH+jyd1q4nAt/Tqvl67+7
	 wMNyXOeKy7Iqo+b6UbsKtZ3af3oYuhJmi3oYRONBc1IzYSzcMQ54YfKDreEYIQ7D8c
	 LYrwTxWNc//2eOwQFnMaRkjEzDL1gy//n4k/6fk3Lknytr6rsZGl/doW1+aMH4GMO1
	 JtFoVIjXT01gQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a88db610ccso1009550e87.2
        for <linux-acpi@vger.kernel.org>; Wed, 06 May 2026 12:26:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9v3yqbhtHjBBK47UGcN5uUdhLcYj2gWi+MNC5lQHuk4OF3KlKsHFkk8ymDwLfj15Hex0qv0NOJvJgK@vger.kernel.org
X-Gm-Message-State: AOJu0YxJfwjhcVGXXFYdwHSk67i6x4t2RF0qDNK8n5jDV2kPP4CWyiC6
	zyvCt9IEprcFqzMjZa63VrAB0Nyp8ZUVP7dY9XUPmovCAq/huX5N4h49SEbFW7O43rdblAHYIhZ
	EDJ7BIyfzCCrFAlvD/PlREiGed535Oa8=
X-Received: by 2002:a05:6512:4008:b0:5a2:bb8e:d4f4 with SMTP id
 2adb3069b0e04-5a887ae1897mr1782471e87.15.1778095572920; Wed, 06 May 2026
 12:26:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506115701.23035-1-bartosz.golaszewski@oss.qualcomm.com>
In-Reply-To: <20260506115701.23035-1-bartosz.golaszewski@oss.qualcomm.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 6 May 2026 21:26:00 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h_mOTJh24nY2nMetb6+V9YX2k7pm9c4KQL0UnkNWfCBw@mail.gmail.com>
X-Gm-Features: AVHnY4KNiOZb3EUI-ZUonk7tswg3J53sY87FS-DrxRZKslELyo8d53tW5I3y3GE
Message-ID: <CAJZ5v0h_mOTJh24nY2nMetb6+V9YX2k7pm9c4KQL0UnkNWfCBw@mail.gmail.com>
Subject: Re: [PATCH] device property: set fwnode->secondary to NULL in fwnode_init()
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, driver-core@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, brgl@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 1:57=E2=80=AFPM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> If a firmware node is allocated on the stack (for instance: temporary
> software node whose life-time we control) or on the heap - but using a
> non-zeroing allocation function - and initialized using fwnode_init(),
> its secondary pointer will contain uninitalized memory which likely will
> be neither NULL nor IS_ERR() and so may end up being dereferenced (for
> example: in dev_to_swnode()). Set fwnode->secondary to NULL on
> initialization.
>
> Cc: stable@vger.kernel.org
> Fixes: 01bb86b380a3 ("driver core: Add fwnode_init()")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
>  include/linux/fwnode.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 80b38fbf2121..31df7608737e 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -208,6 +208,7 @@ struct fwnode_operations {
>  static inline void fwnode_init(struct fwnode_handle *fwnode,
>                                const struct fwnode_operations *ops)
>  {
> +       fwnode->secondary =3D NULL;
>         fwnode->ops =3D ops;
>         INIT_LIST_HEAD(&fwnode->consumers);
>         INIT_LIST_HEAD(&fwnode->suppliers);
> --
> 2.47.3
>
>
