Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D50F639B48D
	for <linux-acpi@vger.kernel.org>; Fri, 25 Sep 2026 16:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790354861; cv=none; b=fYigDMvMWEctjdqySIqbVtyW+8i/W6LOwBnE1AaAdwMPXQMOcbaDy9eAGl+WVlXXWdfF7qAC9vBg5J2WXV+SaQYeHUoblb3+BJ//2IhCGA8x9FV7vKOWbTCdS6MxWvBjD4ktt3O037XsQalie2ZvGEWT+tJAKHecc1tQ47o0xBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790354861; c=relaxed/simple;
	bh=yRNP7JJv8DMYuaMMrI3ydSH+CiAcUV1fiK68z0Rucrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IwrxiPF8DQbI7uik+g71hyzVHOL3AE/E9whaFv8mKgqaZCu5zHfFCnlWKgu3P4xpWB01s2ThgAcXA5RSS9EBY/TKdfPv+3qekkmtH3umgwSexpVWVu6PdnOjf7zNqpS/AEc/Alys22wB8EVo34sUbTEJa81AsLcCAZBkQ1bkNd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTmZ5eGT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTmZ5eGT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6812B1F0089F
	for <linux-acpi@vger.kernel.org>; Fri, 25 Sep 2026 16:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790354851;
	bh=iim/I3m/pOfA3+/sEqVuINrhYNfhRuff5X8WU9Eq7f4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=YTmZ5eGT7ienYC4lxZLBjuZcEysyr/QoeaALVmPUPJ47OgdrvD9uydSMHj1TPFNNr
	 N09tQONS3+FF8ZtQIr9uP6EMPmrc27WihNlic7X88JyYug+ueZXTyT02unGiioF9Px
	 Xqx8VcCGQ6tlps1PqcMJu0NvWBoK1kplkwL5+UworeVrFOn81xgKsEvAiUuVsXhaSS
	 akUphil96Een5DVhXIHKYYSbB5+H8M6fiAczGUCKXLKT2ySo3tL0fjYWSB2YFYOUf6
	 hgEiNwYonLPKYi701HV4Pzmsdov5OVLlOSkhCPgm1i6lV4elVkFFV4lbEBSaWzzgT2
	 KHaEq9oreOApA==
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a659495608so837391fa.2
        for <linux-acpi@vger.kernel.org>; Fri, 25 Sep 2026 09:47:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwnCbCxqa5hXQo8MzM5pdNOVMqGpGfKyI5NG6Dwrulzpw8b7DzL2gTH25kbgkoOjidOjzik7ahKlYO7@vger.kernel.org
X-Gm-Message-State: AFuF++mJ7QmE8Cum1N9iKr4sTm1ZxJXnwBlaMs/OCGf0wRuU2o29YnR7
	37a3J85nN5W0XuHJ8BHuwDp8U5BmiHoq0yEr6x9tc5v5RHV81f8eCMNY7wS57RwMRAbpCtgyf4G
	nGrPlpw8m1+Dj+Axw6izfhAJXFvwF6EY=
X-Received: by 2002:a05:651c:41c8:b0:3a5:b50c:43a0 with SMTP id
 38308e7fff4ca-3a63dd6254fmr11868391fa.5.1790354849626; Fri, 25 Sep 2026
 09:47:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260925162628.4142365-1-mario.limonciello@amd.com>
In-Reply-To: <20260925162628.4142365-1-mario.limonciello@amd.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 25 Sep 2026 18:45:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gOVtss255tHW_rR3=Rj6YCWk4sPDs4XwsuasfemwODkw@mail.gmail.com>
X-Gm-Features: AclHuK9wxscB15bVOwor1gAh2AHWU4bYe3jFfO0hSArQkqVd11eVNB4jHYCO2WM
Message-ID: <CAJZ5v0gOVtss255tHW_rR3=Rj6YCWk4sPDs4XwsuasfemwODkw@mail.gmail.com>
Subject: Re: [PATCH v3] ACPI: Add stub for acpi_find_child_device()
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: rafael@kernel.org, lenb@kernel.org, maciej.wieczor-retman@intel.com, 
	pawel.chmielewski@intel.com, Arnd Bergmann <arnd@arndb.de>, 
	Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi <peter.ujfalusi@linux.intel.com>, 
	Bard Liao <yung-chuan.liao@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Vijendar Mukunda <Vijendar.Mukunda@amd.com>, Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>, sound-open-firmware@alsa-project.org, 
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 6:26=E2=80=AFPM Mario Limonciello
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
> v3:
>  * Use static inline instead
>    Note: this relies upon
>    commit e7280ab196ba4 ("ACPI: bus: Use acpi/acpi_bus.h without CONFIG_A=
CPI")
>    when cherry-picking to sound/for-next
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
>  include/acpi/acpi_bus.h | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 7dbe5d42c67e8..a755b15af9db9 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -954,6 +954,13 @@ u32 arch_acpi_add_auto_dep(acpi_handle handle);
>
>  #else  /* CONFIG_ACPI */
>
> +static inline struct acpi_device *
> +acpi_find_child_device(struct acpi_device *parent, u64 address,
> +                      bool check_children)
> +{
> +       return NULL;
> +}
> +
>  static inline bool acpi_has_method(acpi_handle handle, char *name)
>  {
>         return false;
> --

Applied as 7.4 material, thanks!
