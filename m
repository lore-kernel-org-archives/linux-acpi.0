From: Andi Kleen <andi@firstfloor.org>
Subject: Re: srat: harsh hot-pluggable memory check?
Date: Fri, 11 Jan 2013 21:25:01 +0100
Message-ID: <20130111202501.GL30577@one.firstfloor.org>
References: <1357846907.7523.17.camel@buesod1.americas.hpqcorp.net> <20130110200223.GH30577@one.firstfloor.org> <1357935230.7523.32.camel@buesod1.americas.hpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:38811 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754736Ab3AKUZI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Jan 2013 15:25:08 -0500
Content-Disposition: inline
In-Reply-To: <1357935230.7523.32.camel@buesod1.americas.hpqcorp.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Davidlohr Bueso <davidlohr.bueso@hp.com>
Cc: Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, zeus@gnu.org, linux-kernel@vger.kernel.org

On Fri, Jan 11, 2013 at 12:13:50PM -0800, Davidlohr Bueso wrote:
> On Thu, 2013-01-10 at 21:02 +0100, Andi Kleen wrote:
> > > This only mentions that the system supports hot-plugging, and IMHO if the
> > > user decides not to use CONFIG_MEMORY_HOTPLUG, it shouldn't be considered an error.
> > > Therefore would it be ok to drop the check? Or am I missing something?
> > 
> > The very strict checks were originally implemented because various early
> > BIOS had largely fictional SRATs, and trusting them blindly caused
> > boot failures or a lot of wasted memory for unnecessary hotplug zones. 
> > The wasted memory was mainly a problem with the old memory hotplug
> > implementation that pre-allocated memmaps, that's not a problem anymore.
> > However there may be still some other failure cases.
> > 
> 
> Would you be willing to take a patch that drops this check then? Or do
> you see any other scenario where it would still be valid?

I don't maintain this code. 

Personally I would be vary to any changes in this area, unless you
can very clearly demonstrate that the change cannot break any old
system.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only.
