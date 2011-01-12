From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: on builds/randconfigs (was: [PATCH -next] thermal: depends on
 NET)
Date: Wed, 12 Jan 2011 13:18:00 -0800
Message-ID: <20110112131800.d64c1a86.akpm@linux-foundation.org>
References: <20101213163607.0b0a7c3a.sfr@canb.auug.org.au>
	<20101213112033.d0060e6c.randy.dunlap@oracle.com>
	<20110110090059.6f4d739d.randy.dunlap@oracle.com>
	<alpine.LFD.2.02.1101120008590.19140@x980>
	<4D2DE97C.2000205@oracle.com>
	<alpine.LFD.2.02.1101121257580.18873@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1101121257580.18873@x980>
Sender: linux-next-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, linux-acpi@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Zhang Rui <rui.zhang@intel.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Zimny Lech <napohybelskurwysynom2010@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, 12 Jan 2011 13:35:10 -0500 (EST)
Len Brown <lenb@kernel.org> wrote:

> Do I care about the phantom configs that would be possible
> if these false dependencies were not in place.  No,
> not until somebody invents such a system,
> and may be not even then.
> 
> Is there a user out there on LKML who can dream up
> a use for one of these phantom configs and claim that
> his life will end if he'd prevented from building it?
> Sure.  Does he suffer from a total lack of perspective?
> Yes.

These unusable config combinations should be prevented via Kconfig. 
That prevents users from selecting them, which otherwise adds to
our workload and to theirs.  It also prevents false-positives
during our useful randconfig testing.
