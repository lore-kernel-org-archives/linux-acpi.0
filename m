From: "Brown, Len" <len.brown@intel.com>
Subject: RE: kacpi_notify?
Date: Wed, 12 Jul 2006 19:13:44 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6F76393@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:37980 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1751021AbWGLXP5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jul 2006 19:15:57 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org, "Moore, Robert" <robert.moore@intel.com>, "Starikovskiy, Alexey Y" <alexey.y.starikovskiy@intel.com>


>>On Wed, 12 Jul 2006, Brown, Len wrote:
>>>
>>> >Likely related to bugzilla-5534
>>> 
>>> b8d35192c55fb055792ff0641408eaaec7c88988
>>
>>Well, that one certainly looks likely.
>>
>>Any reason to not just revert it? The fundamental problems that it 
>>introduces are obviously much worse than the fix.
>
>If reverting it fixes your EVO, then certainly this is what to 
>do right now.  However, as the saga in 5534 will testify, this will
make 
>other systems unhappy, so we'll have to come back quickly with an
improved patch for 5534.

Ugh, ACPICA starts depending on on acpi_os_execute() at that time,
so a simple revert will break the build -- needs to be tweaked.

I can do it, but I've got to grab something to eat now...

-Len
