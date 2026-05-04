Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569E03A6F0C
	for <linux-acpi@vger.kernel.org>; Mon,  4 May 2026 11:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777892487; cv=none; b=A1BYfwAFnRHCwhU9g1DVhjzXhqnmrdUnLAaXcMBvplwVDEV8gt/MY0rq+c7GX280UWDCkKnrWIrkkzUmsm4fdLbi5zmIMFeaYKgFabJH3jg/wLpTFzujgCnqQKyuOej9U1eh7Uwu7a9bhOke6WVv+RUSwRsBKOzkJkxBbKkeCNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777892487; c=relaxed/simple;
	bh=ImXrHCwGy8/aN+MYwFMS9Bky+rG6EWRzoWw+lbmYY5s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YbB9jMqLtV8n2OYACbbLldIAPTkoCmcOp6PvRpG9sTnBd6O7NT+T6x9ky/gl5AhJB/LZIBTdbv12LFSDf0HEP7hluWEIRXudLRuWr1IoO+P7r2Qw5CA/ei5VdF/6v5LKbE+Z86DQ9E3HRMyUnMfq859fNQAWEjQJqWzQ2KGwB3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovDj9JGW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovDj9JGW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386EBC2BCFC
	for <linux-acpi@vger.kernel.org>; Mon,  4 May 2026 11:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777892487;
	bh=ImXrHCwGy8/aN+MYwFMS9Bky+rG6EWRzoWw+lbmYY5s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ovDj9JGWejYHYhvl7ZaptOOmM4bW4wqKg31G0QeKeDCF6UlBLWXg+8kZr37azQVbk
	 lHhnZkcWUkyMiwFZimWeATb0NdqdWdIBU9Xr6akMEfijCFvmX5jl8TXAT8Nh9bHukd
	 YGJGUyRpGeuBW82+OfAsUmlJvdkVYDaJxDEoF/5DTRjlwGjfzF2117B69tfCO7hpUs
	 uqrEKtGrLo16Qu/p9fDU9mL2vAeKjLAGN378cnef3aee0UpsGW+oAUvTJXofHcGITw
	 reb0pmYk0+JkRhzTCUZVCAqHI7RZ5AJ/dMtVoBApDQ18JnZ7NZoNVEV4ycKw5/fT8r
	 cX2R7G68xDDEw==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a40d02b58bso3318995e87.3
        for <linux-acpi@vger.kernel.org>; Mon, 04 May 2026 04:01:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8s826T59FitYr1eTvlvOHER6uXYLGexKUBoW4MHq8Vo6fAE52dDmikx8CmWd9z5WJXZqaHgAhYrQpb@vger.kernel.org
X-Gm-Message-State: AOJu0YzOWcfnvoQoiywC8t2EczR2LWXVnMj85h08XOOr/Jy9hikNe5CV
	69QDYWIAW9DHNRkt8oCDYzFmouyVXWGyE0BefZtPCdD/CYvjDSGm6ER3apb3F51sB3AzGNTpD4K
	xeYllE9KrOP55m9fXRhyPH4l0xt5qHOrRZwuO4ZNUgQ==
X-Received: by 2002:a05:6512:696:b0:5a8:704d:c20b with SMTP id
 2adb3069b0e04-5a8704dc59dmr1533607e87.27.1777892485701; Mon, 04 May 2026
 04:01:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504-baytrail-real-swnode-v5-0-c7878b69e383@oss.qualcomm.com> <20260504-baytrail-real-swnode-v5-2-c7878b69e383@oss.qualcomm.com>
In-Reply-To: <20260504-baytrail-real-swnode-v5-2-c7878b69e383@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 4 May 2026 13:01:13 +0200
X-Gmail-Original-Message-ID: <CAMRc=MdNPkVH7zmrypXcfN3rQR_nmSAFPFunZak_NjbWb4VYcA@mail.gmail.com>
X-Gm-Features: AVHnY4IxCBxO6eTgS-AVpI_BYjwldDfRg6f2ELcYNkBfYeLOHpEzH1V0noCK12I
Message-ID: <CAMRc=MdNPkVH7zmrypXcfN3rQR_nmSAFPFunZak_NjbWb4VYcA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] platform/x86: x86-android-tablets: enable fwnode
 matching of GPIO chips
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 12:59=E2=80=AFPM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> In order to allow GPIOLIB to match cherryview and baytrail GPIO
> controllers by their firmware nodes instead of their names, we need to
> attach the - currently "dangling" - existing software nodes to their
> target devices dynamically.
>
> The driver uses platform_create_bundle() and expects all required
> providers to be present before it itself is probed. We know the name of
> the device we're waiting for so look them up and assign the appropriate
> software node as the secondary firmware node of the underlying ACPI node.
>
> Scheduling fine-grained devres actions allows for proper teardown and
> unsetting of the secondary firmware nodes.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---

Reviewed-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
