From: "Huang\, Ying" <ying.huang@linux.intel.com>
Subject: Re: [PATCH] GHES: Fix cached error-status
Date: Mon, 26 Oct 2015 13:43:07 +0800
Message-ID: <87oafmw5g4.fsf@yhuang-dev.intel.com>
References: <20151019175554.GB3367@linux-uzut.site>
	<20151023225057.GF27292@linux-uzut.site>
	<3908561D78D1C84285E8C5FCA982C28F32B5DE60@ORSMSX114.amr.corp.intel.com>
	<87611uz56k.fsf@yhuang-dev.intel.com>
	<20151026043021.GA9328@nazgul.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30608 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750788AbbJZFnK (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Oct 2015 01:43:10 -0400
In-Reply-To: <20151026043021.GA9328@nazgul.tnic> (Borislav Petkov's message of
	"Mon, 26 Oct 2015 05:30:21 +0100")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: "Luck, Tony" <tony.luck@intel.com>, Davidlohr Bueso <dave@stgolabs.net>, "Huang, Ying" <ying.huang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Borislav Petkov <bp@suse.de> writes:

> On Mon, Oct 26, 2015 at 11:20:35AM +0800, Huang, Ying wrote:
>> In ghes_estatus_caches[], for caches with same contents, the cache with
>> biggest (newest) cache->time_in should be the first.  So if we found one
>> cache with too small (old) cache->time_in, we can say there are no cache
>> with same contents and bigger (newer) cache->time_in, so that we can
>> make decision (break) earlier.
>
> Well, for starters, this should be documented in the code so that people
> looking at it would not need to scratch their heads over that break
> statement there.

Yes.  Will do it.

Best Regards,
Huang, Ying
