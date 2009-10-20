From: Luca Niccoli <lultimouomo@gmail.com>
Subject: Re: [PATCH 2/2] eeepc-laptop: don't enable camera at startup if it's
	already on.
Date: Tue, 20 Oct 2009 16:31:34 +0200
Message-ID: <4e9568870910200731u3fddd1c8q86e1c6cb64d32872@mail.gmail.com>
References: <1255724567-25597-1-git-send-email-corentincj@iksaif.net>
	<1255724567-25597-2-git-send-email-corentincj@iksaif.net>
	<1255724567-25597-3-git-send-email-corentincj@iksaif.net>
	<20091020083555.GG19095@wrars-comp.wrarsdomain> <9b2b86520910200204n2089bcf1h2535e56d2ec4156e@mail.gmail.com>
	<20091020092402.GI19095@wrars-comp.wrarsdomain> <9b2b86520910200238u66af0d34v99931cf86507d5ff@mail.gmail.com>
	<20091020094143.GJ19095@wrars-comp.wrarsdomain> <9b2b86520910200719l34e96c88y739c14f0b9f339be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f218.google.com ([209.85.220.218]:48129 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751934AbZJTObu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Oct 2009 10:31:50 -0400
Received: by fxm18 with SMTP id 18so6491180fxm.37
        for <linux-acpi@vger.kernel.org>; Tue, 20 Oct 2009 07:31:54 -0700 (PDT)
In-Reply-To: <9b2b86520910200719l34e96c88y739c14f0b9f339be@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Cc: Andrey Rahmatullin <wrar@altlinux.org>, Corentin Chary <corentincj@iksaif.net>, lenb@kernel.org, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Matthew Garrett <mjg@redhat.com>, Andrew Morton <akpm@linux-foundation.org>

2009/10/20 Alan Jenkins <sourcejedi.lkml@googlemail.com>:

> I guess the argument is that it's better to waste a little power,
> rather than make life hard for people who install Linux themselves
> :-/. =A0After all these devices are mainly shipped with Windows, and =
the
> original pre-installed Linux (which hacked around this in video
> applications) is not seriously maintained. =A0The problem is that whe=
n
> the pre-installed OS uses the hack, the camera will be disabled in th=
e
> BIOS. =A0When you install a generic version of Linux without hacked
> applications, you either have eeepc-laptop enable the camera, or the
> user has to learn how to do it themself.
>
> I don't have a strong opinion myself, so long as it's fixed properly
> in the long term.

=46or the short term, I guess that distributions that ship some
eee-related package could make it include an udev rule - I'm going to
propose this in Debian.
=46or the long term:
if having blanket-enabled autosuspend is shown to rarely raise
problems, maybe a blacklist could be added in default udev rules?

Luca
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
