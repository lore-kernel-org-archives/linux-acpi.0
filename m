From: Len Brown <lenb@kernel.org>
Subject: Re: [patch][rfc] acpi: do not use kmem caches
Date: Mon, 01 Dec 2008 12:53:04 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812011241080.3197@localhost.localdomain>
References: <20081201083128.GB2529@wotan.suse.de>
 <84144f020812010318v205579ean57edecf7992ec7ef@mail.gmail.com>
 <20081201120002.GB10790@wotan.suse.de> <4933E2C3.4020400@gmail.com>
 <1228138641.14439.18.camel@penberg-laptop> <4933EE8A.2010007@gmail.com>
 <20081201161404.GE10790@wotan.suse.de> <4934149A.4020604@gmail.com>
 <20081201172044.GB14074@infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:55504 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751565AbYLARxH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Dec 2008 12:53:07 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KB7004E3LMOVTZ8@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Mon, 01 Dec 2008 11:52:01 -0600 (CST)
In-reply-to: <20081201172044.GB14074@infradead.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: Alexey Starikovskiy <aystarik@gmail.com>, Nick Piggin <npiggin@suse.de>, Pekka Enberg <penberg@cs.helsinki.fi>, Linux Memory Management List <linux-mm@kvack.org>, linux-acpi@vger.kernel.org


> Or at least stop arguing and throwing bureaucratic stones in the way of
> those wanting to sort out this mess.

I think we all would be better served if there were more facts
and fewer insults on this thread, can we do that please?

I do not think the extra work we need to do for ACPICA changes
are a significant hurdle here. We will do what is best for Linux --
which is what we though we were doing when we changed ACPICA
so Linux could use native caching in the first place.

The only question that should be on the table here is how
to make Linux be the best it can be.

thanks,
-Len


