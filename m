From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: acpidmp and acpixtract
Date: Wed, 25 Jan 2006 11:39:19 -0800 (PST)
Message-ID: <Pine.LNX.4.58.0601251137360.29859@shark.he.net>
References: <5b9417770601251017i283c5279mcc14250cd4e816c9@mail.gmail.com>
 <5b9417770601251056j30f3a262n62c72e2cfb3db8e3@mail.gmail.com>
 <Pine.LNX.4.58.0601251058220.29859@shark.he.net>
 <5b9417770601251133q781a5558ib8d55d7a3e585564@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([66.160.160.81]:25541 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932143AbWAYTjY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jan 2006 14:39:24 -0500
Received: from shark.he.net ([66.160.160.2]) by xenotime.net for <linux-acpi@vger.kernel.org>; Wed, 25 Jan 2006 11:39:19 -0800
In-Reply-To: <5b9417770601251133q781a5558ib8d55d7a3e585564@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "John H." <mistamaila@gmail.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-acpi@vger.kernel.org

On Wed, 25 Jan 2006, John H. wrote:

> ok, i have it in a text file.
>
> i am trying to resolve issue of reboot on resume from suspend to ram
> on compaq 2110us/ hp nx9005.
>
> should i put the text file on this list?

How large is it?  The list probably has a message limit of
around 80KB - 100KB.  It's probably best to create a
bugzilla entry for the problem (or use an existing one)
at http://bugzilla.kernel.org .


> On 1/25/06, Randy.Dunlap <rdunlap@xenotime.net> wrote:
> > On Wed, 25 Jan 2006, John H. wrote:
> >
> > > hmm,
> > > #!/usr/bin/perl
> > > #
> > > # acpixtract - extract raw table from acpidmp output
> > > #
> > > # Example: cat mail.txt | ./acpixtract DSDT | ./acpidisasm
> > >
> > >
> > > how do i get the acpidmp output of my bios in order to use to diagnose?
> > >
> > Please use acpidump (not acpidmp).
> > acpidump is part of the pmtools package.  Grab the latest
> > pmtools package from
> >   http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/
> > or from your distro.
> >
> > >
> > > On 1/25/06, John H. <mistamaila@gmail.com> wrote:
> > > > i am trying to use acpidmp which i've compiled from cvs from sourceforge
> > > > when i run perl /usr/local/bin/acpixtract
> > > > to extract bios, it never "stops" and dumps a file.
> > > > what am i doing wrong?
> > > >
> > > -

-- 
~Randy
