From: Damien Wyart <damien.wyart@free.fr>
Subject: Re: ACPI power off regression in 2.6.23-rc8 (NOT in rc7)
Date: Tue, 25 Sep 2007 11:27:55 +0200
Message-ID: <20070925092755.GA4553@localhost.localdomain>
References: <20070925065109.GA3080@localhost.localdomain> <20070925003340.5d6dd7f4.akpm@linux-foundation.org> <46F8C880.1010006@suse.de> <64bb37e0709250208gcbdeb6do6026e138e746bde2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752481AbXIYJ2N@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <64bb37e0709250208gcbdeb6do6026e138e746bde2@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Torsten Kaiser <just.for.lkml@googlemail.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Andrew Morton <akpm@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Frans Pop <elendil@planet.nl>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hello,

> On 9/25/07, Alexey Starikovskiy <astarikovskiy@suse.de> wrote:
> > Do you have CONFIG_ACPI_SLEEP enabled in your .config?

* Torsten Kaiser <just.for.lkml@googlemail.com> [2007-09-25 11:08]:
> I'm answering that too, because I suspect that my "2.6.23-rc7-mm1 does
> not power off"-error might have the same cause.

> No, I do not have CONFIG_ACPI_SLEEP set,
> because I do not have CONFIG_PM_SLEEP set,
> because I do not want SUSPEND and/or HIBERNATION.

Same answer from my side: I do not have CONFIG_ACPI_SLEEP for the same
reason (and this worked fine without them in rc7). I do not think these
settings should have changed between rc7 and rc8.

-- 
Damien Wyart
