Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4606C390999
	for <linux-acpi@vger.kernel.org>; Fri, 13 Mar 2026 20:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773432776; cv=none; b=kE0EyeNbfs5Xi3eFS4xkaCoFvcprTcN8/vGw4mMnrJq3WmPjxWKxaeVTf+BA1LeTKcZyML1XMj6ZW5/MI9YIzQyHxVMF10PFst3ThtcGqHRXYd/WrBIvp8TuhVv8jG471E0tmFrsT6Mo15RYEHk+mZceEED5SOhvvjKSWf4ovmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773432776; c=relaxed/simple;
	bh=5eiMGcv0fPTNuOjZOpx6N19xlAH9MJGX5t7WBawIpVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BjptvjmTx7zeCW7mpJ2NipN9c3pyRMTuK1s11X7JnLAIEyyGoQrg7yajIGsRTvdN6mmP7hIGTNcxIwNKOvp2TN9f1ILDFZv7jFHF2q3EIjf15+3gGptKN3j6SS0KUDQEz87gy9ciz/n/xaV/ftujTPluCj6zKNsKw4ITqBz8X9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MF1AF0w+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MF1AF0w+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED06EC19423
	for <linux-acpi@vger.kernel.org>; Fri, 13 Mar 2026 20:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773432776;
	bh=5eiMGcv0fPTNuOjZOpx6N19xlAH9MJGX5t7WBawIpVk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MF1AF0w+xe7zllc06hruF2zbVRr0y+iV6P0sT/cA5Cg4mHKbXAp5UF9mlmkK+qNSp
	 67957UFr4xsRG03pqMjj7BaRqqr0gsyr/feO0fh75QCG0I8zy/bitDWQiga5QZQvii
	 jIGgx0JBfmUN4tqYLd1L5IEOKNXsujwqU9+ziN92JoD60eTHV6BXpba5iYdXqlGSmm
	 CqxV1osVh9y2YxVrzo43liFtHd/fiwCtkespD78qd4vBpuvb5nb6kKRsvn3G0+R7TU
	 Rxo3v/lhchI0XRsZYgjkABiM4hjX4OsXPzLHQ3d+x6/sPwAa79ESvEN4R5nCCdxwmI
	 NQAIc21MMqbWg==
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7d4c12ff3d5so2301243a34.2
        for <linux-acpi@vger.kernel.org>; Fri, 13 Mar 2026 13:12:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXcyRwoVPHBQZnk97J9LHWtrmIZzg44BcmhZl2wUJx9Hns0vk89dkEIZBfcKUlHe6XgHNQbOvgZTT8F@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2p/3i3j/X6Gs6BU5+7o8+ZfqVaNJD24ZipLf/SNN13AtaCuZp
	YlRXw1NWH8PtIYap1RQTmYMf1x7ndtj6vaJZI1Sf5gyxnQJ71cMR6cmc1MZLWyjOiZ8CvdzW9AP
	61V6AemY7wEM9JeVLGSHMLFNxYw8Qn64=
X-Received: by 2002:a4a:ca01:0:b0:67b:de4d:f309 with SMTP id
 006d021491bc7-67bde4df9c6mr1525775eaf.38.1773432775016; Fri, 13 Mar 2026
 13:12:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251226102656.6296-1-lkml@antheas.dev> <20251226102656.6296-3-lkml@antheas.dev>
In-Reply-To: <20251226102656.6296-3-lkml@antheas.dev>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Mar 2026 21:12:43 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0hnP1cJqGN9gLyAgtz5pmRO0xsF6O8ZtnQ+ktRjSSOkyA@mail.gmail.com>
X-Gm-Features: AaiRm53A5Gd34TnYgWfcFGDfknhxpPtZUs-MiFkK78pg1lceoSyPrjiDKQ-6qqY
Message-ID: <CAJZ5v0hnP1cJqGN9gLyAgtz5pmRO0xsF6O8ZtnQ+ktRjSSOkyA@mail.gmail.com>
Subject: Re: [RFC v1 2/8] acpi/x86: s2idle: Rename LPS0 constants so they
 mirror their function
To: Antheas Kapenekakis <lkml@antheas.dev>
Cc: dmitry.osipenko@collabora.com, bob.beckett@collabora.com, 
	bookeldor@gmail.com, hadess@hadess.net, jaap@haitsma.org, 
	kernel@collabora.com, lennart@poettering.net, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mccann@jhu.edu, rafael@kernel.org, 
	richard@hughsie.com, sebastian.reichel@collabora.com, superm1@kernel.org, 
	systemd-devel@lists.freedesktop.org, xaver.hugl@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 26, 2025 at 11:27=E2=80=AFAM Antheas Kapenekakis <lkml@antheas.=
dev> wrote:
>
> The LPS0 3/4 constants are part of a firmware notification called
> "Display on/off", in which the device enters a "Screen Off" state.
> The LPS0 7/8 constants are part of a firmware notification in which
> a Windows modern standby computer enters a "sleep" state where the
> CPU may still be active and maintain the radios.
>
> However, currently, the values are named as "Screen on/off"

This is based on the Intel documentation:
https://uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle=
.pdf

> and "MS entry/exit", where Modern Standby is abbreviated as "MS". Therefo=
re,
> perform a minor rename so that the values match their function.

I'm not sure about the first two at least.

> Then, fix the debug message to say that it executes notifications instead=
 of
> entering states as it is otherwise confusing.
>
> Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> ---
>  drivers/acpi/x86/s2idle.c | 54 +++++++++++++++++++--------------------
>  1 file changed, 27 insertions(+), 27 deletions(-)
>
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 6d4d06236f61..1f13c8b0ef83 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -39,19 +39,19 @@ static const struct acpi_device_id lps0_device_ids[] =
=3D {
>  #define ACPI_LPS0_DSM_UUID     "c4eb40a0-6cd2-11e2-bcfd-0800200c9a66"
>
>  #define ACPI_LPS0_GET_DEVICE_CONSTRAINTS       1
> -#define ACPI_LPS0_SCREEN_OFF   3
> -#define ACPI_LPS0_SCREEN_ON    4
> +#define ACPI_LPS0_DISPLAY_OFF  3
> +#define ACPI_LPS0_DISPLAY_ON   4
>  #define ACPI_LPS0_ENTRY                5
>  #define ACPI_LPS0_EXIT         6
> -#define ACPI_LPS0_MS_ENTRY      7
> -#define ACPI_LPS0_MS_EXIT       8
> +#define ACPI_LPS0_SLEEP_ENTRY  7
> +#define ACPI_LPS0_SLEEP_EXIT   8

These two renames are fine with me, although I'm not sure if they are
worth the hassle.

>
>  /* AMD */
>  #define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-932122d3772=
1"
>  #define ACPI_LPS0_ENTRY_AMD         2
>  #define ACPI_LPS0_EXIT_AMD          3
> -#define ACPI_LPS0_SCREEN_OFF_AMD    4
> -#define ACPI_LPS0_SCREEN_ON_AMD     5
> +#define ACPI_LPS0_DISPLAY_OFF_AMD   4
> +#define ACPI_LPS0_DISPLAY_ON_AMD    5
>
>  static acpi_handle lps0_device_handle;
>  static guid_t lps0_dsm_guid;
> @@ -340,25 +340,25 @@ static const char *acpi_sleep_dsm_state_to_str(unsi=
gned int state)
>  {
>         if (lps0_dsm_func_mask_microsoft || !acpi_s2idle_vendor_amd()) {
>                 switch (state) {
> -               case ACPI_LPS0_SCREEN_OFF:
> -                       return "screen off";
> -               case ACPI_LPS0_SCREEN_ON:
> -                       return "screen on";
> +               case ACPI_LPS0_DISPLAY_OFF:
> +                       return "display off";
> +               case ACPI_LPS0_DISPLAY_ON:
> +                       return "display on";
>                 case ACPI_LPS0_ENTRY:
>                         return "lps0 entry";
>                 case ACPI_LPS0_EXIT:
>                         return "lps0 exit";
> -               case ACPI_LPS0_MS_ENTRY:
> -                       return "lps0 ms entry";
> -               case ACPI_LPS0_MS_EXIT:
> -                       return "lps0 ms exit";
> +               case ACPI_LPS0_SLEEP_ENTRY:
> +                       return "sleep entry";
> +               case ACPI_LPS0_SLEEP_EXIT:
> +                       return "sleep exit";
>                 }
>         } else {
>                 switch (state) {
> -               case ACPI_LPS0_SCREEN_ON_AMD:
> -                       return "screen on";
> -               case ACPI_LPS0_SCREEN_OFF_AMD:
> -                       return "screen off";
> +               case ACPI_LPS0_DISPLAY_ON_AMD:
> +                       return "display on";
> +               case ACPI_LPS0_DISPLAY_OFF_AMD:
> +                       return "display off";
>                 case ACPI_LPS0_ENTRY_AMD:
>                         return "lps0 entry";
>                 case ACPI_LPS0_EXIT_AMD:
> @@ -383,7 +383,7 @@ static void acpi_sleep_run_lps0_dsm(unsigned int func=
, unsigned int func_mask, g
>         lps0_dsm_state =3D func;
>         if (pm_debug_messages_on) {
>                 acpi_handle_info(lps0_device_handle,
> -                               "%s transitioned to state %s\n",
> +                               "%s executed notification %s\n",
>                                  out_obj ? "Successfully" : "Failed to",
>                                  acpi_sleep_dsm_state_to_str(lps0_dsm_sta=
te));
>         }
> @@ -545,12 +545,12 @@ static int acpi_s2idle_prepare_late_lps0(void)
>         /* Screen off */
>         if (lps0_dsm_func_mask > 0)
>                 acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
> -                                       ACPI_LPS0_SCREEN_OFF_AMD :
> -                                       ACPI_LPS0_SCREEN_OFF,
> +                                       ACPI_LPS0_DISPLAY_OFF_AMD :
> +                                       ACPI_LPS0_DISPLAY_OFF,
>                                         lps0_dsm_func_mask, lps0_dsm_guid=
);
>
>         if (lps0_dsm_func_mask_microsoft > 0)
> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_OFF,
> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_DISPLAY_OFF,
>                                 lps0_dsm_func_mask_microsoft, lps0_dsm_gu=
id_microsoft);
>
>         /* LPS0 entry */
> @@ -560,7 +560,7 @@ static int acpi_s2idle_prepare_late_lps0(void)
>
>         if (lps0_dsm_func_mask_microsoft > 0) {
>                 /* Modern Standby entry */
> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_ENTRY,
> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SLEEP_ENTRY,
>                                 lps0_dsm_func_mask_microsoft, lps0_dsm_gu=
id_microsoft);
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_ENTRY,
>                                 lps0_dsm_func_mask_microsoft, lps0_dsm_gu=
id_microsoft);
> @@ -613,18 +613,18 @@ static void acpi_s2idle_restore_early_lps0(void)
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT,
>                                 lps0_dsm_func_mask_microsoft, lps0_dsm_gu=
id_microsoft);
>                 /* Modern Standby exit */
> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SLEEP_EXIT,
>                                 lps0_dsm_func_mask_microsoft, lps0_dsm_gu=
id_microsoft);
>         }
>
>         /* Screen on */
>         if (lps0_dsm_func_mask_microsoft > 0)
> -               acpi_sleep_run_lps0_dsm(ACPI_LPS0_SCREEN_ON,
> +               acpi_sleep_run_lps0_dsm(ACPI_LPS0_DISPLAY_ON,
>                                 lps0_dsm_func_mask_microsoft, lps0_dsm_gu=
id_microsoft);
>         if (lps0_dsm_func_mask > 0)
>                 acpi_sleep_run_lps0_dsm(acpi_s2idle_vendor_amd() ?
> -                                       ACPI_LPS0_SCREEN_ON_AMD :
> -                                       ACPI_LPS0_SCREEN_ON,
> +                                       ACPI_LPS0_DISPLAY_ON_AMD :
> +                                       ACPI_LPS0_DISPLAY_ON,
>                                         lps0_dsm_func_mask, lps0_dsm_guid=
);
>  }
>
> --
> 2.52.0
>
>
>
