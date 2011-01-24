From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Occasional (too common) suspend problem
Date: Mon, 24 Jan 2011 17:22:05 +1000
Message-ID: <AANLkTimSv5Myv14Kys2OTgm=wH=8DFPFeeUSkEfg-+b1@mail.gmail.com>
References: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com>
 <201101222017.40389.rjw@sisk.pl> <AANLkTikSZTZ+mSWcjs2LQGOTbbKY+SAb5YEjP+GDSK0+@mail.gmail.com>
 <201101232229.49494.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51203 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751580Ab1AXHWz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Jan 2011 02:22:55 -0500
Received: from mail-iy0-f174.google.com (mail-iy0-f174.google.com [209.85.210.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p0O7MQtG023477
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=FAIL)
	for <linux-acpi@vger.kernel.org>; Sun, 23 Jan 2011 23:22:26 -0800
Received: by iyj18 with SMTP id 18so3675423iyj.19
        for <linux-acpi@vger.kernel.org>; Sun, 23 Jan 2011 23:22:25 -0800 (PST)
In-Reply-To: <201101232229.49494.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Chris Wilson <chris@chris-wilson.co.uk>, Jesse Barnes <jbarnes@virtuousgeek.org>, Dave Airlie <airlied@linux.ie>, Len Brown <lenb@kernel.org>, Jeff Chua <jeff.chua.linux@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>

On Mon, Jan 24, 2011 at 7:29 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>
> There's one more thing that may be related. =A0Apparently, we've made=
 something
> recently that's causing lots of problems with boot and poweroff for A=
sus
> machines (https://lkml.org/lkml/2011/1/23/54). =A0The Asus BIOSes evi=
dently
> don't like something we do, but I have no idea what that may be at th=
is point.

Yeah, I think there's something there. In fact, I'm getting pretty
sure of it. Because I have now twice seen the _shutdown_ end up
halting, and guess what? When I press a key, it then finishes the
shutdown.

Sound familiar?

The last thing printed is the "Disabling non-boot CPU's" thing or
whatever. I didn't take a picture, and it obviously doesn't get logged
(since it's after the processes have been killed), but it definitely
smelled like "Uhhuh, same problem as with suspend".

                   Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
