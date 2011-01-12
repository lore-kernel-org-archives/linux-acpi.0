From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: on builds/randconfigs
Date: Wed, 12 Jan 2011 10:38:30 -0800
Message-ID: <4D2DF526.7090308@oracle.com>
References: <20101213163607.0b0a7c3a.sfr@canb.auug.org.au> <20101213112033.d0060e6c.randy.dunlap@oracle.com> <20110110090059.6f4d739d.randy.dunlap@oracle.com> <alpine.LFD.2.02.1101120008590.19140@x980> <4D2DE97C.2000205@oracle.com> <alpine.LFD.2.02.1101121257580.18873@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1101121257580.18873@x980>
Sender: linux-next-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, akpm <akpm@linux-foundation.org>, Zhang Rui <rui.zhang@intel.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Zimny Lech <napohybelskurwysynom2010@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On 01/12/11 10:35, Len Brown wrote:
>>> While I agree that randconfig build testing
>>> is theoretically useful, in recent memory
>>> its results do not seem particularly relevant
>>> to useful configs.
>>
>> Who defines useful?
> 
> Simple.
> 
> Configs that will be used are useful.

Then I suggest that you start deleting non-useful kernel configs.
You can begin in ACPI.

-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
