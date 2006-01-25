From: "John H." <mistamaila@gmail.com>
Subject: Re: acpidmp and acpixtract
Date: Wed, 25 Jan 2006 13:33:57 -0600
Message-ID: <5b9417770601251133q781a5558ib8d55d7a3e585564@mail.gmail.com>
References: <5b9417770601251017i283c5279mcc14250cd4e816c9@mail.gmail.com>
	 <5b9417770601251056j30f3a262n62c72e2cfb3db8e3@mail.gmail.com>
	 <Pine.LNX.4.58.0601251058220.29859@shark.he.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.200]:18041 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932135AbWAYTd6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jan 2006 14:33:58 -0500
Received: by zproxy.gmail.com with SMTP id 14so183746nzn
        for <linux-acpi@vger.kernel.org>; Wed, 25 Jan 2006 11:33:57 -0800 (PST)
In-Reply-To: <Pine.LNX.4.58.0601251058220.29859@shark.he.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: linux-acpi@vger.kernel.org

ok, i have it in a text file.

i am trying to resolve issue of reboot on resume from suspend to ram
on compaq 2110us/ hp nx9005.

should i put the text file on this list?

On 1/25/06, Randy.Dunlap <rdunlap@xenotime.net> wrote:
> On Wed, 25 Jan 2006, John H. wrote:
>
> > hmm,
> > #!/usr/bin/perl
> > #
> > # acpixtract - extract raw table from acpidmp output
> > #
> > # Example: cat mail.txt | ./acpixtract DSDT | ./acpidisasm
> >
> >
> > how do i get the acpidmp output of my bios in order to use to diagnose?
> >
> Please use acpidump (not acpidmp).
> acpidump is part of the pmtools package.  Grab the latest
> pmtools package from
>   http://www.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/
> or from your distro.
>
> >
> > On 1/25/06, John H. <mistamaila@gmail.com> wrote:
> > > i am trying to use acpidmp which i've compiled from cvs from sourceforge
> > > when i run perl /usr/local/bin/acpixtract
> > > to extract bios, it never "stops" and dumps a file.
> > > what am i doing wrong?
> > >
> > -
>
> --
> ~Randy
>
