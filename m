From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: i915 backlight
Date: Fri, 2 Aug 2013 15:08:31 -0500
Message-ID: <CAMP44s3018jWPywQixcgD2UuM58oKYgs+D=aADTQvTyZqJsULA@mail.gmail.com>
References: <20130731162252.GC4724@pd.tnic>
	<CAPBO7TaPxa_13FBDE5Z=Aoa+ePPfLRH0+oWSQyEmO00xSfGqYg@mail.gmail.com>
	<CAMP44s1WMMXcGfF6Ta0CFthY3-7tkpqXEPx1iZhVU-XpS6KUWw@mail.gmail.com>
	<1544218.2BR9ul04Pj@vostro.rjw.lan>
	<CAMP44s16-_KA+3JPSzD1CrzcNCuCk4xjOvU6E=gVRxkKiAGr0Q@mail.gmail.com>
	<CAPBO7TZT3hX67aX-2aG5f2mcVqOyka2xbTPvMWvHzTG-x+UBLA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-la0-f49.google.com ([209.85.215.49]:55225 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753801Ab3HBUId (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 2 Aug 2013 16:08:33 -0400
In-Reply-To: <CAPBO7TZT3hX67aX-2aG5f2mcVqOyka2xbTPvMWvHzTG-x+UBLA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Josep Lladonosa <jlladono@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Borislav Petkov <bp@alien8.de>, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, lkml <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Fri, Aug 2, 2013 at 3:03 PM, Josep Lladonosa <jlladono@gmail.com> wrote:
> With this setup, something has happened: in xorg, when screen goes to
> screensaver and after, enters into Standby mode, when I press a key,
> it keeps black and, to recover screen, I have to adjust brightness
> manually (by increasing), as if it didn't remember previous value to
> standby mode.
>
> This was something that before didn't happen.

You mean with acpi_osi="!Windows 2012"? And when you say "before",
what do you mean?

-- 
Felipe Contreras
