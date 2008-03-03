From: Adrian Bunk <bunk@kernel.org>
Subject: Re: [2.6 patch] acpi/battery.c: make 2 functions static
Date: Mon, 3 Mar 2008 17:01:01 +0200
Message-ID: <20080303150101.GB26072@cs181133002.pp.htv.fi>
References: <20080303091714.GA18250@elte.hu> <20080303093103.GA23651@uranus.ravnborg.org> <20080303103933.GC21190@elte.hu> <20080303113451.GF4457@cs181133002.pp.htv.fi> <20080303114533.GA4183@elte.hu> <20080303120211.GG4457@cs181133002.pp.htv.fi> <20080303121015.GA12660@elte.hu> <20080303122953.GH4457@cs181133002.pp.htv.fi> <20080303125027.GA21577@elte.hu> <20080303145413.GA26072@cs181133002.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757901AbYCCPCu@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080303145413.GA26072@cs181133002.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Ingo Molnar <mingo@elte.hu>, Sam Ravnborg <sam@ravnborg.org>, Alexey Starikovskiy <aystarik@gmail.com>, lenb@kernel.org, astarikovskiy@suse.de, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Mar 03, 2008 at 04:54:13PM +0200, Adrian Bunk wrote:
> On Mon, Mar 03, 2008 at 01:50:27PM +0100, Ingo Molnar wrote:
> > 
> > * Adrian Bunk <bunk@kernel.org> wrote:
> > 
> > > I can only repeat that I did state several times on linux-kernel that 
> > > it never worked.
> > > 
> > > If you consider it my fault that noone reads my emails then you are 
> > > right that it's my fault...
> > 
> > well, i'm trying to assume the best, so please explain the following 
> > sequence of events to me:
> > 
> > 1) as you said you knew about this bug - which bug causes more inlining
> >    overhead than hundreds of your uninlining patches combined. The bug
> >    was introduced ~2 years ago in -mm - before the feature hit mainline
> >    in v2.6.16.
> 
> I don't remember having ever said this.
> 
> Your choices are:
> [ ] prove your accusation that I said I
>     "knew about this bug before the feature hit mainline"
> [ ] apologize
> [ ] be the firest person ever in my killfile
>...

s/firest/first/

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
