From: david@lang.hm
Subject: Re: CONFIG_SUSPEND? (was: Re: [GIT PATCH] ACPI patches for 2.6.23-rc1)
Date: Mon, 30 Jul 2007 21:09:33 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707302102160.6478@asgard.lang.hm>
References: <200707251238.50218.lenb@kernel.org>
 <alpine.LFD.0.999.0707280921150.3442@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707280932470.3442@woody.linux-foundation.org>
 <200707302353.19217.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:40539
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751489AbXGaEL2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 31 Jul 2007 00:11:28 -0400
In-Reply-To: <200707302353.19217.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>

On Mon, 30 Jul 2007, Len Brown wrote:

> On Saturday 28 July 2007 12:55, Linus Torvalds wrote:
>
>> So I think the real issue is that we allow that
>> "suspend_devices_and_enter()" code to be compiled without HOTPLUG_CPU in
>> the first place. It's not supposed to work that way.
>
> I don't see how CONFIG_HOTPLUG_CPU justifies its own existence.
> This e-mail thread would have never happened if it were simply included
> in CONFIG_SMP, always.
>
> I agree, of course, that ACPI should never have had to work-around
> this by selecting HOTPLUG_CPU.  But even though it is now done at
> the right layer, I don't see why PM should have to
> be bothered with selecting HOTPLUG_CPU either --
> it should just come with SMP.

why do you need hotplug just becouse you have muliple cpus? if you never 
have any intention of useing suspend and your hardware doesn't support 
hotplugging, why should you have to include the code for it?

Dvaid Lang
