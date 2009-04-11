From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [linux-pm] [2.6.30-rc1-git2 regressions] Hibernation broken and
 (minor but annoying) audio problem
Date: Sat, 11 Apr 2009 12:16:23 -0700
Message-ID: <49E0EC87.9080808@linux.intel.com>
References: <200904100057.43827.rjw@sisk.pl> <alpine.LFD.2.00.0904091605080.4583@localhost.localdomain> <200904101439.43480.rjw@sisk.pl> <alpine.LFD.2.00.0904102233330.8559@localhost.localdomain> <alpine.LFD.2.00.0904111109500.4583@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:21736 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758377AbZDKTQ1 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 11 Apr 2009 15:16:27 -0400
In-Reply-To: <alpine.LFD.2.00.0904111109500.4583@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Takashi Iwai <tiwai@suse.de>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 10 Apr 2009, Len Brown wrote:
>> fastboot also causes the S3 regression here:
>>
>> http://bugzilla.kernel.org/show_bug.cgi?id=12936
> 
> Looks like the same issue. Does my one-liner fix that case too?
Now that I've been able to scan most of my mail; it looks like the one-liner should just go in.
Restricting module loading from async work to only non-blocking is not a big deal,
and it seems that userspace in various distros is really broken (and breaks on scsi already today),
but that is not something we can really fix quickly.
The sad part is that the userland is unlikely get fixed unless it shows breakage, and we can't break it (obviously).

I don't know of any good other solutions; right now it's mostly the partition scan (which is already mostly async on
scsi since a really long time, just in practice fast enough unless you have a big server).

(The __init thing in modules is separate and easy to fix, but without the other stuff being fixed there's no point)


