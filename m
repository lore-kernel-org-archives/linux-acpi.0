From: Andi Kleen <andi@firstfloor.org>
Subject: Re: ACPI-related bug caused poor responsitivity (2.6.26.x line)
Date: Fri, 15 Aug 2008 04:20:11 +0200
Message-ID: <8763q3yq78.fsf@basil.nowhere.org>
References: <20080814211348.GA6268@sarge.my.own.domain.no-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:32881 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166AbYHOCUO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 Aug 2008 22:20:14 -0400
In-Reply-To: <20080814211348.GA6268@sarge.my.own.domain.no-net> (Zbigniew Baniewski's message of "Thu, 14 Aug 2008 23:13:49 +0200")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zbigniew Baniewski <zb@ispid.com.pl>
Cc: linux-acpi@vger.kernel.org

Zbigniew Baniewski <zb@ispid.com.pl> writes:


> There are so many issues reported during last 3 months, that I'm not sure,
> whether (or not) someone wrote about the problem. But few words anyway:
>
> I noticed, that using new kernels (tested 2.6.26 and 2.6.26.2), there are
> typical for ACPI-related problems troubles with responsitivity. For example:
> if I'm opening "bloated" web page using Opera, one can't move the mouse
> cursor smoothly around the screen; there is a "jitter" during the movement,
> and any output (like GKrellm's diagrams created in real time) for that 2-3
> seconds is "frozen". As I've found googling around, these are rather typical
> ACPI-related problems, and indeed: forcing "acpi=off" was the cure.

I assume you double checked that? As in you removed the option again
and the problem reappeared? And you add it again and it disappeared
again? If not do so please.

If it's checked please put a full report into http://bugzilla.kernel.org

Might be some kind of power saving issue. Does it happen when 
you boot with processor.max_cstate=1? (without acpi=off) Does it happen when you
disable CPUIDLE in the config?

Thanks

-Andi
