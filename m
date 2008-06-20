From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 32/70] ACPI: fix checkpatch.pl complaints in scan.c
Date: Fri, 20 Jun 2008 22:39:22 +0200
Message-ID: <485C157A.5080803@firstfloor.org>
References: <1213947852-10924-1-git-send-email-lenb@kernel.org>	 <ad7f0d9feee6980a3ab3ea806854f56817d1da8e.1213947350.git.len.brown@intel.com>	 <87lk0zanvo.fsf@basil.nowhere.org> <1213993974.31598.31.camel@promb-2n-dhcp368.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:46377 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932131AbYFTUj0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 16:39:26 -0400
In-Reply-To: <1213993974.31598.31.camel@promb-2n-dhcp368.eng.vmware.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akataria@vmware.com
Cc: Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Len Brown <len.brown@intel.com>

Alok Kataria wrote:
> On Fri, 2008-06-20 at 12:48 -0700, Andi Kleen wrote:
>> Len Brown <lenb@kernel.org> writes:
>>
>>> From: Alok N Kataria <akataria@vmware.com>
>>>
>>> http://bugzilla.kernel.org/show_bug.cgi?id=9772
>> This bug has nothing to do with the patch?
>>
>> "This patch fixes the return value of acpi_eject_store()"
>>
> 
> This patch fixes the checkpatch.pl complaints introduced by patch in
> comment 23 in that bug.
> Please look here for the checkpatch.pl complaints..
> http://bugzilla.kernel.org/show_bug.cgi?id=9772#c33

Well that's still not a very useful description, given that you fix
a real bug here, not just the usual checkpatch whitspace nops.

Not sure why Len also didn't fast track it. It seems to me like
something .26-worthy.

-Andi


