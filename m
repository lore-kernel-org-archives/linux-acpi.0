From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [PATCH] eeepc-laptop - switch to using sparse keymap library
Date: Sun, 20 Dec 2009 12:25:11 +0000
Message-ID: <9b2b86520912200425p48bd83fy40d7070d07d3e3b2@mail.gmail.com>
References: <20091218062454.GE21231@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:51180 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753934AbZLTMZM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 20 Dec 2009 07:25:12 -0500
Received: by bwz27 with SMTP id 27so2983817bwz.21
        for <linux-acpi@vger.kernel.org>; Sun, 20 Dec 2009 04:25:11 -0800 (PST)
In-Reply-To: <20091218062454.GE21231@core.coreip.homeip.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Corentin Chary <corentincj@iksaif.net>, acpi4asus-user@lists.sourceforge.net, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On 12/18/09, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> Switch the driver to use sparse keymap library instead of using custom
> implementation of keymap handling.
>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
> Updated to apply on acpi-test.

Thanks!  Everything seems to work except for the "brightness up" key :-).

> -	{KE_KEY, NOTIFY_BRN_MIN, KEY_BRIGHTNESSDOWN },
> -	{KE_KEY, NOTIFY_BRN_MAX, KEY_BRIGHTNESSUP },

> +	{ KE_KEY, NOTIFY_BRN_MIN,     { KEY_BRIGHTNESSDOWN } },
> +	{ KE_IGNORE, NOTIFY_BRN_MIN + 1, },
> +	{ KE_KEY, NOTIFY_BRN_MIN + 2, { KEY_BRIGHTNESSUP } },

Alan
