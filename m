From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Occasional (too common) suspend problem
Date: Sat, 22 Jan 2011 08:27:27 -0800
Message-ID: <AANLkTikJVFEOgD_i+ghFupJksy2X_G1outhMmhPbP1Yd@mail.gmail.com>
References: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com>
 <AANLkTi=Tkf9MYmSmCX6CZ9Ymgqo8S1HmRkBn+Uvr2KUb@mail.gmail.com>
 <AANLkTikv55eQfNaCGLm-2pA3Ndyi9ZEzb4xn64D3u0ww@mail.gmail.com>
 <201101221110.17786.rjw@sisk.pl> <AANLkTik2sUJb9G5sA_Zr9_Q1=rJdYkgRe-MgTb0zhwc2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:58777 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751144Ab1AVQ1t (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 22 Jan 2011 11:27:49 -0500
Received: from mail-iy0-f174.google.com (mail-iy0-f174.google.com [209.85.210.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p0MGRm97001935
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=FAIL)
	for <linux-acpi@vger.kernel.org>; Sat, 22 Jan 2011 08:27:48 -0800
Received: by iyj18 with SMTP id 18so2662842iyj.19
        for <linux-acpi@vger.kernel.org>; Sat, 22 Jan 2011 08:27:47 -0800 (PST)
In-Reply-To: <AANLkTik2sUJb9G5sA_Zr9_Q1=rJdYkgRe-MgTb0zhwc2@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Chris Wilson <chris@chris-wilson.co.uk>, Jesse Barnes <jbarnes@virtuousgeek.org>, Dave Airlie <airlied@linux.ie>
Cc: Len Brown <lenb@kernel.org>, Jeff Chua <jeff.chua.linux@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>

On Sat, Jan 22, 2011 at 7:11 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Hmm. I can certainly believe in the "BIOS is confused" idea, but I
> don't see where that gets us.

So, trying to get some more hints in what is going on, I started
getting creative, and I have a few more clues, I think.

First off, I think I've already noted that I don't think I get lockups
with the usual "echo mem > /sys/power/state". So I've mentioned that
maybe it's something about the lid event messing things up.

However, I figured out that I _can_ trigger the lockup from the
command line, by using "pm-suspend" instead. So while the normal
(well, normal for me, since  it's the "real kernel interface", not
normal in general) "echo mem" thing seems stable, it doesn't seem like
it's the lid event per se that confuses anything, and it seems that
it's just that the lid event uses "pm-suspend" which runs all those
hacky scripts just before suspending.

I also _think_ (and this is where it gets a bit speculative, because
my trials so far have been pretty limited) that I can work around the
problem by doing that "echo mem" suspend once, and after that the
"pm-suspend" approach works.

IOW, the whole "it fails the first time after boot" does seem to hold
true, and there seems to be some initialization issue. But the
initialization issue is apparently _triggered_ by the pm-suspend
scripts.

Personally, I'm inclined to blame the crazy fbdev/video save/restore
code, and I'm hereby adding some of the i915 people to the mix.
Because one of the main things that the pm-suspend scripts do is
things like

        local con
        for con in /sys/class/graphics/*/state; do
                [ -f $con ] || continue
                echo 1 >"${con}"
        done

etc. I disabled that particular part (all of "99video" in fedora, in
fact), but there are other strange things going on there.

Of course, it could be all the NetworkManager stuff too, and some
interaction with the network drivers. But the lockup happens with both
wired and wireless connections, so I don't think that's it.

I wonder what else differs between pm-suspend and just the final "echo
mem"? But I do wonder if some of the i915 code is getting confused by
being touched both as fbcon and then with the "real" suspend code..

                           Linus
