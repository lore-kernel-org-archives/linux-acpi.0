From: "Brown, Len" <len.brown@intel.com>
Subject: RE: ACPI_DOCK bug: noone cares
Date: Sun, 9 Jul 2006 18:24:07 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB6ECF9E5@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:6457 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1161194AbWGIWYK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Jul 2006 18:24:10 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: Adrian Bunk <bunk@stusta.de>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>, Dave Hansen <haveblue@us.ibm.com>, Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, gregkh@suse.de, linux-acpi@vger.kernel.org, Miles Lane <miles.lane@gmail.com>

>> >Fair enough. Reverted.
>> 
>> I disagree with this decision, and would like to know what
>> is necessary to reverse it.
>
>Mistakes happen. Fair enough. They happen all the time. This 
>time around, for the 2.6.18-rc1 thing, I had heard more than
>the usual "nobody even reacted", as Andrew had held up two
>patch-series of his because of that issue..

Dependencies happen too, and that was the case with the memhotplug
patches.  Memhotplug, PCI-hotplug, docking -- these things all
have dependencies between multiple sub-systems, and we don't
really have a good process for making things flow smoothly.
Andrew has set himself up to be the clearing house, and he is
so successful that I think that sometimes we tend to
over-use him for that purpose.

>So that makes me like it even less than usual when I'm told 
>that a problem with something I merged was apparently known
>BEFORE IT WAS MERGED.
>
>So Adrian's report on its own wouldn't have caused a revert. 
>
>> If you address me directly when you are asking me to do something,
>> that would really help me help you.
>
>As far as I can tell, you were cc'd on all of these things, along with 
>the linux-acpi mailing list.

Yes, you are right, I was cc'd.  My inbox knew about this issue
and I hadn't noticed it.  It was my mistake to assume a few days later
that the latest driver needed a patch.

So I ask you.  If I fix the Kconfig issue today, will you accept
a push that restores this driver to 2.6.18?

thanks,
-Len
