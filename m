From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Occasional (too common) suspend problem
Date: Sat, 22 Jan 2011 11:42:18 -0800
Message-ID: <AANLkTikSZTZ+mSWcjs2LQGOTbbKY+SAb5YEjP+GDSK0+@mail.gmail.com>
References: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com>
 <AANLkTik2sUJb9G5sA_Zr9_Q1=rJdYkgRe-MgTb0zhwc2@mail.gmail.com>
 <AANLkTikJVFEOgD_i+ghFupJksy2X_G1outhMmhPbP1Yd@mail.gmail.com> <201101222017.40389.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54764 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751284Ab1AVTnS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 22 Jan 2011 14:43:18 -0500
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p0MJge9h013445
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=FAIL)
	for <linux-acpi@vger.kernel.org>; Sat, 22 Jan 2011 11:42:40 -0800
Received: by iwn9 with SMTP id 9so2771342iwn.19
        for <linux-acpi@vger.kernel.org>; Sat, 22 Jan 2011 11:42:38 -0800 (PST)
In-Reply-To: <201101222017.40389.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Chris Wilson <chris@chris-wilson.co.uk>, Jesse Barnes <jbarnes@virtuousgeek.org>, Dave Airlie <airlied@linux.ie>, Len Brown <lenb@kernel.org>, Jeff Chua <jeff.chua.linux@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>

On Sat, Jan 22, 2011 at 11:17 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote=
:
>>
>> First off, I think I've already noted that I don't think I get locku=
ps
>> with the usual "echo mem > /sys/power/state". So I've mentioned that
>> maybe it's something about the lid event messing things up.

I take this partly back after some more testing

I do get the "have to press a key during suspend problem" with "echo
mem". But at least when I just tested, the suspend after that worked
fine - and I could do another "echo mem" suspend (which _also_ needed
a keypress).

When I then did a "pm-suspend" after that, it just locked up.

So doing "echo mem" once after boot is not a sure-fire way to make
suspend work reliably. But it does seem to work better than
"pm-suspend" does.

>> I also _think_ (and this is where it gets a bit speculative, because
>> my trials so far have been pretty limited) that I can work around th=
e
>> problem by doing that "echo mem" suspend once, and after that the
>> "pm-suspend" approach works.

Ok, so see above. It's not a work-around, but it does have slightly
different behavior.

>> I wonder what else differs between pm-suspend and just the final "ec=
ho
>> mem"? But I do wonder if some of the i915 code is getting confused b=
y
>> being touched both as fbcon and then with the "real" suspend code..
>
> Hmm. =A0If there is s2ram on your system and it's actually being used=
, it's
> better to disable it completely. =A0I'm not sure how you are supposed=
 to do
> that on Fedora, but for openSUSE it's sufficient to clear the "execut=
able" bit
> on /usr/sbin/s2ram.

There's no s2ram in my F-14 at all. And almost all of the fbcon
suspend games in the pm-suspend scripts are disabled when it notices a
kernel-modesetting setup. But the pm-suspend scripts do still end up
doing a lot of other things (like trying to switch vt's etc - but
disabling that didn't do anything for me).

One more comment: when I disable the VT switching, I end up seeing the
kernel messages during suspend, but they obviously stop at
"suspend_console()". When I use "no_console_suspend" to show mssages,
the last message I see before the machine needs a keypess is the one
where we disable the i915 IRQ.

Which probably doesn't mean anything, since it's probably just a
direct result of me saying "try to print stuff even over the suspend"
together with the i915 driver then not being able to due to not having
interrupts. So I suspect the "no_console_suspend" thing just doesn't
much help - it just results in more problems for the  suspend, and it
probably never works at all.

Annoying. So close. Yet so far.

                Linus
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
