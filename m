From: Jeff Chua <jeff.chua.linux@gmail.com>
Subject: Re: Occasional (too common) suspend problem
Date: Sun, 23 Jan 2011 01:13:04 +0800
Message-ID: <AANLkTi=oHRzcK1KFSSziwXdJ1NJyt9oEyyCFDMY4KHc5@mail.gmail.com>
References: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com>
	<AANLkTi=Tkf9MYmSmCX6CZ9Ymgqo8S1HmRkBn+Uvr2KUb@mail.gmail.com>
	<AANLkTikv55eQfNaCGLm-2pA3Ndyi9ZEzb4xn64D3u0ww@mail.gmail.com>
	<201101221110.17786.rjw@sisk.pl>
	<AANLkTik2sUJb9G5sA_Zr9_Q1=rJdYkgRe-MgTb0zhwc2@mail.gmail.com>
	<AANLkTikJVFEOgD_i+ghFupJksy2X_G1outhMmhPbP1Yd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iw0-f174.google.com ([209.85.214.174]:63935 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751724Ab1AVRNG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 22 Jan 2011 12:13:06 -0500
Received: by iwn9 with SMTP id 9so2701407iwn.19
        for <linux-acpi@vger.kernel.org>; Sat, 22 Jan 2011 09:13:04 -0800 (PST)
In-Reply-To: <AANLkTikJVFEOgD_i+ghFupJksy2X_G1outhMmhPbP1Yd@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Chris Wilson <chris@chris-wilson.co.uk>, Jesse Barnes <jbarnes@virtuousgeek.org>, Dave Airlie <airlied@linux.ie>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>

On Sun, Jan 23, 2011 at 12:27 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sat, Jan 22, 2011 at 7:11 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Hmm. I can certainly believe in the "BIOS is confused" idea, but I
>> don't see where that gets us.
>
> So, trying to get some more hints in what is going on, I started
> getting creative, and I have a few more clues, I think.

How many CPUs do you have? If more than one, try switching offline all
/sys/devices/system/cpu/cpu*/online before suspend.

I'm getting 1/2 working suspend-to-disk, but now with offline all the
rest of the CPUs, it seems to not hang anymore.

Jeff
