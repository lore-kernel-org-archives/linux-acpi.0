From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] x86/ACPI: Make Sony Vaio Z1 series to use "reboot=pci" default
Date: Fri, 25 Oct 2013 21:44:20 +0200
Message-ID: <1537228.BaoD3UqLPA@vostro.rjw.lan>
References: <1382597377-26797-1-git-send-email-tianyu.lan@intel.com> <CA+55aFyZEZp3CSFEcxzKt0c_7Q9_juGWiqb7VH214Fjcs3wUkQ@mail.gmail.com> <1382722980.2445.13.camel@adam.happyassassin.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1382722980.2445.13.camel@adam.happyassassin.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Adam Williamson <awilliam@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@kernel.org>, Lan Tianyu <tianyu.lan@intel.com>, Matthew Garrett <mjg@redhat.com>, Peter Anvin <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Robin Holt <holt@sgi.com>, davej@fedoraproject.org, Len Brown <lenb@kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-acpi@vger.kernel.org

On Friday, October 25, 2013 10:43:00 AM Adam Williamson wrote:
> On Fri, 2013-10-25 at 18:16 +0100, Linus Torvalds wrote:
> > On Fri, Oct 25, 2013 at 5:47 PM, Adam Williamson <awilliam@redhat.com> wrote:
> > >
> > > I don't, but one comment I could add is that reboot _used_ to work okay
> > > on the Z1. And I _think_ it's worked OK since the April 2011 commit you
> > > mention (so the introduction of that didn't break it), but I can't
> > > absolutely swear to it.
> > 
> > It might be interesting to try, and if it used to work with the acpi
> > method, use bisection to see when it stopped working..
> 
> Yeah, I knew that'd be the reply :) I'll try and dig out some old kernel
> builds from Koji and see if I can at least pinpoint when it last worked,
> and if it really _was_ after the ACPI method landed.

This is a shot in the dark, but can you also please check if booting 3.12-rc6
with acpi_osi="!Windows 2012" on the affected machine makes any difference?

Rafael
