From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] x86/hpet: prevent boot hang when hpet=force used on old ICH
Date: Thu, 23 Apr 2009 19:05:09 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904231901570.15843@localhost.localdomain>
References: <alpine.LFD.2.00.0904222223200.21119@localhost.localdomain>
 <20090423060936.GA1917@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:42134 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755316AbZDWXFY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Apr 2009 19:05:24 -0400
In-reply-to: <20090423060936.GA1917@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: x86@kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, linux-acpi@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>

Ingo,
Thanks for the reply.

But please disregard that patch -- we've cooked up a better one
that allows ICH4M to continue to use hpet=force, even for clocksource.
(and it is an ACPI patch rather than an x86 patch:-)

However, I'll also send a 2nd patch to stop soliciting more hpet=force
users, since technically we shouldn't be encouraging the use of
this un-documented and lightly-validated hardware.

thanks,
Len Brown, Intel Open Source Technology Center
