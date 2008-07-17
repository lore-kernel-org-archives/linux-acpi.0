From: "Ray Lee" <ray-lk@madrabbit.org>
Subject: Re: Please pull ACPI updates
Date: Thu, 17 Jul 2008 12:11:32 -0700
Message-ID: <2c0942db0807171211s39e2653fwdc50f92d9c3020d2@mail.gmail.com>
References: <20080716214516.GA10777@basil.nowhere.org>
	 <200807170011.12184.rjw@sisk.pl>
	 <200807161633.01375.jbarnes@virtuousgeek.org>
	 <487EEAEB.4050009@firstfloor.org>
	 <alpine.LFD.1.10.0807170807040.2959@woody.linux-foundation.org>
	 <alpine.LFD.1.10.0807170835320.2959@woody.linux-foundation.org>
	 <487F71E8.9050705@firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from py-out-1112.google.com ([64.233.166.179]:64426 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759034AbYGQTLe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jul 2008 15:11:34 -0400
Received: by py-out-1112.google.com with SMTP id p76so39614pyb.10
        for <linux-acpi@vger.kernel.org>; Thu, 17 Jul 2008 12:11:32 -0700 (PDT)
In-Reply-To: <487F71E8.9050705@firstfloor.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, torvalds@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, Jul 17, 2008 at 9:23 AM, Andi Kleen <andi@firstfloor.org> wrote:
> Linus Torvalds wrote:
>> But I *really* hate pulling from somebody, and seeing commit dates that
>> are from five minutes ago, and based on something that I had just pushed
>> out (which was essentially the case for this round of ACPI changes).
>>
>> That literally shows that the code was hardly tested _at_all_ in that
>> exact configuration. It may have gotten testing based on some earlier
>> kernel version, but then it very clearly got rebased (or just quilt
>> imported) on top of a totally new kernel base, and was not tested in that
>> version very much if at all.
>
> Hmm, perhaps I'm thick, but for me the only difference seems to be
> that the submitter does the merge that you would do (and safes
> himself a yelling at if it doesn't build or crashes at boot or similar...).
>
> In both  cases there's a "untested in that configuration" end configuration
> in the end, but there's nothing much that can be done against it,
> can't it?

It matters to us end-testers when we do a git bisect. If you leave the
history intact and let the merging happen at Linus' end (or, at least
at merge time), then there is a point in history of your tree that
someone (or git bisect) can check out and try, validating the patch,
and therefore fingering a failed merge.

It's the difference between having tested patches and an untested
merge, or untested new patches and an untested merge. Your point is
the end result is untested either way. The other way to look at it is
*how much* untested history ends up in the tree. In Linus' version,
just the point from the merge onward is untested. In your version,
everything is new.
