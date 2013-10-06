From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] acpi: update win8 OSI blacklist
Date: Mon, 7 Oct 2013 00:57:02 +0100
Message-ID: <20131006235702.GA21738@srcf.ucam.org>
References: <20131004161226.GA22784@srcf.ucam.org>
 <CAMP44s0tqKBgUTzFnbTMqDVVWLcaDC5VKd9mq_w+T_Yu19KXqQ@mail.gmail.com>
 <20131006203353.GA19795@srcf.ucam.org>
 <CAMP44s0N5xqD2W7-r-j1k3efo1k0qY2gCeqn+tbHsvOsrqOJgg@mail.gmail.com>
 <20131006204518.GA20077@srcf.ucam.org>
 <CAMP44s0GkVyw+PRYKqq7=MXFFtgUO9xCq6jTsoQV-rSRmC23yg@mail.gmail.com>
 <20131006205928.GA20296@srcf.ucam.org>
 <CAMP44s33CByGsRz7vsNAoOLnbEMY+fz73NzHJq07BzSuCEGJUg@mail.gmail.com>
 <20131006233106.GA21562@srcf.ucam.org>
 <CAMP44s1-vCgOkE_h1ZEmCA2WiQyLTOvnis2MOjdu8kdDB39kFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:56896 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754896Ab3JFX5E (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 6 Oct 2013 19:57:04 -0400
Content-Disposition: inline
In-Reply-To: <CAMP44s1-vCgOkE_h1ZEmCA2WiQyLTOvnis2MOjdu8kdDB39kFg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

On Sun, Oct 06, 2013 at 06:36:57PM -0500, Felipe Contreras wrote:
> On Sun, Oct 6, 2013 at 6:31 PM, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> > On Sun, Oct 06, 2013 at 06:27:28PM -0500, Felipe Contreras wrote:
> >> From acpi_osi_dmi_table:
> >>
> >> /*
> >> * BIOS invocation of _OSI(Linux) is almost always a BIOS bug.
> >> * Linux ignores it, except for the machines enumerated below.
> >> */
> >
> > Which was a mistake. We learn from mistakes rather than repeating them.
> 
> According to you.

Cool. Look at that file and, without resorting to git blame, tell me 
why each of those entries is there. If your answer is "Just use git 
blame", then that's fine up until the point where someone reformats the 
list or decides to change the order and now it's still *possible* it's 
just really annoying, so why not just add the comments? They're cheap 
and you could have done it trivially in the time it's taken you to reply 
to this thread.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
