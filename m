From: "Starikovskiy, Alexey Y" <alexey.y.starikovskiy@intel.com>
Subject: RE: kacpi_notify?
Date: Thu, 13 Jul 2006 19:32:42 +0400
Message-ID: <B41635854730A14CA71C92B36EC22AAC0908FF@mssmsx411>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:25355 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030235AbWGMPdR convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 13 Jul 2006 11:33:17 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: "Brown, Len" <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org, "Moore, Robert" <robert.moore@intel.com>

>I don't think the _idea_ is crap per se, but it would at a 
>minimum need a 
>thread limit. But I think it's the wrong approach: especially 
>if you put 
>the current thread to sleep, you really don't want another 
>thread at all, 
>you are really just working around a problem that is totally 
>internal to 
>acpi (and the AML interpreter in particular).

Agree, this was meant as a temporary fix while we make 
interpreter to be able to preempt, as you suggesting later.

>
>So I think the problem really lies elsewhere, and that the 
>whole thread 
>approach was trying to paper over it. And having a limited set 
>of threads 
>is probably potentially _worse_ then what we have now.

Right now we have overheating NX and NC series of notebooks 
from HP with AMD processors (somehow Intel DSDTs do not 
use Notify from infinite While loop), plus several "kacpid uses 
100% of cpu" caused by Notify() events, which were scheduled to 
rush through the queue if the bloker exits. 

>
>Is there no way to have the AML interpreter have some state, 
>and just push 
>that current interrupted state back onto the "event queue", 
>and just start executing the new one instead?

This interpreter cannot do such tricks and if we choose to 
executer Notify() immidiately on the same stack we risk to overflow
it...

> That sounds like it should fix the _real_ 
>problem - a kind of "mini-scheduler" for ACPI events?

Yes, that will be a perfect solution, but it will require whole
interpreter rewrite, 
so will take time.

>
>		Linus
>

Thanks,
	Alex.
