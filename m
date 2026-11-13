Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591146;
	b=pWWRjy4ZH2daju0Wqz1E4AmSE5lsKZBagLN65T0DTnuEzfhD5jFe9odTbuva24fiZWtb
	 aOQ54cZr7EmYvfKI9tlkkOkYAm1cbbeXpp5gL4DN77ygPoliuyPi0MYnXQK4xilI1jmp+
	 Ay5OGxmVy5Ev7Uv9e3SKTN62znFrTbRJtmy0WL+yh+FhOjlG3mSIsdOQ85vkP9x2pf5O1
	 UBcvxgoDEVbBcM1Pikp6k7hf93TeUfQKavvJqTPG31Q6RqgNJTMDjpf6etGeEp2FvnL3f
	 2jT9XLJBk5snN8+X5BFe6HR3PgIa6JJFLIFD/S1vRq+6FGWJDdXgFFjhkkrbEqzI54w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591146;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=nSptiMb1CVuYUc/SgcCJgKBFQaoryOlduTQ9oVYzLTc=;
	b=FbfaHpVfDavs8m+VNKxRfPTn7bp9hz4CjiOhmbc2DLQmJQOXfP7Ez77MgzCFfaOGq3eO
	 sL9mQ0nG6qN7fyJXT/G8gCwrZ4h02aCkyWoDnqBBpCcqiiUx7chspc9T/h34z2PgwSRlE
	 Z1coHe4RyF0lvrYwhYoZzhtKFh9cH70EBEZCnY5Fu7zAzKralT1eQ0djU6z+wUScZKvdi
	 zjHhIvohiFrC4uyJ4sr4kPA0QuskXxQRWxNbzxEBvPLJPQeRFfS5WkAkH/Ea3Hg+vMaJE
	 ZsIXnjc4G86jpr5R27DyX5p90veIgKwaAlxC7SNz0nn17onjIZ5PeKOIuD0fxBS6x8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fBwS4+YW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EC6606BD3C
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fBwS4+YW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D731F000D2
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 17:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591146;
	bh=nSptiMb1CVuYUc/SgcCJgKBFQaoryOlduTQ9oVYzLTc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fBwS4+YWYjlGM2XruT7oZuYziu8O0IeHH2cqLgir27v+6/kwOyMUls9MDQhorSVyr
	 DvWqxw5rv00g8RoHKX/YBzAVPI2LxuhAuh090kBFMwxkOro1ooLHj3TOGXEVNw0Wbk
	 toCAFS4YjLogX7VNoBpQZ8ppXgLeBwc5DdE81McOJIHEyYgtpUKpzBo8tNtzjn1CHB
	 bvpfWwiIXkHn6UYXsx4mwLkpYaaSK0dj4NvLCCtB2amZJ97a6ncggTwMKancXO1qs4
	 V4NCLHIGUzw/HkiOxMVq8KCroE30mT1iwLxW8aKwFe54M3a1EpH+SSFxq9QPPjgcjm
	 rtvbNieDVCwjw==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3ab3b29a1d4so16283431fa.1
        for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 09:32:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErFLmigVlqYajGLiYdjzuilf9YTCzg/Ti43I4SGMlSilWh70sPLwzW8zH1TKhb+eX0tGtIT7yVFRtngi@vger.kernel.org
X-Gm-Message-State: APuU4Z+ZJT3oipLmfqh5ueUdYHVmiwD8a0KEBuORoKSZNE7LFI7PVnzd
	iDgoAY52On2kDsBPoeBAZpT5k2a8ypy0tv5SDgURKHYaCW0L6iJFAaN2QcjPQfC1+5c8SlG5Ez8
	/svqMP2heCcHW5CrGBrN1+zy+jQOY+YA=
X-Received: by 2002:a05:651c:b2c:b0:3ad:fb2d:a757 with SMTP id
 38308e7fff4ca-3ae2b5302cfmr9849351fa.24.1794591145071; Fri, 13 Nov 2026
 09:32:25 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110085125.2535508-1-johan@kernel.org> <20261110085125.2535508-7-johan@kernel.org>
In-Reply-To: <20261110085125.2535508-7-johan@kernel.org>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 13 Nov 2026 18:32:12 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gZQ1LL8ZizAK-kQdAUxyEL5uBLyzOOnMzi2DDVF4pRtQ@mail.gmail.com>
X-Gm-Features: AclHuK9F5GTbS6yo98TrXJgh2sPuvWLUYJkvQopVJlBgnULLF0J572bpzAoTEkk
Message-ID: <CAJZ5v0gZQ1LL8ZizAK-kQdAUxyEL5uBLyzOOnMzi2DDVF4pRtQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] driver core: platform: tests: fix swnode reuse
 test description
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, driver-core@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 9:52=E2=80=AFAM Johan Hovold <johan@kernel.org> wro=
te:
>
> The description of the software node reuse test is misleading as a
> software node being registered does not prevent it from being reused
> (e.g. as software nodes can be shared).
>
> Fix the description by clarifying that the test would fail if the
> secondary software node is not removed from the device so that the
> reused primary firmware node still points to the software node.

LGTM

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> Fixes: 397f0a3958c9 ("driver core: platform: tests: add test cases for co=
rrect swnode removal")
> Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> ---
>  drivers/base/test/platform-device-test.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/base/test/platform-device-test.c b/drivers/base/test=
/platform-device-test.c
> index 9ce563f76aad..b0cc37d166ff 100644
> --- a/drivers/base/test/platform-device-test.c
> +++ b/drivers/base/test/platform-device-test.c
> @@ -273,9 +273,10 @@ static const struct software_node platform_device_te=
st_swnode =3D { };
>  /*
>   * Check that reusing a software node works correctly. If the call to
>   * platform_device_register_full() fails after adding the secondary firm=
ware
> - * node, the software node must be unregistered in the device's release(=
)
> + * node, the software node must be removed in the device's release()
>   * callback or the subsequent call to platform_device_register_full() wi=
ll fail
> - * with -EBUSY due to the software node already having been registered.
> + * with -EBUSY due to the primary firmware node still pointing at the
> + * secondary software node.
>   */
>  static void platform_device_swnode_add_twice(struct kunit *test)
>  {
> --
> 2.56.0
>
