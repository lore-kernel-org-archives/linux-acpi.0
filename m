From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: [PATCH] Cast removal
Date: Fri, 6 Oct 2006 07:34:05 +0200 (MEST)
Message-ID: <Pine.LNX.4.61.0610060728360.12702@yvahk01.tjqt.qr>
References: <B28E9812BAF6E2498B7EC5C427F293A40114A6CB@orsmsx415.amr.corp.intel.com>
 <20061005152608.b6a7fb27.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932599AbWJFFie@vger.kernel.org>
In-Reply-To: <20061005152608.b6a7fb27.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: "Moore, Robert" <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, "Brown, Len" <len.brown@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org


>> I find this one interesting, as we've put a number of them into the
>> ACPICA core:
>> 
>> -	(void) kmem_cache_destroy(cache);
>> +	kmem_cache_destroy(cache);
>> 
>> I believe that the point of the (void) is to prevent lint from
>> squawking, and perhaps some picky ANSI-C compilers. What is the overall
>> Linux policy on this?
>
>policy = not;
>
>But there's quite a lot of it in the tree.

So what to do? GCC does not squawk, and instead has 
__attribute__((warn_unused_result)) in case someone should be made aware 
that a certain return value really needs to be examined.

Not even the Turbo C/C++ compiler from 1990 requires either of 
from/to-void* or to-void casts.

>Actually..  kmem_cache_destroy() returns void, so any checker which complains
>about the missing cast needs a stern talking to.

Ok, so the (void) can definitely go away for functions that actually 
return void, but what for the others? I am inclined that all lints 
should be fixed, or be sort-of discarded, since linting is slowly going 
back into [at least one] compiler.


	-`J'
-- 
