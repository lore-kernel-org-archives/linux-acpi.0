From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [patch] x86: phase out forced inlining
Date: Tue, 04 Mar 2008 10:07:19 -0800
Message-ID: <1204654039.5698.13.camel@brick>
References: <20080301183550.GC25835@cs181133002.pp.htv.fi>
	 <20080303085720.GD15943@elte.hu>
	 <20080303091314.GC4457@cs181133002.pp.htv.fi>
	 <20080303091714.GA18250@elte.hu>
	 <20080303093103.GA23651@uranus.ravnborg.org>
	 <20080303103933.GC21190@elte.hu>
	 <20080303113451.GF4457@cs181133002.pp.htv.fi>
	 <20080303114533.GA4183@elte.hu> <20080303121335.GA15381@elte.hu>
	 <20080303145623.GA25697@uranus.ravnborg.org>
	 <20080304164605.GA16379@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ik-out-1112.google.com ([66.249.90.182]:50705 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370AbYCDSHo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Mar 2008 13:07:44 -0500
Received: by ik-out-1112.google.com with SMTP id c28so1200104ika.5
        for <linux-acpi@vger.kernel.org>; Tue, 04 Mar 2008 10:07:42 -0800 (PST)
In-Reply-To: <20080304164605.GA16379@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Sam Ravnborg <sam@ravnborg.org>, Adrian Bunk <bunk@kernel.org>, Alexey Starikovskiy <aystarik@gmail.com>, lenb@kernel.org, astarikovskiy@suse.de, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>

On Tue, 2008-03-04 at 17:46 +0100, Ingo Molnar wrote:
> * Sam Ravnborg <sam@ravnborg.org> wrote:

> i dont know why they there are so many variants, but all of them seem to 
> be used throughout the kernel:
> 
>    inline    : 25648

I'll assume this is the preferred way of saying it.

>  __inline__  : 1380

Lots of them in include/asm-*...not sure if there is a reason for this.

>  __inline    : 368

Almost all of them in drivers/scsi

Cheers,

Harvey

