Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EBD42EECE
	for <linux-acpi@vger.kernel.org>; Tue,  5 May 2026 12:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984689; cv=none; b=ucENqYG5aShXIbSRsPSvk+jUcnUtFGK/L/ApIPOt8ZedRlopzH8TNmPBSExRWDbfQ69atuOw/YwSwv75RN3TvrS6i/uuh2bhIBNG08MCw2pyWwmpGxvqOmPecRLGOtdkn15bfAqKiY27Wfxz9JKAZ5Hr3JgihIqACFpbBut71dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984689; c=relaxed/simple;
	bh=fnSRU9v45eKjzKIgKd4OZcWY2fGpa+k/jKcagc5ALtg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c0NcAV1+mdWXvwB6E8WhSnjDsmpkk1Hc9dYC1FRImmLdA1nmi7Th1Y496c5LmEX7V/JjsxmxrjRRQszq3ZOVY0Mn9qLGWH4cWQw+ZvW53FLe9sG6i72Z7qVOW8Xk80yxrOhEEU3RZUTHQ5jZcHp1B/D0LFhb6YLuIbbpkmAp8Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coWiIcub; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coWiIcub"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6500DC2BCC9
	for <linux-acpi@vger.kernel.org>; Tue,  5 May 2026 12:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777984689;
	bh=fnSRU9v45eKjzKIgKd4OZcWY2fGpa+k/jKcagc5ALtg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=coWiIcub1+LFjk+LL0aoMMUgTk9eQlxsfYJqww+3Hsx8vK55uV/2OU2QcEtRT214j
	 1Ddfp7gzamX03EvB0l2GWFwpHJmvyFPut9UZ9nhvrcakSptQIxgUCtxEXdM89Ig4oq
	 TXBLoeh3QxxGddSIvGOyxfeu4YQFtva03t3ecv49O9CVsuMRf+UmEK0uZMyJL/Phna
	 PfYX1cjK+uId4KnT0qowIfFTY91E85O1PtUak82a5g0hf7RzMsP/3zMUV004xTimzz
	 uzE24U7dmcn+wLdMeFKCPHf48ZZNHqCVDCzH8IWCldxxlZSWBYUaNUqf3T2PqiEUSF
	 XUpTPX6cpDdlA==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-38a01c80c34so52022541fa.0
        for <linux-acpi@vger.kernel.org>; Tue, 05 May 2026 05:38:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/MhWNlEwHAvebmMBNwlNRhWYi9x3x0opqklITkyMDANaXD1hfYXT1zLP5piga82NnUQsEc3R24vMab@vger.kernel.org
X-Gm-Message-State: AOJu0YyqSmOYHlw0PyHAi/Ed6rOXP4lyLt4cclEaLvuwUqSm2QKOES3z
	ND4sexrUm/wApaUdPJFM0Me9coqNsHmLrYUSSkx16RJVm7d+/nFRtVkCBRWvr3oJWPxnt4Hpu6g
	1qhagQprI7wmNk/swZA59OafFf3nSp+4=
X-Received: by 2002:a05:651c:e09:b0:393:a5ed:7dca with SMTP id
 38308e7fff4ca-393a5ed7e4emr30481781fa.10.1777984687819; Tue, 05 May 2026
 05:38:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504-baytrail-real-swnode-v5-0-c7878b69e383@oss.qualcomm.com> <20260504-baytrail-real-swnode-v5-2-c7878b69e383@oss.qualcomm.com>
In-Reply-To: <20260504-baytrail-real-swnode-v5-2-c7878b69e383@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 5 May 2026 14:37:55 +0200
X-Gmail-Original-Message-ID: <CAD++jLmMqbxHwTYUV8oUNiAfLgzPJdRi7bTwKtyepORzUNo=YQ@mail.gmail.com>
X-Gm-Features: AVHnY4IDQ1oB_Ou-vRaPBfPoo590aKglB83vcaM3z31gvraOfSdTNIO1HFFKK-I
Message-ID: <CAD++jLmMqbxHwTYUV8oUNiAfLgzPJdRi7bTwKtyepORzUNo=YQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] platform/x86: x86-android-tablets: enable fwnode
 matching of GPIO chips
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	brgl@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 12:59=E2=80=AFPM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:

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

Nice work here Bartosz!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
