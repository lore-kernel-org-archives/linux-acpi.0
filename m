Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC614CB8C1
	for <linux-acpi@vger.kernel.org>; Fri, 25 Sep 2026 15:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790350040; cv=none; b=nqPHwuP8CqvAi9Bg31VCIM+uaigZE3MAsQ10n0pltZYvFKmyuB2MqUCnHOPc8UEIrrKuJea2u7WvIVRvTP1LLhhOQJoulaW+lnd3TgRnllXZwnLQvK3WlAeg7TVkZ2NdcIm4r5y4yaf2ZfB8/YYY8WQ9QZf1IDR0P7LFpuPRfn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790350040; c=relaxed/simple;
	bh=CTTVNGvVtCnxXuvD5t5Y/UDySaO0cOSeZAlvJb8EOXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C1DgBNNVRqkbyoT4F0JxW+Yb4u7I9ISeW2VMLk8Eu2SbwVSetyEsV3nGfQ3mjETaGj0beo5YfqOoSRlKQDu0d95OGc1DZO0faRNUyC87zcvUKMXIAQH+qCrKbHjse1WwxqeqiBKGmylU+Yk8gYHZteOfVaQnSp1ckv54k8+35UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MftZaHoJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MftZaHoJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D621F0089F
	for <linux-acpi@vger.kernel.org>; Fri, 25 Sep 2026 15:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790350038;
	bh=S905qpe/M9FIOpIybvjAEeePlogpnKgd9+0hpRRjHLw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MftZaHoJm53vj1ooWxzuDT9r0d5VK1jJK1na9gJGOT8BtMEH4TRnmWWf/l5w7KX7c
	 zgNoAX8/+ze4EydbXkrrWE391Fo4VMLXkG33aX62qHxF5vSfbEVKyDZpn8y+yTClKx
	 cA02vqwYbdbmXd9nyjGsFiSxpDflhL0yemgVt3Y4rdUQd/iH3F8KI+1vEoaK/h0PUP
	 yrzWu70YtiKqf59d4Pu2jW7vc7lZc075tU1IgDLbi+74L1mFVBWD15Y5HkC+IM+R8f
	 diR97/FFEuOHBf4arAgclZv43sWvJ7Rps5aBD6Z1GNHDDLl6cdv0jm2uRlQbJCRF3e
	 t1K97casd+GqA==
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a64e7f48e0so8143681fa.0
        for <linux-acpi@vger.kernel.org>; Fri, 25 Sep 2026 08:27:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwAj6LRfWGO3QLK/p23poEN6QYrXur1r5Oktg/h8wW8aYhN3zSNVMb97C85NNnntp2Xi79b8lWNv09s@vger.kernel.org
X-Gm-Message-State: AFuF++lQjTvSe8GBTNgoKgKhZn1BbOUHmuDOfX/zsHy6LEGb6GldLHfG
	628HNPQxW/scodThndaspNGGZc5zg7hP5lexgT+4MA2w6WIknUKSwdfeQ5oGK+3c1k9cGwDNMbT
	G3UT6b9C3bQNItMVhCSRsJmK7n5lyqsE=
X-Received: by 2002:a05:651c:1541:b0:3a6:1694:81d7 with SMTP id
 38308e7fff4ca-3a63c070554mr15078381fa.8.1790350036861; Fri, 25 Sep 2026
 08:27:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925132031.4073551-1-mario.limonciello@amd.com>
In-Reply-To: <20260925132031.4073551-1-mario.limonciello@amd.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 25 Sep 2026 17:25:39 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gaQjZcUyT5jeKOBc+Hik4f+JD7r1r5RwYb24S79hoprw@mail.gmail.com>
X-Gm-Features: AclHuK9ZDRF-ZfCO2D7N0Di9wh4yXaRTwNUIe5YLhyv92jvpH7btM4jKmXoml1M
Message-ID: <CAJZ5v0gaQjZcUyT5jeKOBc+Hik4f+JD7r1r5RwYb24S79hoprw@mail.gmail.com>
Subject: Re: [PATCH] ACPI: Add stub for acpi_find_child_device()
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: rafael@kernel.org, lenb@kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
	Bard Liao <yung-chuan.liao@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, sound-open-firmware@alsa-project.org, 
	linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 3:20=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
>
> Provide a NULL-returning stub when CONFIG_ACPI is disabled so callers can
> be compiled without ACPI support.
>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Closes: https://lore.kernel.org/linux-sound/20260925131104.118993-1-arnd@=
kernel.org/
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
> Cc: Bard Liao <yung-chuan.liao@linux.intel.com>
> Cc: Daniel Baluta <daniel.baluta@nxp.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Jaroslav Kysela <perex@perex.cz>
> Cc: Takashi Iwai <tiwai@suse.com>
> Cc: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> Cc: Kai Vehmanen <kai.vehmanen@linux.intel.com>
> Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>
> Cc: sound-open-firmware@alsa-project.org
> ---
>  include/linux/acpi.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index ddacac8120947..710f38193d44c 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -843,6 +843,7 @@ extern bool cmos_rtc_platform_device_present;
>  #define ACPI_COMPANION_SET(dev, adev)  do { } while (0)
>  #define ACPI_HANDLE(dev)               (NULL)
>  #define ACPI_HANDLE_FWNODE(fwnode)     (NULL)
> +#define acpi_find_child_device(...)    (NULL)

Can you please add it to acpi/acpi_bus.h, on top of the current linux-next?

The function is originally declared in that file.

>
>  /* Get rid of the -Wunused-variable for adev */
>  #define acpi_dev_uid_match(adev, uid2)                 (adev && false)
> --
