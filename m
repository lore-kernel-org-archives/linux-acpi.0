From: Andi Kleen <ak@linux.intel.com>
Subject: Re: linux-next: Tree for August 14 (sysfs/acpi errors)
Date: Sat, 16 Aug 2008 05:49:55 +0200
Message-ID: <48A64E63.4000208@linux.intel.com>
References: <20080814172945.250a27f2.sfr@canb.auug.org.au> <1218854219.3629.30.camel@lgn.site> <48A64235.2030108@linux.intel.com> <200808161347.41253.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <200808161347.41253.rusty@rustcorp.com.au>
Sender: linux-next-owner@vger.kernel.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Kay Sievers <kay.sievers@vrfy.org>, Randy Dunlap <randy.dunlap@oracle.com>, Stephen Rothwell <sfr@canb.auug.org.au>, gregkh <greg@kroah.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
List-Id: linux-acpi@vger.kernel.org

Rusty Russell wrote:
> On Saturday 16 August 2008 12:57:57 Andi Kleen wrote:
>>>> Extract is:
>>>>
>>>> XXX adding modparam:'acpi.power_nocheck' 34 (ffffffff806a4cf0)
>>> ...
>>>
>>>> XXX adding modparam:'acpi.acpica_version' 45 (ffffffff806a4ea8)
>>> Two different "modules" use the same prefix, which does not work with
>>> the current logic, they need to live next to each other in the sequence
>>> of options.
>> Sequence of options being defined by link order?
> 
> Simplest fix is to shuffle Makefile.  But better is to create an acpi "module"
> so the namespacing just works, something like below.  Overriding MODULE_PREFIX
> only works for builtin code anyway.  (Which makes sense: moving a parameter
> from one module to another isn't a change we can cover up).

Can't say I like this. This is fragile. I can just this exploding the next time
again with some innocent change.

-Andi
