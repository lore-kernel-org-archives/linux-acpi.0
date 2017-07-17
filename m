From: Lukas Wunner <lukas@wunner.de>
Subject: Re: iMac 10,1 with Ubuntu 16.04: black screen after suspend
Date: Mon, 17 Jul 2017 11:02:35 +0200
Message-ID: <20170717090235.GB3993@wunner.de>
References: <1e60811b-a8ac-017c-d350-8a40e4323870@butterbrot.org>
 <20170530105404.GA29865@wunner.de>
 <64a4829c-3141-6ff6-9369-6ca9ed0facf4@butterbrot.org>
 <20170531092145.ytc2d6shpukxziie@wunner.de>
 <CADnq5_MGWOX47tcvkfjHRxRv_eTbo_kvpVKyTpo8WGNw+xBvPA@mail.gmail.com>
 <65c88b03-45d7-d67b-2a2c-6c7047a73c80@butterbrot.org>
 <CADnq5_Mvyz1KUw26Emt8_d_XNeQ=MUqx8WF=iCxa6jagCXNCQQ@mail.gmail.com>
 <171a9895-b020-7630-b90c-d166f45e44e3@butterbrot.org>
 <CADnq5_P_H8ZZXnXOoUcxNOFece3BRyzhZh2Z3mkw53eA20KiMQ@mail.gmail.com>
 <c1ed89a5-e6a1-1903-05ee-a9dfcdb2ef61@butterbrot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout3.hostsharing.net ([176.9.242.54]:59881 "EHLO
        mailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751324AbdGQJCh (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 17 Jul 2017 05:02:37 -0400
Content-Disposition: inline
In-Reply-To: <c1ed89a5-e6a1-1903-05ee-a9dfcdb2ef61@butterbrot.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Florian Echtler <floe@butterbrot.org>
Cc: Alex Deucher <alexdeucher@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Mario Kleiner <mario.kleiner.de@gmail.com>

On Fri, Jun 02, 2017 at 06:47:07PM +0200, Florian Echtler wrote:
> Regarding the SMC, there's actually only one key that consistently seems to have
> a different value whether the display is on or off:
> 
> --- blank	2017-05-05 08:40:53.694565045 +0200
> +++ non_blank	2017-05-05 08:40:53.702565066 +0200
> @@ -143,7 +143,7 @@
>    MSWR  [ui8 ]  0 (bytes 00)
>    MVBO  [hex_]  (bytes ff ff)
>    MVDC  [bin_]  (bytes 00)
> -  MVDS  [bin_]  (bytes 08)
> +  MVDS  [bin_]  (bytes 0a)
>    MVE1  [si8 ]  (bytes 0d)
>    MVE5  [si8 ]  (bytes 0b)
>    MVHR  [flag]  (bytes 01)
> 
> However, even with my modified SmcDumpKeys.c which I can use to enable TDM, I
> cannot write to that key. Since other MV__ keys control the display, too, it
> would make sense that that is related to the display state, but it seems to be a
> read-only key :-/
> 
> Running out of ideas again... any suggestions?

Sorry for the delay Florian.  Commit 564d8a2cf3ab by Mario Kleiner (+cc)
landed in Linus' tree last week and is included in 4.13-rc1.  It is
supposed to fix black screen issues with the iMac10,1 that you're also
using, though in Mario's case they seem to occur upon boot, rather than
on suspend, still might be worth a try:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=564d8a2cf3abf16575af48bdc3e86e92ee8a617d

Thanks,

Lukas
