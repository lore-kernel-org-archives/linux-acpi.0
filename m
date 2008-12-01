From: Len Brown <lenb@kernel.org>
Subject: Re: [RFC PATCH v2] create drivers/platform/x86/ from drivers/misc/
Date: Mon, 01 Dec 2008 14:12:40 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812011405070.3197@localhost.localdomain>
References: <20081128213620.2ec593d4.sfr@canb.auug.org.au>
 <4930307C.30106@oracle.com> <20081129083550.3c23af37.sfr@canb.auug.org.au>
 <alpine.LFD.2.00.0811281649001.24773@localhost.localdomain>
 <alpine.LFD.2.00.0811281702570.24773@localhost.localdomain>
 <alpine.LFD.2.00.0811281706540.24773@localhost.localdomain>
 <20081128223533.GA5175@uranus.ravnborg.org>
 <alpine.LFD.2.00.0811281801520.24773@localhost.localdomain>
 <20081129073816.GB8351@uranus.ravnborg.org>
 <alpine.LFD.2.00.0812010053100.3314@localhost.localdomain>
 <20081201074842.GC27768@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-next-owner@vger.kernel.org>
In-reply-to: <20081201074842.GC27768@elte.hu>
Sender: linux-next-owner@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Len Brown <len.brown@intel.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>, x86@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org



> > this version does not touch arch/x86/
> 
> the problem isnt the bits that touch arch/x86/, but that we carry these 
> commits:
> 
>  fbc2a06: Merge branch 'linus' into x86/uv
>  a3d732f: x86, UV: fix redundant creation of sgi_uv
>  7d9d1f2: sgi-xp: support getting the address of a partition's reserved page
>  31de5ec: sgi-xp: define xp_partition_id and xp_region_size
>  2525789: sgi-xp: create activate and notify gru message queues
>  6c1c325: sgi-xp: define xp_expand_memprotect() and xp_restrict_memprotect()
> 
> their drivers/misc impact is significant:
> 
>  drivers/misc/sgi-gru/grufault.c  |    4 +-
>  drivers/misc/sgi-gru/gruprocfs.c |    1 -
>  drivers/misc/sgi-xp/xp.h         |    7 +-
>  drivers/misc/sgi-xp/xp_main.c    |    7 +
>  drivers/misc/sgi-xp/xp_sn2.c     |   34 +++++
>  drivers/misc/sgi-xp/xp_uv.c      |   70 +++++++++-
>  drivers/misc/sgi-xp/xpc.h        |   12 ++
>  drivers/misc/sgi-xp/xpc_sn2.c    |   15 +--
>  drivers/misc/sgi-xp/xpc_uv.c     |  290 ++++++++++++++++++++++++++++++--------
>  10 files changed, 368 insertions(+), 74 deletions(-)
>
> And we'll likely get new commits in that space.
> 
> So if this is causing conflicts in linux-next then i'd suggest for you to 
> please do this "git mv drivers/misc/ drivers/x86/" rename (with which i 
> fully agree!) right after v2.6.29-rc1 - or near the end of the -rc1 merge 
> window.

I only moved only the laptop drivers, didn't touch misc/sgi*/,
so I don't see any conflicts here.

> In any case, please keep it in a separate branch in the ACPI tree so that 
> we can reconsider the ordering of this change in the future as well - 
> should it cause problems.

sure.
Since we have no problems in linux-next now, I don't expect any at merge 
time, but we'll have eyes open for issues then.

thanks,
-Len
