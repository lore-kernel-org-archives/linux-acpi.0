From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Occasional (too common) suspend problem
Date: Fri, 21 Jan 2011 17:14:25 -0800
Message-ID: <AANLkTikv55eQfNaCGLm-2pA3Ndyi9ZEzb4xn64D3u0ww@mail.gmail.com>
References: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com>
 <201101212342.01646.rjw@sisk.pl> <AANLkTi=_-bMsp1K-thY+4wUMC5wDMVT+8m=fmVEx_wqE@mail.gmail.com>
 <201101220016.46227.rjw@sisk.pl> <AANLkTi=Tkf9MYmSmCX6CZ9Ymgqo8S1HmRkBn+Uvr2KUb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58814 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750927Ab1AVBPT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Jan 2011 20:15:19 -0500
Received: from mail-iy0-f174.google.com (mail-iy0-f174.google.com [209.85.210.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p0M1El4K019383
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=FAIL)
	for <linux-acpi@vger.kernel.org>; Fri, 21 Jan 2011 17:14:47 -0800
Received: by iyj18 with SMTP id 18so2253340iyj.19
        for <linux-acpi@vger.kernel.org>; Fri, 21 Jan 2011 17:14:45 -0800 (PST)
In-Reply-To: <AANLkTi=Tkf9MYmSmCX6CZ9Ymgqo8S1HmRkBn+Uvr2KUb@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Len Brown <lenb@kernel.org>, Jeff Chua <jeff.chua.linux@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>

On Fri, Jan 21, 2011 at 4:23 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Or - and perhaps more likely - it's connected to the lid event, and
> how that interacts with user space and then eventually triggers the
> sleep event (which is quite likely - as mentioned, I think I've only
> ever seen the problem when I'm physically at the machine).

.. but with the 'test' suspend (echo core ..), the lid event is all
good too. And going back to non-testing (echo none ..), it works too.

Which really does seem to get me back to the whole "if it fails, it
seems to fail on the first suspend" thing. Don't ask me why. I have no
idea. But I just suspended that machine 100+ times using the test
thing (60 times at the gdm prompt, 60 times while logged in and with
glxgears running to verify dri/thermal interfaces), and then a couple
of times with the lid, and it all worked.

But I bet that if I rebooted the machine a few times, it would
eventually fail on the first suspend.

Some initialization issue, perhaps?

                      Linus
