From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bug 8136] 2.6.21-rc2-mm2 won't boot
Date: Thu, 8 Mar 2007 22:33:12 +0100
Message-ID: <200703082233.13728.rjw@sisk.pl>
References: <200703062336.l26NaTZA026385@fire-2.osdl.org> <20070306161559.e0c7ee71.akpm@linux-foundation.org> <200703070132.08217.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S933351AbXCHVat@vger.kernel.org>
In-Reply-To: <200703070132.08217.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Nicolas.Mailhot@laposte.net, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "bugme-daemon@kernel-bugs.osdl.org" <bugme-daemon@bugzilla.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, 7 March 2007 01:32, Rafael J. Wysocki wrote:
> Hi,
> 
> On Wednesday, 7 March 2007 01:15, Andrew Morton wrote:
> > On Tue, 6 Mar 2007 15:36:29 -0800
> > bugme-daemon@bugzilla.kernel.org wrote:
> > 
> > > http://bugzilla.kernel.org/show_bug.cgi?id=8136
> > > 
> > 
> > Let's take this to email.
> > 
> > > 
> > > 
> > > 
> > > ------- Additional Comments From Nicolas.Mailhot@LaPoste.net  2007-03-06 15:36 -------
> > > Created an attachment (id=10631)
> > >  --> (http://bugzilla.kernel.org/attachment.cgi?id=10631&action=view)
> > > Printscreen with vesfg disabled and earlyprintk=vga
> > > 
> > 
> > So rc2-mm2 panics due to "MP-BIOS bug: 8254 timer not connected to IO-APIC" and
> > rc2-mm1 does not.
> 
> I'm observing a similar thing on my dual-core AMD64 testbed desktop.  Still,
> another dual-core AMD64 machine I have runs -rc2-mm2 just fine.
> 
> One of the differences between them is that the failing one uses gcc 4.1.0 (sigh).
> 
> > Could be ACPI, could be x86_64 timer changes, could be something else.
> > 
> > Would you have time to bisect it? 
> > http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt
> > explains how.
> > 
> > If so, I'd suggest you drill in on the patches between
> > x86_64-mm-defconfig-update.patch and
> > optimize-and-simplify-get_cycles_sync.patch: the x86 changes.
> 
> I'll try to debug it tomorrow.

OK, this seems to be fixed in 2.6.21-rc3-mm2.
