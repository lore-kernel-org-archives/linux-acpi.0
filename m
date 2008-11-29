From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [RFC PATCH] x86: create drivers/x86/ from drivers/misc/
Date: Fri, 28 Nov 2008 17:00:00 -0800
Message-ID: <49309410.1060609@oracle.com>
References: <20081128213620.2ec593d4.sfr@canb.auug.org.au> <4930307C.30106@oracle.com> <20081129083550.3c23af37.sfr@canb.auug.org.au> <alpine.LFD.2.00.0811281649001.24773@localhost.localdomain> <alpine.LFD.2.00.0811281702570.24773@localhost.localdomain> <alpine.LFD.2.00.0811281706540.24773@localhost.localdomain> <20081128223533.GA5175@uranus.ravnborg.org> <alpine.LFD.2.00.0811281801520.24773@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from acsinet12.oracle.com ([141.146.126.234]:35121 "EHLO
	acsinet12.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752976AbYK2BA0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Nov 2008 20:00:26 -0500
In-Reply-To: <alpine.LFD.2.00.0811281801520.24773@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Len Brown <len.brown@intel.com>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, linux-acpi@vger.kernel.org

Len Brown wrote:
> 
>>> Move x86 platform specific drivers from drivers/misc/
>>> to a new home under drivers/x86/.
>>>
>>> The community has been maintaining x86 platform specific drivers
>>> under /drivers/misc/ for a few years.  The oldest ones started
>>> life under drivers/acpi, but got booted out because they are
>>> generally vendor-specific extensions to ACPI, or simply
>>> users of ACPI, rather than implementers of the ACPI spec.
>>>
>>> The thing that they have in common is that they are
>>> x86 vendor specific platform drivers.  So when asked,
>>> Linus suggested we move them to drivers/x86.
>> We already have 81 one directory entries under drivers/
>> and with patch you open up for an additional
>> directory for each arch - not elegant.
> 
> I followed the example of drivers/s390/,
> per Linus' suggestion.
> 
> The other place that seemed to suggest itself was
> arch/x86/drivers/, as we already have:
> 
> arch/um/drivers/
> arch/sh/drivers/
> arch/cris/*/drivers/
> 
>> As it is today (before this patch) the directories unider
>> drivers/ said what the drivers was used for - which is logical.
>>
>> But with this new arch specific directory it is no longer obvious
>> is a driver should be located under say drivers/net/* or
>> drivers/arm/* in case it is a arm specific driver.
> 
> These are vendor-specific, aka "platform specific" drivers
> for various x86 platforms.
> 
>> What is wrong with the current location under misc/*?
> 
> mostly that it "misc" means nothing at all...
> Indeed, misc should probably be deleted for this reason...

Yes, IIRC, we had eliminated drivers/misc/ at one point,
and then it came back on us.

~Randy
