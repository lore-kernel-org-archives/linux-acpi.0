Received: from relay13.grserver.gr (relay13.grserver.gr [178.156.171.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CEE2848BB
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 20:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.156.171.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769544369; cv=none; b=Cl3k9NA1FeUfxi1ABZHPWwo+Rz4niiMiNd3KEF58Bjv7POCdxRzXLhqrUEQhXpoCEbq/0sRHuxZzNY1jJey0VmKJw8khvkgklcuY6Wg1Sp0XA0OTqdPh0DO8luhBKSFCo/FZVCZI1LniZ/3241tT7Ims+PLGqNoQsh0b/PgVP0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769544369; c=relaxed/simple;
	bh=xppYAdaAcvAgDOSFr90fE6IKilEGwyIvxqIzNi5BKCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ObDs9NGZ3PoHRwEvc3kJqE0cKSfpDCvTo3FXart8pwc0jdiXPfSepX+4WOhyWFtFIgXs8wuyHqIs2IST5dD3pqLa8ofNFLBPJW6vzIMJI9tOPFHng9CppGIDC/jJJlqqJUB9/UVFV+MqAqnmuZrXd3yqkMYnJXQ3AuUncmAMmkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=BkRLN/bF; arc=none smtp.client-ip=178.156.171.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="BkRLN/bF"
Received: from relay13 (localhost [127.0.0.1])
	by relay13.grserver.gr (Proxmox) with ESMTP id 02CF75E6D1
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 22:06:00 +0200 (EET)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay13.grserver.gr (Proxmox) with ESMTPS id EE1405E56C
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 22:05:58 +0200 (EET)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id ED0461FD951
	for <linux-acpi@vger.kernel.org>; Tue, 27 Jan 2026 22:05:57 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1769544358;
	bh=uKuXbRGavKVT9KoOPof4nsymgDYgzNEGzRorQVy3kdw=;
	h=Received:From:Subject:To;
	b=BkRLN/bFPVCbn2CQSH6XFaEFXuhtdUAPEiOs89meR/gx3n2v2fu5zi3m8ZPL9gNmT
	 F5aH1ozwTAW6J1aX3RQJpjuiZ30H9ifEhwcRQ5a59dWX+HAjTr1zictkKvVvjV0UGa
	 vpJAgjd6uxQhl6RUC9jg7sW6imuJZjNj1Rc51aK4KHKqJp90JcuGuBYDPGY1YQvGFC
	 o0kJie+/41pdPpGhFkMia3o6i9lnSAcv7L+iO2G/iqauNH7cRio1/QQ9i+DYOQ3NOz
	 zFpDvwdlvlcS16WmgCJ1yisjwNgZHTpasPaPHq6v7tonYV7qGc2++g/eYMbCKGK4Y3
	 R29DVX43aPiBw==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.167.50) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lf1-f50.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-lf1-f50.google.com with SMTP id
 2adb3069b0e04-59b6c13b68dso166807e87.0
        for <linux-acpi@vger.kernel.org>;
 Tue, 27 Jan 2026 12:05:57 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXVZKFTZz+pkUB8jBe+upYVm0cFBrq/AHnEIuezBsB002FPd3+3YSZtHLIGPdQwCw6aEVFYridawh38@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ulwFihoqC29/jpZyPKyFVuDh+fs/L1KJwAkqqAp2oh4JoaPy
	HL0KrdyypWJ7VSGnHc2Mk9RiUzheMagWEa/a0kcYCrGFzpUueWXkCkti3d3rWfricWdt/x0RH/q
	VQD6/mhBikUFqm8r146bMpxcBvMsCoCk=
X-Received: by 2002:a05:6512:3505:b0:59e:5b8:ab23 with SMTP id
 2adb3069b0e04-59e05b8ae19mr658098e87.4.1769544357424; Tue, 27 Jan 2026
 12:05:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127200121.1292216-1-riemenschneiderjakob@gmail.com>
In-Reply-To: <20260127200121.1292216-1-riemenschneiderjakob@gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 27 Jan 2026 21:05:45 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwHdsJ8RJNMA6QsU0M2KpB0+a+sttH=1Kx5Ecf1jOjF9DQ@mail.gmail.com>
X-Gm-Features: AZwV_Qh_p05slu8otrsIgn8TgNtu9-bT_Voo_Q4wOb9PyKakLLH2n7VRnEX4Muo
Message-ID: 
 <CAGwozwHdsJ8RJNMA6QsU0M2KpB0+a+sttH=1Kx5Ecf1jOjF9DQ@mail.gmail.com>
Subject: Re: [PATCH v2] ACPI: x86: s2idle: Invoke Microsoft _DSM Function 9
 (Turn On Display)
To: Jakob Riemenschneider <riemenschneiderjakob@gmail.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
 linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, Antheas Kapenekakis <antheas@antheas.dev>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <176954435816.2986288.10025098337520096852@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Tue, 27 Jan 2026 at 21:01, Jakob Riemenschneider
<riemenschneiderjakob@gmail.com> wrote:
>
> Windows 11, version 22H2 introduced a new function index (Function 9) to
> the Microsoft LPS0 _DSM, titled "Turn On Display Notification".
>
> According to Microsoft documentation, this function signals to the system
> firmware that the OS intends to turn on the display when exiting Modern
> Standby. This allows the firmware to release Power Limits (PLx) earlier.
>
> Crucially, this patch fixes a functional issue observed on the Lenovo Yoga
> Slim 7i Aura (15ILL9), where system fans and keyboard backlights fail to
> resume after suspend. Investigation linked shows the EC on this device
> turns off these components during sleep but requires the Function 9
> notification to wake them up again.
>
> This patch defines the new function index (ACPI_MS_TURN_ON_DISPLAY) and
> invokes it in acpi_s2idle_restore_early_lps0(). The execution order is
> updated to match the logic of an "intent" signal:
>
> 1. LPS0 Exit (Function 6)
> 2. Turn On Display Intent (Function 9)
> 3. Modern Standby Exit (Function 8)
> 4. Screen On (Function 4)
>
> Invoking Function 9 before the Modern Standby Exit ensures the firmware
> has time to restore power rails and functionality (like fans) before the
> software fully exits the sleep state.
>
> Link: https://learn.microsoft.com/en-us/windows-hardware/design/device-experiences/modern-standby-firmware-notifications#turn-on-display-notification-function-9
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=220505
> Suggested-by: Antheas Kapenekakis <antheas@antheas.dev>

LGTM, no need for rby, sby covers it.

Consider closes + reported by from bugzilla if there is a V3, I
typically use lkml@antheas.dev but that is small.

I will defer to Rafael now

Best,
Antheas

> Signed-off-by: Jakob Riemenschneider <riemenschneiderjakob@gmail.com>
> ---
> v2:
>  - Renamed constant from ACPI_LPS0_MS_DISPLAY_ON to ACPI_MS_TURN_ON_DISPLAY per feedback.
>  - Moved the Function 9 call to occur before MS Exit (Function 8) to act as an intent signal.
>
>  drivers/acpi/x86/s2idle.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> index 6d4d06236..de94b57f7 100644
> --- a/drivers/acpi/x86/s2idle.c
> +++ b/drivers/acpi/x86/s2idle.c
> @@ -45,6 +45,7 @@ static const struct acpi_device_id lps0_device_ids[] = {
>  #define ACPI_LPS0_EXIT         6
>  #define ACPI_LPS0_MS_ENTRY      7
>  #define ACPI_LPS0_MS_EXIT       8
> +#define ACPI_MS_TURN_ON_DISPLAY 9
>
>  /* AMD */
>  #define ACPI_LPS0_DSM_UUID_AMD      "e3f32452-febc-43ce-9039-932122d37721"
> @@ -352,6 +353,8 @@ static const char *acpi_sleep_dsm_state_to_str(unsigned int state)
>                         return "lps0 ms entry";
>                 case ACPI_LPS0_MS_EXIT:
>                         return "lps0 ms exit";
> +               case ACPI_MS_TURN_ON_DISPLAY:
> +                       return "lps0 ms turn on display";
>                 }
>         } else {
>                 switch (state) {
> @@ -612,6 +615,9 @@ static void acpi_s2idle_restore_early_lps0(void)
>         if (lps0_dsm_func_mask_microsoft > 0) {
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_EXIT,
>                                 lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
> +               /* Intent to turn on display */
> +               acpi_sleep_run_lps0_dsm(ACPI_MS_TURN_ON_DISPLAY,
> +                               lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
>                 /* Modern Standby exit */
>                 acpi_sleep_run_lps0_dsm(ACPI_LPS0_MS_EXIT,
>                                 lps0_dsm_func_mask_microsoft, lps0_dsm_guid_microsoft);
> --
> 2.52.0
>
>

