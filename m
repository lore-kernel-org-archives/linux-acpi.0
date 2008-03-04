From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [patch] x86: phase out forced inlining
Date: Tue, 04 Mar 2008 10:18:37 -0800
Message-ID: <1204654717.5698.18.camel@brick>
References: <20080301183550.GC25835@cs181133002.pp.htv.fi>
	 <20080303085720.GD15943@elte.hu>
	 <20080303091314.GC4457@cs181133002.pp.htv.fi>
	 <20080303091714.GA18250@elte.hu>
	 <20080303093103.GA23651@uranus.ravnborg.org>
	 <20080303103933.GC21190@elte.hu>
	 <20080303113451.GF4457@cs181133002.pp.htv.fi>
	 <20080303114533.GA4183@elte.hu> <20080303121335.GA15381@elte.hu>
	 <20080303145623.GA25697@uranus.ravnborg.org>
	 <20080304164605.GA16379@elte.hu> <1204654039.5698.13.camel@brick>
	 <47CD9060.9000708@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.183]:19801 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758038AbYCDSSj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Mar 2008 13:18:39 -0500
Received: by wa-out-1112.google.com with SMTP id v27so1061172wah.23
        for <linux-acpi@vger.kernel.org>; Tue, 04 Mar 2008 10:18:38 -0800 (PST)
In-Reply-To: <47CD9060.9000708@zytor.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@elte.hu>, Sam Ravnborg <sam@ravnborg.org>, Adrian Bunk <bunk@kernel.org>, Alexey Starikovskiy <aystarik@gmail.com>, lenb@kernel.org, astarikovskiy@suse.de, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, Thomas Gleixner <tglx@linutronix.de>


On Tue, 2008-03-04 at 10:09 -0800, H. Peter Anvin wrote:
> Harvey Harrison wrote:
> > On Tue, 2008-03-04 at 17:46 +0100, Ingo Molnar wrote:
> >> * Sam Ravnborg <sam@ravnborg.org> wrote:
> > 
> >> i dont know why they there are so many variants, but all of them seem to 
> >> be used throughout the kernel:
> >>
> >>    inline    : 25648
> > 
> > I'll assume this is the preferred way of saying it.
> > 
> >>  __inline__  : 1380
> > 
> > Lots of them in include/asm-*...not sure if there is a reason for this.
> > 
> 
> Preferred form for code that's exported to userspace (since gcc 
> complains with -ansi -pedantic otherwise.)
> 
> 	-hpa

