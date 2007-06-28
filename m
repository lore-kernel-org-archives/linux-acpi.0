From: "Luming Yu" <luming.yu@gmail.com>
Subject: Re: Asus M6*, A6*, L5D - can't reboot after suspend/resume
Date: Fri, 29 Jun 2007 06:08:13 +0800
Message-ID: <3877989d0706281508wa281ff0j735f684cb5c40de2@mail.gmail.com>
References: <87myyjdcp6.fsf@vertex.dottedmag.net>
	 <200706282323.21340.rjw@sisk.pl>
	 <3877989d0706281451j6ed47793u27d0855532106991@mail.gmail.com>
	 <200706290006.52333.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.227]:55331 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759461AbXF1WIO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Jun 2007 18:08:14 -0400
Received: by nz-out-0506.google.com with SMTP id s18so256658nze
        for <linux-acpi@vger.kernel.org>; Thu, 28 Jun 2007 15:08:13 -0700 (PDT)
In-Reply-To: <200706290006.52333.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Mikhail Gusarov <dottedmag@dottedmag.net>, linux-acpi@vger.kernel.org

OK, let's try linuxfirmware tool to see if it is Linux problem or
probably bios problem.
you can grab the tool kit from http://www.linuxfirmwarekit.org/
then please do a suspend-resume cycle, then try reboot from the command line.
Let's see the results. :-)

On 6/29/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Thursday, 28 June 2007 23:51, Luming Yu wrote:
> > Please try the 1st patch:
> > http://bugzilla.kernel.org/show_bug.cgi?id=6655#c8
> > if not work, please try the 2nd patch:
> > http://bugzilla.kernel.org/show_bug.cgi?id=6655#c23
> > if still not, I don't know what's the hell about the problem.
> > Need to debug further.
>
> Well, the patch at http://bugzilla.kernel.org/show_bug.cgi?id=6655#c39
> (based on http://bugzilla.kernel.org/show_bug.cgi?id=6655#c23) works on one of
> my test boxes, but on the second one (Asus L5D) it doesn't work.
>
> Greetings,
> Rafael
>
>
> > On 6/29/07, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > > On Thursday, 28 June 2007 22:52, Mikhail Gusarov wrote:
> > > > Hi.
> > > >
> > > > ping'ing mailing list: there is stuck bug in bugzilla and probably fresh eyes
> > > > need to look at it to find the obvious solution :) Sorry if this noise is
> > > > unnecessary.
> > > >
> > > > Bug is http://bugzilla.kernel.org/show_bug.cgi?id=8598
> > > >
> > > > Summary:
> > > >
> > > > Most recent kernel where this bug did not occur: n/a
> > > > Distribution: debian/sid
> > > > Hardware Environment: Asus A6B, A6BA, M6A, M6N, M6NE, L5D notebooks
> > > > Problem Description: After S3 STR reboot does not work, reboot=w,h and
> > > > reboot=c,b, no luck. System shows message about restarting system. Caps lock and
> > > > num lock LEDs flash, but it does not reboot.
> > > >
> > > > I personally have only M6N notebook, so can test things only on it.
> > >
> > > I'm afraid that this is not an easy problem.  It shows up on two of my own test
> > > machines and I have no idea how to debug it further, let alone fixing.
> > >
> > > Greetings,
> > > Rafael
> > >
> > >
> > > --
> > > "Premature optimization is the root of all evil." - Donald Knuth
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> > > the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > >
> >
> >
>
> --
> "Premature optimization is the root of all evil." - Donald Knuth
>
