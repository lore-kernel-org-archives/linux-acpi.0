From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: on builds/randconfigs (was: [PATCH -next] thermal: depends on NET)
Date: Wed, 12 Jan 2011 09:48:44 -0800
Message-ID: <4D2DE97C.2000205@oracle.com>
References: <20101213163607.0b0a7c3a.sfr@canb.auug.org.au> <20101213112033.d0060e6c.randy.dunlap@oracle.com> <20110110090059.6f4d739d.randy.dunlap@oracle.com> <alpine.LFD.2.02.1101120008590.19140@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1101120008590.19140@x980>
Sender: linux-next-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, akpm <akpm@linux-foundation.org>, Zhang Rui <rui.zhang@intel.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Zimny Lech <napohybelskurwysynom2010@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On 01/11/11 21:18, Len Brown wrote:
>>> --- linux-next-20101213.orig/drivers/thermal/Kconfig
>>> +++ linux-next-20101213/drivers/thermal/Kconfig
>>> @@ -4,6 +4,7 @@
>>>  
>>>  menuconfig THERMAL
>>>  	tristate "Generic Thermal sysfs driver"
>>> +	depends on NET
> 
> I've added this line to the offending patch.

Thank you.

> While I agree that randconfig build testing
> is theoretically useful, in recent memory
> its results do not seem particularly relevant
> to useful configs.

Who defines useful?
"what is good for the goose is not good for the gander"

> Perhaps it would be a good idea to spend some time
> making non-useful configs impossible, and thus focus
> the testing where it will be of more benefit?

We have a plethora of kernel configs, so yes,
I'd be glad to see your efforts in that area.


Here's my take on kernel builds:

Ideally (randconfig) build testing wouldn't be needed
and developers would:

- know what kernel facilities their code uses and #include
  header files for all of them

- know what kernel configs their code uses and make their code
  depend on or select the needed config symbols

- actually read & review build output to look for errors and
  warnings in their code and not ignore them but actually fix them

- use sparse to check for other warnings

The current attitude of "if it builds, then it must be OK"
is not good.


-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
