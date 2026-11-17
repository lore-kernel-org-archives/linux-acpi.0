Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794916108;
	b=03pnkas42iYUky/fxbW9APBI7MZ1utjWTkS6llPAwDfiy6ztV4IYkAkZG2H+08S1S0ly
	 ovIIiACz7szZhY3XRXvmEYKxNrUIQgOJt3H2PQ8MXhYdCDBRSgrFu88imeJc32CFWEm6x
	 9CBCV8QiDHLqTmb9qIVPX+kGK5LVulYV36GSiVLkEqy2WEaoCyByk6opnk83Gi5DRlhn4
	 I80ecDFf3wxoa9ZY4lgKHk/D2rJ56DP2dJdbkXa5lGuvrD/bwvnU7myYoPY4fNRGqAReC
	 dReRO1fWbx9EP/p943I3UQVtuqk3mJPzYIWEc2RTWlH92x44I/qwSyzjsSOL1IU+6XQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794916108;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:
	 X-Forwarded-Encrypted:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=fCqZ0Zd4HVCI/jRgXBSCy8S8OFyXtFOLF3BsI1zh8Sg=;
	b=RyUwxjfMOofyeUJOouTht3eEsizXO3ZZiXOjRhnG2zY2EZNTQIV54lj889/5aVxQfDjz
	 zmeUhwVEDzOVvm/4J6Z24g/KKv9gwK9dpTjaq+0b2mr5V6Uq5kCK+E0Vtj2e60qlb2Epl
	 NcoHo2oHTxipz9USopBFAUnJLmL7hS9CDqOM1gFQuzGV8NJJV1Mv0PXCw27rWaawWIqm2
	 kz+PLSWkfzZJ6mvSxKsoEk7G5QIDpbrK6vSLX2jnwn/0JmHCuKChdzl4tC+ndk9Vz6Lqc
	 5gTYMlWc2aIln/6YQvD0gG0WpzUQedp61xrQyAbMmXqnwhiDTlE+kLF+716pLOmDb3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-m68k.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.41
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DBE606A323
	for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 11:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26DBE606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-990703f817fso3433810241.1
        for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 03:48:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794916107; x=1795520907;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fCqZ0Zd4HVCI/jRgXBSCy8S8OFyXtFOLF3BsI1zh8Sg=;
        b=CkMdYZXZQr7l+R7y4W5H3Kwef1egaI1KMpep4+7reiLTmm1zVfT5Z5FyZKl5IETEy7
         8YvfQd9sGvmGXRGXL5culhcyoAmtnjHhiEJ2VuLYOCHWMZtaHhxMtVXA5gIJs58SqRWy
         chD3a4H+lD1vhDNctZTlXMpvr4z+Z5BOelK1E2DuJRi5oySKwvhl5EmTN4vlVoqJ3bmY
         jwXC80ysl6Lc+vJcPBLi/TSuAa/5wmYPWbJtS/CfItFQNZV5TYMFEz1ES9MEe9UqSjjf
         rqKSFHeGC+yBYo76OK3s0pUbFs6d7LLv0D0ZlX/DW/IV/WWyvavqJ6vY+9sV3DIPzRtE
         eEGQ==
X-Forwarded-Encrypted: i=1; AL+hErFxX9nFLRrtOcrKVrndO0Oyyj5RiKjDhBcQhNtWaa7ZNcUmD6IwIbVIXM//TQgzlOe3xNprAP7mga0a@vger.kernel.org
X-Gm-Message-State: APuU4Z9tiOq3vpmLiW8xrsblpcN4s/EtLLTIX+6P8pCeyFeEMzfrsOgi
	c8gV9JGlVy3touCYt5XsOqy1FKLE2mNYJJV0J1v7PvuUCFMQ4RFqKnKh39SDfVVD
X-Gm-Gg: AYBFou0GPqeIdt8fu7F7f+Qf5ypEE/emRdVE2erTsbazaO7zaXu6dTulQZZyDRfl7+d
	XGziJF4rFjh8kqOq0hteFWJ36uQui1pmZyR3N3ZpSqyKZiCgCtttsumClKHYDDsl5w4XMiCA6A+
	nKT3IA1E6sWtxMXLbBTjgyWubiWy44BUfObcxF906Od7KImG1PXnMeUUXZOwrXpC199bthwNNyo
	Cnptl/lVA+q/7gHCFC0A5AuHAiUXAvAeS8VUDKKPzlM2cIVvl0HUBoxLHWLwxB68cN6xyxOx+JT
	Cj2iEzLp64G9b2z77rJVDyjylP93ADx3YKF3Z+tD5t0Ysf9dMZFWBkQISaCMZqZ7QmluOs2yXjm
	AOuKg2IK0LrHUrXwD01pRYa0fbaAKiY1QeDFdu0sZVpgEB3FtDEyXqPriE5M5LiA6QtbekHAAci
	dHsD/5k3JOCHw3j9lpxDjpbXmn9oUQEVYTiHadtdnAM8O2AA3f9JcI4VsGt5zbCRewwK5yCoDQj
	g0FxkHjUmHcUV4L5OFh57B4D45P3t+gLZt2EldZNKhk7dFhxbTO+I4jlWxi04TrYdCBDdO8ZtQP
	HjkSpO+55hrwzaLPnlGSGe2NUtmJZi+8/5sZrazgIBN1cwbuXg6fhbBRaM9tMpdySx0=
X-Received: by 2002:a05:6102:e0a:b0:7d5:c1e0:2482 with SMTP id ada2fe7eead31-7d64d69dca2mr5108720137.11.1794916105740;
        Tue, 17 Nov 2026 03:48:25 -0800 (PST)
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com. [209.85.217.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d69dfa2e66sm2188802137.3.2026.11.17.03.48.24
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 03:48:24 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id ada2fe7eead31-7d2bf046d7fso3630573137.3
        for <linux-acpi@vger.kernel.org>; Tue, 17 Nov 2026 03:48:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErF7tSuTgwQVOc06bQCwY3FgfhQWRah7JxdxOTKMPy0gy5lizDa9kp+4DZv/7sI9+vjQ/gU5FawIehJd@vger.kernel.org
X-Received: by 2002:a05:6102:578c:b0:7d2:c786:5a95 with SMTP id
 ada2fe7eead31-7d64d69dc95mr4808481137.13.1794916104363; Tue, 17 Nov 2026
 03:48:24 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261024223501.1420953-1-daniel.lezcano@oss.qualcomm.com> <20261024223501.1420953-2-daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20261024223501.1420953-2-daniel.lezcano@oss.qualcomm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Nov 2026 12:48:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXJOpcC3a6wMXF_m=uNjuqSO1Z3kyM7Az1uP_2GBurOvA@mail.gmail.com>
X-Gm-Features: Aa3M54o4xtj3bYccvEv51xwUP0A3vPBfjxtiJtpZqQUGyQco56wW9LsC221L5Po
Message-ID: <CAMuHMdXJOpcC3a6wMXF_m=uNjuqSO1Z3kyM7Az1uP_2GBurOvA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] platform profile: Extract the core from ACPI
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: rafael@kernel.org, Len Brown <lenb@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Viresh Kumar <viresh.kumar@linaro.org>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Maximilian Luz <luzmaximilian@gmail.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
	Lukasz Luba <lukasz.luba@arm.com>, Armin Wolf <W_Armin@gmx.de>, 
	Jai Luthra <jai.luthra@ideasonboard.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jack Wu <jackbb_wu@compal.com>, 
	"Mario Limonciello (AMD)" <superm1@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-pm@vger.kernel.org, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Daniel,

On Sun, 25 Oct 2026 at 00:56, Daniel Lezcano
<daniel.lezcano@oss.qualcomm.com> wrote:
> Platform profile providers already use device-based callbacks and do not
> need ACPI types. The core is nevertheless confined to the ACPI build and
> refuses to initialize when ACPI is disabled.
>
> Move the implementation to drivers/platform/profile and introduce the
> firmware-independent PLATFORM_PROFILE symbol. Update all provider
> selectors. Keep provider-specific ACPI dependencies and the
> platform_profile module name.
>
> Isolate access to the legacy ACPI kobject in an optional compatibility
> object linked into the same module. Retain the legacy ABI on active ACPI
> systems, and initialize the class even when ACPI is absent or disabled.
>
> Use subsys_initcall_sync so the class is ready before built-in thermal
> and CPUFreq providers, but after ACPI has initialized its compatibility
> kobject.
>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>

Thanks for your patch, which is now commit 699041135f75b13a
("platform profile: Extract the core from ACPI") in pm/linux-next/

> --- a/drivers/platform/Kconfig
> +++ b/drivers/platform/Kconfig
> @@ -1,4 +1,20 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> +config PLATFORM_PROFILE
> +       tristate "Platform profile support"

I guess this can be invisible (perhaps "... if COMPILE_TEST"?), as
you have updated all provider selectors?

If not, I guess this needs a "depend on X86 || COMPILE_TEST", so people
configuring kernels for different architectures do not see this option?

> +       help
> +         Provide a common sysfs interface for selecting platform power,
> +         performance and cooling profiles. Platform-specific provider drivers
> +         map their operating modes onto standard profile names, independently
> +         of the firmware interface they use.
> +
> +         The core exposes per-provider controls under /sys/class/platform-profile/.
> +         A provider driver must register before profile attributes become
> +         available. ACPI is not required; on ACPI systems the legacy system-wide
> +         interface under /sys/firmware/acpi/ is also provided.
> +
> +         To compile this as a module, choose M here: the module will be called
> +         platform_profile.
> +
>  source "drivers/platform/mips/Kconfig"
>
>  source "drivers/platform/loongarch/Kconfig"

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
