From: "Klaus S. Madsen" <ksm@hjernemadsen.org>
Subject: Re: new regression in 2.6.25-rc3: no keyboard/lid acpi events on thinkpad T61p
Date: Tue, 26 Feb 2008 09:54:04 +0100
Message-ID: <20080226085403.GI17932@hjernemadsen.org>
References: <8f53421d0802251119q470a79c1p31048ef136271f84@mail.gmail.com> <20080225114611.d91791f6.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1760153AbYBZIyS@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080225114611.d91791f6.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Michael S. Tsirkin" <m.s.tsirkin@gmail.com>, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <len.brown@intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Feb 25, 2008 at 11:46:11 -0800, Andrew Morton wrote:
> On Mon, 25 Feb 2008 21:19:24 +0200 "Michael S. Tsirkin" <m.s.tsirkin@gmail.com> wrote:
> 
> > On my T61p, 2.6.25-rc2 seems to get acpi events from keypresses
> > such as Fn-F4 and lid open/close, prints them in /var/log/acpid
> > and reacts accordingly (my acpi scripts suspend on lid close and Fn-F4).
> 
> You mean suspend-to-ram works correctly on your t61p?
> 
> Mine suspends, then five seconds later magically resumes itself and the
> screen is all black.
I also have a T61p, on which STR works. I haven't tried 2.6.25, but it
works with 2.6.24. Both using the suspend scripts included in Ubuntu
7.10, and with s2ram 0.8 (although I need to use --acpi_sleep 2
(s3_mode) as an option, instead of 1 (s3_bios), which is used by default
on my model).

But I'm using the NVidia module, so that most likely changes a lot of
things.  I'll see if I can find time tonight to test 2.6.25-rc3 + nv,
and report back.

-- 
Kind regards
	Klaus S. Madsen
