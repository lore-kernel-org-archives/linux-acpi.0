From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: acpi based pci gap calculation  - v3
Date: Wed, 16 Jul 2008 17:03:11 -0700
Message-ID: <200807161703.11572.jbarnes@virtuousgeek.org>
References: <1216148382.6135.21.camel@alok-dev1> <200807160906.43632.jbarnes@virtuousgeek.org> <487E22EA.8030005@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-mail-35.bluehost.com ([69.89.18.155]:46403 "HELO
	outbound-mail-35.bluehost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1760207AbYGQAD2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Jul 2008 20:03:28 -0400
In-Reply-To: <487E22EA.8030005@linux.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@linux.intel.com>
Cc: akataria@vmware.com, Ingo Molnar <mingo@elte.hu>, "Brown, Len" <len.brown@intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, TJ <linux@tjworld.net>

On Wednesday, July 16, 2008 9:33 am Andi Kleen wrote:
> > The only problem there is that linux-next doesn't get nearly the sort of
> > testing coverage we need for this kind of change.
>
> Normally I tend to wait for one -mm release, which seems to be tested
> by a reasonable number of people. If it survives that it is good
> to be tested in Linus' tree.
>
> Just stuffing this in in literally the last minute doesn't seem
> like a good idea.

Well it's hardly last minute given that the merge window only opened a couple 
of days ago...

But beyond that, now that I've thought about it a bit more I'm not even sure 
the patch is really correct (though it works on my test machines).  Shouldn't 
we be looking at _PRS not _CRS?  And ideally we should try to find even more 
space, not less.  This patch made one of my machines lose quite a bit of 
space:

...
Allocating PCI resources starting at c0000000 (gap: bf000000:40f00000)
...
ACPI: PCI resources should start at c0000000 (gap: bf000000:31000000)
...

which is a step backwards.  With that in mind, I reverted the patch before 
asking Linus to pull; I'm hopeful we can do better though.  I'd love to never 
see "resource allocation failed" messages anymore.

Thanks,
Jesse
