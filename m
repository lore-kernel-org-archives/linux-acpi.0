From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: mmotm 2009-01-28-02-17 uploaded - docking station issues.
Date: Sat, 31 Jan 2009 00:52:51 -0800
Message-ID: <20090131005251.56dee38e.akpm@linux-foundation.org>
References: <200901281019.n0SAJ9C6013727@imap1.linux-foundation.org>
	<20830.1233246343@turing-police.cc.vt.edu>
	<20090130210352.cf9e4d7f.akpm@linux-foundation.org>
	<4126.1233391214@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44157 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751572AbZAaIxI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 31 Jan 2009 03:53:08 -0500
In-Reply-To: <4126.1233391214@turing-police.cc.vt.edu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org, Holger Macht <hmacht@suse.de>, linux-acpi@vger.kernel.org

On Sat, 31 Jan 2009 03:40:14 -0500 Valdis.Kletnieks@vt.edu wrote:

> On Fri, 30 Jan 2009 21:03:52 PST, Andrew Morton said:
> > On Thu, 29 Jan 2009 11:25:43 -0500 Valdis.Kletnieks@vt.edu wrote:
> > 
> > > On Wed, 28 Jan 2009 02:19:09 PST, akpm@linux-foundation.org said:
> > > > The mm-of-the-moment snapshot 2009-01-28-02-17 has been uploaded to
> > > >    http://userweb.kernel.org/~akpm/mmotm/
> 
> > > % ls -l /sys/devices/platform/dock.0/docked
> > > -r--r--r-- 1 root root 4096 2009-01-29 10:49 /sys/devices/platform/dock.0/docked
> > > % cat /sys/devices/platform/dock.0/docked
> > > =F1=DEcat: write error: Bad address
> > >
> > > strace of the cat shows:
> > >
> > > open("/sys/devices/platform/dock.0/docked", O_RDONLY) = 3
> > > fstat(3, {st_mode=S_IFREG|0444, st_size=4096, ...}) = 0
> > > read(3, "\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0"..., 4096) = 1812586496
> 
> > > Under 2.6.29-rc2-mmotm0116, this would return either "0" or "1", not 4K
> > > of nulls.
> 
> > Is it due to
> >
> > acpi-dock-dont-eval-_sta-on-every-show_docked-sysfs-read.patch
> 
> Bingo. Reverting that patch and the sysfs-read-simplified.patch fixed it.
> 
> So obviously something in there doesn't agree with the innards of my laptop -
> 

urgh,
acpi-dock-dont-eval-_sta-on-every-show_docked-sysfs-read-simplification.patch
is completely wrong (return value) and the insane warning storm which
kernel builds create hid that from me.

I dropped it.
