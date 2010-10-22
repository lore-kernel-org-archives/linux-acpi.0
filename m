From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 0/9] ACPI, APEI patches for 2.6.37
Date: Fri, 22 Oct 2010 13:57:56 +0200
Message-ID: <20101022115756.GD10456@basil.fritz.box>
References: <1287538620-7442-1-git-send-email-ying.huang@intel.com>
 <alpine.LFD.2.00.1010220147560.27300@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1010220147560.27300@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Huang Ying <ying.huang@intel.com>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Oct 22, 2010 at 01:50:08AM -0400, Len Brown wrote:
> On Wed, 20 Oct 2010, Huang Ying wrote:
> 
> > [PATCH 2/9] Add lock-less version of bitmap_set/clear
> > [PATCH 3/9] lock-less NULL terminated single list implementation
> > [PATCH 4/9] lock-less general memory allocator
> 
> What kinds of tests has this lockless lib code been subject to?
> This is generic code, does it play on multiple architectures?

cmpxchg is universal these days, so it should be ok everywhere.

-Andi
-- 
ak@linux.intel.com -- Speaking for myself only.
