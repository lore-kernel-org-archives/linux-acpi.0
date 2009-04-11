From: Heinz Diehl <htd@fancy-poultry.org>
Subject: Re: [linux-pm] [2.6.30-rc1-git2 regressions] Hibernation broken
	and (minor but annoying) audio problem
Date: Sat, 11 Apr 2009 21:00:37 +0200
Message-ID: <20090411190037.GA5230@fancy-poultry.org>
References: <200904100057.43827.rjw@sisk.pl> <alpine.LFD.2.00.0904091605080.4583@localhost.localdomain> <200904101439.43480.rjw@sisk.pl> <alpine.LFD.2.00.0904102233330.8559@localhost.localdomain> <alpine.LFD.2.00.0904111109500.4583@localhost.localdomain>
Reply-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758897AbZDKS6n@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0904111109500.4583@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Takashi Iwai <tiwai@suse.de>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 11.04.2009, Linus Torvalds wrote: 

[Len Brown:]
> > fastboot also causes the S3 regression here:
> > http://bugzilla.kernel.org/show_bug.cgi?id=12936
 
> Looks like the same issue. Does my one-liner fix that case too?

http://bugzilla.kernel.org/show_bug.cgi?id=13063

Your one-liner fixes this bug, too. Without the revertion mentioned in the
bugreport applied!

Regards,
Heinz.
