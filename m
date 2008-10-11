From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: acpi-test tree on eeepc: EC error message on second resume
Date: Sat, 11 Oct 2008 21:40:15 +0200
Message-ID: <200810112140.16662.rjw@sisk.pl>
References: <48F0DB0C.7060201@tuffmail.co.uk> <200810112130.57757.rjw@sisk.pl> <48F0FEFA.7050308@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:59101 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750976AbYJKTfn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 11 Oct 2008 15:35:43 -0400
In-Reply-To: <48F0FEFA.7050308@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, linux acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>

On Saturday, 11 of October 2008, Alexey Starikovskiy wrote:
> Rafael J. Wysocki wrote:
> > On Saturday, 11 of October 2008, Alexey Starikovskiy wrote:
> >   
> >> Alan Jenkins wrote:
> >>     
> >>> I think I found the problem.  The "input buffer empty" wait depends on
> >>> "interrupt mode" to work properly, and we don't immediately enable the
> >>> interrupt on resume.  The wait should have a polling fallback anyway, to
> >>> be consistent with the other transaction waits.
> >>>
> >>> Alan
> >>>       
> >> Yep, I think something like attached patch may help:
> >>     
> >
> > [Can you please append patches instead of or apart from attaching them?
> > That would make it easier to comment them.]
> >
> >   
> Ok.
> > if (!wait_event_timeout(ec->wait, ec_check_ibf0(ec),
> > -                               msecs_to_jiffies(ACPI_EC_DELAY))) {
> > +                               msecs_to_jiffies(ACPI_EC_DELAY)) &&
> > +           !ec_check_ibf0(ec)) {
> >
> > Shouldn't this go under the spinlock?  Surely it can race with the GPE handler.
> >
> >   
> No, we discussed this before -- we are outside of the transaction, thus 
> no GPE
> activity could interfere with ec_check_ibf0.

Ok, this is in the process context and we don't really expect to get an
interrupt at this point, but what happens if the EC generates an event that's
not related to any transiaction.  Is that guaranteed to never happen?

Thanks,
Rafael
