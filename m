From: Randy Dunlap <randy.dunlap@Oracle.com>
Subject: Re: on builds/randconfigs
Date: Wed, 12 Jan 2011 14:54:53 -0800
Message-ID: <4D2E313D.3040209@oracle.com>
References: <20101213163607.0b0a7c3a.sfr@canb.auug.org.au> <alpine.LFD.2.02.1101121257580.18873@x980> <20110112131800.d64c1a86.akpm@linux-foundation.org> <201101122224.54330.rjw@sisk.pl> <alpine.LFD.2.02.1101121654000.19754@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.2.02.1101121654000.19754@x980>
Sender: linux-next-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>, Zhang Rui <rui.zhang@intel.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Zimny Lech <napohybelskurwysynom2010@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On 01/12/11 13:58, Len Brown wrote:
>>> These unusable config combinations should be prevented via Kconfig. 
>>> That prevents users from selecting them, which otherwise adds to
>>> our workload and to theirs.  It also prevents false-positives
>>> during our useful randconfig testing.
>>
>> But it is kind of difficult to achieve IMhO.  For example, there are options
>> that are only SELECTed if something else is set, but randconfig doesn't seem
>> to care.

s/randconfig/kconfig/


> Kconfig select needs to be fixed so that it is not possible to
> select something if that something's dependencies are not met.
> 
> This long standing issue is independent of randconfig,
> but Randy can probably attest that a measurable portion
> of the randconfig failures are due to this bug.

Certainly.  At least now we have a kconfig warning on this class of
problem.

-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
