From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Re: Backlight device class redesign
Date: Sun, 29 Nov 2009 22:51:31 +0100
Message-ID: <b170af450911291351r443e355fraf1828dc1163e9e3@mail.gmail.com>
References: <b170af450911271630k63fb857auf8314cecd6219eba@mail.gmail.com>
	 <b170af450911291209o33ebfc36n850826e54096f3b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ew0-f215.google.com ([209.85.219.215]:36670 "EHLO
	mail-ew0-f215.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425AbZK2Vv0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 29 Nov 2009 16:51:26 -0500
In-Reply-To: <b170af450911291209o33ebfc36n850826e54096f3b4@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Richard Purdie <rpurdie@rpsys.net>

W dniu 29 listopada 2009 21:09 u=C5=BCytkownik Rafa=C5=82 Mi=C5=82ecki
<zajec5@gmail.com> napisa=C5=82:
> So I think we have to register every device and just keep symlink
> /sys/class/backlight/display_name pointing best device. We could
> register devices in
> 1) /sys/class/backlight/.devicename (hidden)
> 2) some /sys/class/internal-usage/devicename
>
> Do you agree on this?

Please, see attached patch. TODO:
1) Add METHOD (enum { ACPI, GPU, PLATFORM} ) as
backlight_device_register parameter
2) Add display name as backlight_device_register parameter
3) Use given METHODs in backlight_best_device
4) Fix symlinks to be created in /sys/class/backlight/ instead of
/sys/dev/char/ (how?!)

What about proposed solution?

--=20
Rafa=C5=82
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
