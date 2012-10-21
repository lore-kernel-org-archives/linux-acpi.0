From: Marcin Slusarz <marcin.slusarz@gmail.com>
Subject: Re: Linux 3.7-rc1 (nouveau_bios_score oops).
Date: Sun, 21 Oct 2012 16:49:08 +0200
Message-ID: <20121021144908.GC22587@joi.lan>
References: <1724445.dN2yMEzN6d@localhost>
 <20121020212036.GA1698@fritha.org>
 <20121020221948.GE5826@joi.lan>
 <2155889.FOmdXlva7q@localhost>
 <20121021120901.GA22587@joi.lan>
 <CA+55aFzYDY0FLGhVevqv9Gk0bnJnM4r13=JzWDO9hdySi8zFoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34743 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932073Ab2JUOsp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 21 Oct 2012 10:48:45 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFzYDY0FLGhVevqv9Gk0bnJnM4r13=JzWDO9hdySi8zFoA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Heinz Diehl <htd@fritha.org>, Martin Peres <martin.peres@labri.fr>, Heinz Diehl <htd@fancy-poultry.org>, David Airlie <airlied@linux.ie>, Ben Skeggs <bskeggs@redhat.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, =?utf-8?B?UGF3ZcWC?= Sikora <pawel.sikora@agmk.net>

On Sun, Oct 21, 2012 at 07:38:58AM -0700, Linus Torvalds wrote:
> On Sun, Oct 21, 2012 at 5:09 AM, Marcin Slusarz
> <marcin.slusarz@gmail.com> wrote:
> >
> > This looks like ACPI bug...
> 
> I'm _shocked_ to hear that firmware would be fragile.
> 
> Anyway, here's the #1 thing to keep in mind about firmware:
> 
>  - firmware is *always* buggy.

I know. But this bug is not about broken firmware. It's about Linux kernel
ACPI implementation, which (I think) wrongly interprets ACPI script.

Marcin
