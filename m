From: "Huang\, Ying" <ying.huang@linux.intel.com>
Subject: Re: [PATCH] GHES: Fix cached error-status
Date: Mon, 26 Oct 2015 11:20:35 +0800
Message-ID: <87611uz56k.fsf@yhuang-dev.intel.com>
References: <20151019175554.GB3367@linux-uzut.site>
	<20151023225057.GF27292@linux-uzut.site>
	<3908561D78D1C84285E8C5FCA982C28F32B5DE60@ORSMSX114.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:20878 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752542AbbJZDUj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 25 Oct 2015 23:20:39 -0400
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F32B5DE60@ORSMSX114.amr.corp.intel.com>
	(Tony Luck's message of "Sat, 24 Oct 2015 07:05:15 +0800")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, "Huang, Ying" <ying.huang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Borislav Petkov <bp@suse.de>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hi, Tony,

"Luck, Tony" <tony.luck@intel.com> writes:
>> ping?
>
> I'm not actually sure that the code is wrong.  As you say it is a pretty strange loop.
>
> We seem to want to look at a bunch of conditions, and use "continue" to ignore
> bits until we find one that we like the look of.  Perhaps as soon as we do, we want
> to believe it to get our return value? Perhaps the code knows that we won't find
> another section that matches all the tests, so it isn't worth going around the loop
> again.
>
> Ying: You wrote this code 4 years ago. Any recollections of why it looks like it does?

Sorry for late.  I read the code again, and found the although the
original code is a little tricky, it actually works.

In ghes_estatus_caches[], for caches with same contents, the cache with
biggest (newest) cache->time_in should be the first.  So if we found one
cache with too small (old) cache->time_in, we can say there are no cache
with same contents and bigger (newer) cache->time_in, so that we can
make decision (break) earlier.

Best Regards,
Huang, Ying
