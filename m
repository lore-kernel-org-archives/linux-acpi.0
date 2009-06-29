From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH, v3] eeepc-laptop: Fix build failure with HOTPLUG_PCI
	&& !SYSFS (was: [git pull request] ACPI & driver patches for
	2.6.31-rc1)
Date: Mon, 29 Jun 2009 21:34:06 +0200
Message-ID: <20090629193406.GA30774@elte.hu>
References: <alpine.LFD.2.00.0906260025380.20608@localhost.localdomain> <20090629080754.GA28336@elte.hu> <20090629081016.GA31398@elte.hu> <20090629081339.GA321@elte.hu> <alpine.LFD.2.00.0906291135550.5716@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759000AbZF2Tf2@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0906291135550.5716@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Vegard Nossum <vegard.nossum@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, "H. Peter Anvin" <hpa@zytor.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: Corentin Chary <corentincj@iksaif.net>, Randy Dunlap <randy.dunlap@oracle.com>, Matthew Garrett <mjg@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


* Len Brown <lenb@kernel.org> wrote:

> Thanks for fixing this config, Ingo.
> 
> I agree, our build system can handle "depends",
> but "select" does not deliver on what it advertises,
> making it a trap for programmers.

Hm, this portion of Kconfig is a trap in a way indeed - on the other 
hand it is also a useful tool and the simplistic approach to 
disallow select altogether is a step backwards.

IIRC either Vegard or Steve has come up with a patch series that 
improved Kconfig to warn about problem selects while still allowing 
the simple ones. That would deflect most of the bad uses while still 
allowing the good uses. Not sure what happened to that series.

	Ingo
