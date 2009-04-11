From: Len Brown <lenb@kernel.org>
Subject: Re: [linux-pm] [2.6.30-rc1-git2 regressions] Hibernation broken and
 (minor but annoying) audio problem
Date: Fri, 10 Apr 2009 22:35:35 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904102233330.8559@localhost.localdomain>
References: <200904100057.43827.rjw@sisk.pl>
 <alpine.LFD.2.00.0904091605080.4583@localhost.localdomain>
 <200904101439.43480.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1756237AbZDKCgR@vger.kernel.org>
In-reply-to: <200904101439.43480.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

fastboot also causes the S3 regression here:

http://bugzilla.kernel.org/show_bug.cgi?id=12936
