Received: from relay12.grserver.gr (relay12.grserver.gr [88.99.38.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95A82C15AC
	for <linux-acpi@vger.kernel.org>; Tue, 28 Apr 2026 07:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=88.99.38.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777362481; cv=none; b=Jw+f0xtUzzvy0N1NcTgguUvE5dPox61F7njhEXw1l1nHxd2shoUJ2XrZiDfHZVwuZYDaSg9b205YJAob8LyRf1Rc/uef9mswuwJZTYIIPzGLRfLKJwlXLQ1MB39KFjsZN/vas6oT4ZKWU3I3Rg2/RP1aR78a+PY0/pm9SA84y88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777362481; c=relaxed/simple;
	bh=aTQSTXxZSkK8yOxhpufhCw4jRkqRgWwyFZ4Q9SSJMWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rxkLwB1T+juWCnZ3lmE6Yoqht+T8D8faTOdDR8fAe/krem7uQ2ZDFnaF31vYUVw3ROEBteNYvygODqWey6YqR8S1kQSk8DKbm5g4m4R8GzfhkNRJLtKtWNrMcK5wpdyBdpZsY71zbpyBVX2KVVyyzHrfBC0wH5D9wyP8z0OnMSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=MXQJ1/fF; arc=none smtp.client-ip=88.99.38.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="MXQJ1/fF"
Received: from relay12 (localhost [127.0.0.1])
	by relay12.grserver.gr (Proxmox) with ESMTP id 3F49DBC215
	for <linux-acpi@vger.kernel.org>; Tue, 28 Apr 2026 10:47:51 +0300 (EEST)
Received: from linux3247.grserver.gr (linux3247.grserver.gr [213.158.90.240])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by relay12.grserver.gr (Proxmox) with ESMTPS id 74491BC204
	for <linux-acpi@vger.kernel.org>; Tue, 28 Apr 2026 10:47:50 +0300 (EEST)
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	by linux3247.grserver.gr (Postfix) with ESMTPSA id B015C1FF2A9
	for <linux-acpi@vger.kernel.org>; Tue, 28 Apr 2026 10:47:49 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1777362470;
	bh=P7F3odls/8WSVDnOEKWPufbws6BymACYTnU32UOaxxk=;
	h=Received:From:Subject:To;
	b=MXQJ1/fFMAAUImYyG1zBjx4a1rYuypFrXcMzZRmHRhqbLGighLRbBQlJG6wrH9iP5
	 nZi5bJC8FDAYK0XdxL9fiNKTVSJUdm7bPiNaHOf9KFhHpMaXK5UuCil55Rx4QbZPhD
	 3k04UAl8nYCnrPFgrfaOg8iPPTDillwTCgOQ5sEEhD8RO+3mhUeUtkVpoTfhsxriUR
	 JpdCGqTM8zmVuLMXJI8lRjt7e9ldUekTInujzEcDttPPKiHmmG+YOmckp0c5JmcHKB
	 65uRWIfts66AYEIGeW9CpdPwN7soq3rEB4ij5+MekzBncmkZ4p9E5C29xuuENWIFzo
	 4fYgnc6Q0BzJw==
Authentication-Results: linux3247.grserver.gr;
        spf=pass (sender IP is 209.85.215.176) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-pg1-f176.google.com
Received-SPF: pass (linux3247.grserver.gr: connection is authenticated)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-c7973bbc16dso7283996a12.0
        for <linux-acpi@vger.kernel.org>;
 Tue, 28 Apr 2026 00:47:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AFNElJ/3ZX6QEog3q9w97vz9YJD3dEjbLiCiBpEoxyJTpxhtNh+XNBhj8Qe41BpPcXYYBAfXFHMT2Ducwq/f@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx5bEOSC5U5UQpjMPZlfLLLQ0GmCZMn1kI/x8lo+4W/0XamMXz
	gvc4pxWeLanaKx1JKYRHWAYYmF3gtwWvvxv62CEQey47IilMfjEJAwuAqD4q4SPozBhLGCzNO7j
	AVjMhtcczQPVI2VbJjDgUBukUG3uz4F0=
X-Received: by 2002:a05:6a20:431e:b0:398:bbd6:80b9 with SMTP id
 adf61e73a8af0-3a39c0e2315mr2367229637.23.1777362467805; Tue, 28 Apr 2026
 00:47:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425215734.14116-1-lkml@antheas.dev>
 <20260425215734.14116-4-lkml@antheas.dev>
 <3841aded-9b40-4899-9b64-3fb42e077ac7@kernel.org>
In-Reply-To: <3841aded-9b40-4899-9b64-3fb42e077ac7@kernel.org>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Tue, 28 Apr 2026 09:47:35 +0200
X-Gmail-Original-Message-ID: 
 <CAGwozwF8=pojpzqsqd-J29ebLBJ3DcMDb02v_j6k7TnrFRRUHg@mail.gmail.com>
X-Gm-Features: AVHnY4JpPBW_blBFLEbwM5C3FPAZNLcldaxfTKNTWh7twvG1n-mvQv8kEoLlUj4
Message-ID: 
 <CAGwozwF8=pojpzqsqd-J29ebLBJ3DcMDb02v_j6k7TnrFRRUHg@mail.gmail.com>
Subject: Re: [RFC v2 03/10] acpi/x86: s2idle: Add support for adding a delay
 after begin MS calls
To: Mario Limonciello <superm1@kernel.org>
Cc: dmitry.osipenko@collabora.com, bob.beckett@collabora.com,
	bookeldor@gmail.com, hadess@hadess.net, jaap@haitsma.org,
	kernel@collabora.com, lennart@poettering.net, linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org, mccann@jhu.edu, rafael@kernel.org,
	richard@hughsie.com, sebastian.reichel@collabora.com,
	systemd-devel@lists.freedesktop.org, xaver.hugl@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <177736247004.2359418.6733106535850237777@linux3247.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 1.4.3 at linux3247.grserver.gr
X-Virus-Status: Clean

On Tue, 28 Apr 2026 at 03:57, Mario Limonciello <superm1@kernel.org> wrote:
>
> On 4/25/26 16:57, Antheas Kapenekakis wrote:
> > Certain platform/USB devices interact with Modern Standby firmware
> > notifications. This is particularly true with Asus, where the keyboards
> > are wired up to turn off their backlight during the Display Off
> > notification using a predetermined delay. While for Asus Keyboards this
> > does not cause an issue, it does manifest in ROG Ally devices, where the
> > controller waits for the animation to complete before saving its state.
> >
> > In Windows, this is not a problem, because there is an ample delay after
> > these calls and before LPS0, typically seconds to minutes.
> >
> > Therefore, introduce a delay quirk after these calls, to ensure affected
> > devices have time to uninitialize, and attach it to acpi_s2idle_dev_ops
> > so it can be consumed by device drivers.
> >
> > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > ---
> >   drivers/acpi/x86/s2idle.c | 11 +++++++++++
> >   include/linux/acpi.h      |  1 +
> >   2 files changed, 12 insertions(+)
> >
> > diff --git a/drivers/acpi/x86/s2idle.c b/drivers/acpi/x86/s2idle.c
> > index f5aefba8b191..8b48f999e0e9 100644
> > --- a/drivers/acpi/x86/s2idle.c
> > +++ b/drivers/acpi/x86/s2idle.c
> > @@ -16,6 +16,7 @@
> >    */
> >
> >   #include <linux/acpi.h>
> > +#include <linux/delay.h>
> >   #include <linux/device.h>
> >   #include <linux/dmi.h>
> >   #include <linux/suspend.h>
> > @@ -517,6 +518,9 @@ static struct acpi_scan_handler lps0_handler = {
> >
> >   static int acpi_s2idle_begin_lps0(void)
> >   {
> > +     struct acpi_s2idle_dev_ops *handler;
> > +     int delay = 0;
> > +
> >       if (!lps0_device_handle || sleep_no_lps0)
> >               return acpi_s2idle_begin();
> >
> > @@ -552,6 +556,13 @@ static int acpi_s2idle_begin_lps0(void)
> >                                       lps0_dsm_func_mask_microsoft,
> >                                       lps0_dsm_guid_microsoft);
> >
> > +     list_for_each_entry(handler, &lps0_s2idle_devops_head, list_node) {
> > +             if (handler->begin_delay && handler->begin_delay > delay)
> > +                     delay = handler->begin_delay;
> > +     }
> > +     if (delay > 0)
> > +             msleep(delay);
>
> Is this the correct location?  You wouldn't want it at the check callback?

This delay is meant to be added between Display Off/Sleep Entry and
suspend to allow devices that need it to settle before they are put on
D3, so it needs to go here. check() happens after suspend (they are
already on D3). So e.g. check() cannot replace it. We would need
something like a begin_check()

I will reply to the other patch with more context.

> > +
> >       return acpi_s2idle_begin();
> >   }
> >
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index 4d2f0bed7a06..a416e5c5798a 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -1154,6 +1154,7 @@ struct acpi_s2idle_dev_ops {
> >       void (*prepare)(void);
> >       void (*check)(void);
> >       void (*restore)(void);
> > +     int begin_delay;
> >   };
> >   #if defined(CONFIG_SUSPEND) && defined(CONFIG_X86)
> >   int acpi_register_lps0_dev(struct acpi_s2idle_dev_ops *arg);
>
>

