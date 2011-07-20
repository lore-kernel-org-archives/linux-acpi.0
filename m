From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: linux-next: Tree for July 20 (acpi/apei/ghes)
Date: Wed, 20 Jul 2011 09:38:29 -0700
Message-ID: <20110720093829.aae2ec63.rdunlap@xenotime.net>
References: <20110720180041.5774ca335e6697c17374dca5@canb.auug.org.au>
	<20110720093633.ca9cf794.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20110720093633.ca9cf794.rdunlap@xenotime.net>
Sender: linux-next-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 20 Jul 2011 09:36:33 -0700 Randy Dunlap wrote:

> On Wed, 20 Jul 2011 18:00:41 +1000 Stephen Rothwell wrote:
> 
> > Hi all,
> 
> On i386 (X86_32):
> 
> drivers/acpi/apei/ghes.c:542: warning: integer overflow in expression
> drivers/acpi/apei/ghes.c:619: warning: integer overflow in expression
> 
> ghes.c:(.text+0x46289): undefined reference to `__udivdi3'
>   in function ghes_estatus_cache_add().

That's on:
		period = duration / (count + 1);

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
