From: Luca Niccoli <lultimouomo@gmail.com>
Subject: Re: [PATCH 2/2] eeepc-laptop: don't enable camera at startup if it's
	already on.
Date: Tue, 20 Oct 2009 12:06:54 +0200
Message-ID: <4e9568870910200306t6015ad6cwa2e50ef1af72b28d@mail.gmail.com>
References: <1255724567-25597-1-git-send-email-corentincj@iksaif.net>
	<1255724567-25597-2-git-send-email-corentincj@iksaif.net>
	<1255724567-25597-3-git-send-email-corentincj@iksaif.net>
	<20091020083555.GG19095@wrars-comp.wrarsdomain> <9b2b86520910200204n2089bcf1h2535e56d2ec4156e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:50119 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbZJTKHK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Oct 2009 06:07:10 -0400
Received: by fxm18 with SMTP id 18so6199603fxm.37
        for <linux-acpi@vger.kernel.org>; Tue, 20 Oct 2009 03:07:14 -0700 (PDT)
In-Reply-To: <9b2b86520910200204n2089bcf1h2535e56d2ec4156e@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Cc: Andrey Rahmatullin <wrar@altlinux.org>, Corentin Chary <corentincj@iksaif.net>, lenb@kernel.org, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Matthew Garrett <mjg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>

2009/10/20 Alan Jenkins <sourcejedi.lkml@googlemail.com>:

> So the question is why do you want to disable it? =A0Have you measure=
d
> the power consumption on the current kernel using a more comprehensiv=
e
> method than powertop?

Actually, on my eee 901, linux 2.6.31, udev 146,
I have /sys/bus/usb/drivers/uvcvideo/*:*/../power/level =3D on
If I manually set level to auto, I save 0.2W
How's that supposed to work? Is it kernel's or udev responsibility to
set the autosuspend?
Cheers,

Luca
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
