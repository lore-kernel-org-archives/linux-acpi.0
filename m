From: Michal Marek <mmarek@suse.cz>
Subject: Re: on builds/randconfigs
Date: Thu, 13 Jan 2011 13:23:06 +0100
Message-ID: <4D2EEEAA.7040200@suse.cz>
References: <20101213163607.0b0a7c3a.sfr@canb.auug.org.au> <alpine.LFD.2.02.1101121257580.18873@x980> <20110112131800.d64c1a86.akpm@linux-foundation.org> <201101122224.54330.rjw@sisk.pl> <alpine.LFD.2.02.1101121654000.19754@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor.suse.de ([195.135.220.2]:55532 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756576Ab1AMMXI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Jan 2011 07:23:08 -0500
In-Reply-To: <alpine.LFD.2.02.1101121654000.19754@x980>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <randy.dunlap@oracle.com>, linux-acpi@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Zhang Rui <rui.zhang@intel.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Zimn@jasper.es, Arnaud Lacombe <lacombar@gmail.com>, Vegard Nossum <vegard.nossum@gmail.com>

On 12.1.2011 22:58, Len Brown wrote:
>>> These unusable config combinations should be prevented via Kconfig. 
>>> That prevents users from selecting them, which otherwise adds to
>>> our workload and to theirs.  It also prevents false-positives
>>> during our useful randconfig testing.
>>
>> But it is kind of difficult to achieve IMhO.  For example, there are options
>> that are only SELECTed if something else is set, but randconfig doesn't seem
>> to care.
> 
> Kconfig select needs to be fixed so that it is not possible to
> select something if that something's dependencies are not met.

Right now, it issues a warning in such case. I think changing it to a
fatal error would be too premature, not long ago there were a couple of
annoying false positives.

But from the rest of the thread, I conclude that you actually meant "not
possible to select something if that something's dependencies CANNOT be
met", i.e. automatically select dependencies if that is possible. That
was actually one of the goals of Vegard Nossum's GSoC poject last year,
but I haven't heard of any outcome yet. Vegard, is there something we
could use, be it code or mistakes we could learn from?

Thanks,
Michal
