From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Occasional (too common) suspend problem
Date: Mon, 24 Jan 2011 19:43:27 +1000
Message-ID: <AANLkTi=YAZxoGTyK4AQwDiBz6e9JegihLuO34cCxSR6U@mail.gmail.com>
References: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com>
 <201101222017.40389.rjw@sisk.pl> <AANLkTikSZTZ+mSWcjs2LQGOTbbKY+SAb5YEjP+GDSK0+@mail.gmail.com>
 <201101232229.49494.rjw@sisk.pl> <AANLkTimSv5Myv14Kys2OTgm=wH=8DFPFeeUSkEfg-+b1@mail.gmail.com>
 <1295856557.1866.802.camel@rui>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44014 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751255Ab1AXJoW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 24 Jan 2011 04:44:22 -0500
Received: from mail-iw0-f174.google.com (mail-iw0-f174.google.com [209.85.214.174])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p0O9hlVQ000356
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=FAIL)
	for <linux-acpi@vger.kernel.org>; Mon, 24 Jan 2011 01:43:48 -0800
Received: by iwn9 with SMTP id 9so3787732iwn.19
        for <linux-acpi@vger.kernel.org>; Mon, 24 Jan 2011 01:43:47 -0800 (PST)
In-Reply-To: <1295856557.1866.802.camel@rui>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Chris Wilson <chris@chris-wilson.co.uk>, Jesse Barnes <jbarnes@virtuousgeek.org>, Dave Airlie <airlied@linux.ie>, Len Brown <lenb@kernel.org>, Jeff Chua <jeff.chua.linux@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, "Li, Shaohua" <shaohua.li@intel.com>

On Mon, Jan 24, 2011 at 6:09 PM, Zhang Rui <rui.zhang@intel.com> wrote:
> On Mon, 2011-01-24 at 15:22 +0800, Linus Torvalds wrote:
>>
>> Yeah, I think there's something there. In fact, I'm getting pretty
>> sure of it. Because I have now twice seen the _shutdown_ end up
>> halting, and guess what? When I press a key, it then finishes the
>> shutdown.
>>
>> Sound familiar?
>>
>> The last thing printed is the "Disabling non-boot CPU's" thing or
>> whatever. I didn't take a picture, and it obviously doesn't get logged
>> (since it's after the processes have been killed), but it definitely
>> smelled like "Uhhuh, same problem as with suspend".
>>
> https://patchwork.kernel.org/patch/500501/
> does this patch help?

Ding ding ding - I think we have a winner. Five reboots with
successful suspend/resume cycles. So this may well be it.

Of course, it was flaky enough before that it's not a guarantee (it
certainly doesn't always fail), but I'm optimistic.

               Linus
