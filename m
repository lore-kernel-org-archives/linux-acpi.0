From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH -next] acpi utmisc: use WARN_ON() instead of warn_on_slowpath()
Date: Wed, 02 Jul 2008 22:51:52 +0200
Message-ID: <486BEA68.7000801@firstfloor.org>
References: <20080701103339.b5acc1f3.randy.dunlap@oracle.com>	<20080701131714.5093fa49.akpm@linux-foundation.org>	<23433248.1214943818230.JavaMail.oracle@acsmt302.oracle.com>	<20080701133535.f92a673c.akpm@linux-foundation.org>	<20080702112852.05f30950.randy.dunlap@oracle.com>	<486BCDDC.1000709@firstfloor.org>	<20080702121424.a3451eae.akpm@linux-foundation.org>	<486BD785.5050207@firstfloor.org>	<20080702124316.61cc76e9.akpm@linux-foundation.org>	<486BE0DA.2090108@firstfloor.org> <20080702133540.20d578cd.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:39890 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753649AbYGBUv4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Jul 2008 16:51:56 -0400
In-Reply-To: <20080702133540.20d578cd.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: randy.dunlap@oracle.com, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org

Andrew Morton wrote:
> On Wed, 02 Jul 2008 22:11:06 +0200
> Andi Kleen <andi@firstfloor.org> wrote:
> 
>> Here's a patch. Can you use that one instead of Randy's please?
>>
> 
> No.
> 
>> [bug-fallback  text/plain (593B)]
>> Supply warn_on_slow_path() even for the !CONFIG_BUG case
>>
>> Fix build problem with ACPI for !CONFIG_BUG. Noted by Randy Dunlap.
>>
>> Signed-off-by: Andi Kleen <ak@linux.intel.com>
>>
>> diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
>> index 2632328..d0d83b7 100644
>> --- a/include/asm-generic/bug.h
>> +++ b/include/asm-generic/bug.h
>> @@ -63,6 +63,9 @@ extern void warn_on_slowpath(const char *file, const int line);
>>  	unlikely(__ret_warn_on);					\
>>  })
>>  #endif
>> +
>> +static inline void warn_on_slowpath(const char *file, const int line) {}
>> +
>>  #endif
> 
> There's no reason why asm/bug.h has to even include asm-generic/bug.h. 

I checked them all and they all do.

Besides for the ACPI case we only have to care about x86 and ia64.

But all do it anyways.


> And there's no reason why an architecture which defined __WARN needs to
> define warn_on_slowpath() even if it _does_ include asm-generic/bug.h. 
> And I didn't even begin to look at what might disable
> WANT_WARN_ON_SLOWPATH.

I think warn_on_slow_path() should be a general interface.
Perhaps with a better name though.
> 
> This is all poking deep into the private internals of one particular
> implementation of this interface.

But it's in kernel/panic.c. I don't think anyone can compile
without that. So it should be always there (unless you undefine CONFIG_BUG)


> Furthermore even if it _does_ happen to work, you've gone and coupled
> the availability of this acpi debbugging feature to CONFIG_BUG, which
> seems arbitrary.

Well not defining CONFIG_BUG means "I don't care about debugging" doesn't it?
Not having (or having only crippled) ACPI debugging in that case seems reasonable

Doesn't seem that arbitrary to me.

> 
> If you really want to do it this way (and it sounds reasonable) then
> can we please do it in a less-than-totally-hacky-and-broken way?
> 
> 
> 
> For example, define a new, always-available helper function in (say)
> kernel/panic.c along the lines of
> 
> void emit_warning_message(?)(const char *msg, int line)


Ok we can just rename warn_on_slow_path() which is already there to that new name.
Would that satisfy you?

> 
> and then call that from warn_on_slowpath().  Will require that
> warn_on_slowpath become inlined so we don't get a useless extra entry
> in the backtraces all the time.
> 
> Or just use printk and dump_stack.

I think the reason for the warn_on_slowpath() is that it produces
patterns that can be detected by Arjan's kerneloops scripts.

I'm not sure manual printk/dump_stack would have the same effect.

-Andi
