From: Len Brown <lenb@kernel.org>
Subject: Re: booting "nosmp" kernel causing ACPI errors
Date: Sat, 23 Oct 2010 01:55:31 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1010230149431.29399@localhost.localdomain>
References: <4CB9D69D.60203@upmc.fr>
 <20101021162503.8511f92a.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:58138 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751513Ab0JWFzg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 23 Oct 2010 01:55:36 -0400
Received: from localhost.localdomain ([unknown] [74.104.161.234])
 by vms173011.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0LAQ00LQOB4NXJ40@vms173011.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 23 Oct 2010 00:55:36 -0500 (CDT)
In-reply-to: <20101021162503.8511f92a.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-acpi@vger.kernel.org, Bernard Pidoux <bernard.pidoux@upmc.fr>

is there a request to fix something here?

My preferred "fix" would be to delegte the "nosmp" boot option
and to make "maxcpus=0" be a synomym for "maxcpus=1".

nosmp was originally implemented to disable MPS,
which supplied both SMP, and IOAPIC support.
MPS is largely gone these days, replaced by ACPI
about 15 years ago.

It seems that when people use "nosmp" today, they expect
it to work like "maxcpus=1", but are surprised
that it effectively adds "noapic".

thanks,
Len Brown, Intel Open Source Technology Center

