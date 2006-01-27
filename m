From: "John H." <mistamaila@gmail.com>
Subject: Re: acpidmp and acpixtract
Date: Fri, 27 Jan 2006 12:32:19 -0600
Message-ID: <5b9417770601271032l716fa3a3t6bc887161b659b79@mail.gmail.com>
References: <5b9417770601251017i283c5279mcc14250cd4e816c9@mail.gmail.com>
	 <5b9417770601251056j30f3a262n62c72e2cfb3db8e3@mail.gmail.com>
	 <Pine.LNX.4.58.0601251058220.29859@shark.he.net>
	 <5b9417770601251133q781a5558ib8d55d7a3e585564@mail.gmail.com>
	 <Pine.LNX.4.58.0601251137360.29859@shark.he.net>
	 <5b9417770601251251p41d6ec98l947e0fffde6ca148@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.198]:14347 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750786AbWA0ScU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 27 Jan 2006 13:32:20 -0500
Received: by zproxy.gmail.com with SMTP id 14so679429nzn
        for <linux-acpi@vger.kernel.org>; Fri, 27 Jan 2006 10:32:19 -0800 (PST)
In-Reply-To: <5b9417770601251251p41d6ec98l947e0fffde6ca148@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>, shaohua.li@intel.com, linux-acpi@vger.kernel.org

any ideas on this?  i suspend to ram, but when i try to resume, it
reboots machine.

On 1/25/06, John H. <mistamaila@gmail.com> wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=5884
>
> On 1/25/06, Randy.Dunlap <rdunlap@xenotime.net> wrote:
> > On Wed, 25 Jan 2006, John H. wrote:
> >
> > > ok, i have it in a text file.
> > >
> > > i am trying to resolve issue of reboot on resume from suspend to ram
> > > on compaq 2110us/ hp nx9005.
> > >
> > > should i put the text file on this list?
> >
> > How large is it?  The list probably has a message limit of
> > around 80KB - 100KB.  It's probably best to create a
> > bugzilla entry for the problem (or use an existing one)
> > at http://bugzilla.kernel.org .
> >
> >
> > > On 1/25/06, Randy.Dunlap <rdunlap@xenotime.net> wrote:
> > > > On Wed, 25 Jan 2006, John H. wrote:
> > > >
> > > > > hmm,
> > > > > #!/usr/bin/perl
> > > > > #
> > > > > # acpixtract - extract raw table from acpidmp output
> > > > > #
> > > > > # Example: cat mail.txt | ./acpixtract DSDT | ./acpidisasm
> > > > >
> > > > >
> > > > > how do i get the acpidmp output of my bios in order to use to diagnose?
> > > > >
> > > > Please use acpidump (not acpidmp).
> > > > acpidump is part of the pmtools package.  Grab the latest
> > > > pmtools package from
> > > >   http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/
> > > > or from your distro.
> > > >
> > > > >
> > > > > On 1/25/06, John H. <mistamaila@gmail.com> wrote:
> > > > > > i am trying to use acpidmp which i've compiled from cvs from sourceforge
> > > > > > when i run perl /usr/local/bin/acpixtract
> > > > > > to extract bios, it never "stops" and dumps a file.
> > > > > > what am i doing wrong?
> > > > > >
> > > > > -
> >
> > --
> > ~Randy
> >
>
