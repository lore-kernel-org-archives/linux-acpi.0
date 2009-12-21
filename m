From: Alan Jenkins <sourcejedi.lkml@googlemail.com>
Subject: Re: [PATCH] eeepc-laptop - switch to using sparse keymap library
Date: Mon, 21 Dec 2009 10:03:44 +0000
Message-ID: <9b2b86520912210203g4bcd08edkc40f4233b8b9744f@mail.gmail.com>
References: <20091218062454.GE21231@core.coreip.homeip.net>
	 <9b2b86520912200425p48bd83fy40d7070d07d3e3b2@mail.gmail.com>
	 <20091221052839.GA324@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:60146 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860AbZLUKDq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Dec 2009 05:03:46 -0500
Received: by bwz27 with SMTP id 27so3330054bwz.21
        for <linux-acpi@vger.kernel.org>; Mon, 21 Dec 2009 02:03:45 -0800 (PST)
In-Reply-To: <20091221052839.GA324@core.coreip.homeip.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Corentin Chary <corentincj@iksaif.net>, acpi4asus-user@lists.sourceforge.net, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On 12/21/09, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On Sun, Dec 20, 2009 at 12:25:11PM +0000, Alan Jenkins wrote:

>> Thanks!  Everything seems to work except for the "brightness up" key :-).
>>
>
> Hmm, indeed, not sure what exactly I was thinking... How about this one?
>
> --
> Dmitry
>
>
> Input: eeepc-laptop - switch to using sparse keymap library
>
> Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
> ---
>
>  drivers/platform/x86/Kconfig        |    1
>  drivers/platform/x86/eeepc-laptop.c |  186
> ++++++++++-------------------------
>  2 files changed, 52 insertions(+), 135 deletions(-)


Yes, that fixes it.


Tested-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>


Thanks
Alan
