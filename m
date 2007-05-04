From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Thinkpad suspend-to-disk regression
Date: Fri, 4 May 2007 22:55:27 +0200
Message-ID: <200705042255.27845.rjw@sisk.pl>
References: <3d7cf86d0704241129i23da1b9fq93876573618e9dcd@mail.gmail.com> <3d7cf86d0705040639u31cd50dcv9fa5e827d450c2be@mail.gmail.com> <3d7cf86d0705040908j1dc2c987m46accc0249c6f512@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:58296 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031565AbXEDUvE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 4 May 2007 16:51:04 -0400
In-Reply-To: <3d7cf86d0705040908j1dc2c987m46accc0249c6f512@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Guilherme Salgado <gsalgado@gmail.com>
Cc: jplatte@naasa.net, linux-acpi@vger.kernel.org

On Friday, 4 May 2007 18:08, Guilherme Salgado wrote:
> On 5/4/07, Guilherme Salgado <gsalgado@gmail.com> wrote:
> > On 5/4/07, Joerg Platte <lists@naasa.net> wrote:
> > > Am Freitag, 4. Mai 2007 schrieb Guilherme Salgado:
> > >
> > > > This is what my hibernation script does, but I did it manually hoping
> > > > that waiting a few seconds between changing /sys/power/disk and
> > > > /sys/power/state could solve the problem. Unfortunately, it didn't; I
> > > > still get no sound after resuming.
> > >
> > > I had a similar problem with a recent kernel (but not with 2.6.21-rc7) on my
> > > T40p. Sound was lost after suspend-to-disk but could be re-activated by
> > > suspending to RAM. I did not further debug this, because I'm using suspend to
> > > disk regularly. You can try to suspend to RAM to see if it helps.
> > >
> >
> > Yeah, I've heard reports that suspending to RAM brings the sound back,
> > but that's not really a solution to the problem. The last kernel I
> > tried was 2.6.21-rc4 and it has the problem; I'll pull the most recent
> > one and give it a try.
> >
> 
> Just tested and sound works fine after resuming a 2.6.21 kernel.
> 
> I just manually suspended my thinkpad twice. The first time with
> /sys/power/disk set to 'shutdown' and the second with it set to
> 'platform'. In both cases I got sound after resuming. IOW, the problem
> seems to be fixed.
> 
> Since I'd like to get this fix into Ubuntu's kernel, I guess I'll have
> to play with git bisect some more. I'd appreciate any hints as to what
> revision could have fixed this. I know for sure that it wasn't fixed
> on 2.6.21-rc4 but it's fixed in 2.6.21.

I'm afraid I can't help you much with that.

I'd probably concentrate on the ACPI-related changes and the changes related
to timers (hrtimers, NO_HZ etc.).

Greetings,
Rafael
