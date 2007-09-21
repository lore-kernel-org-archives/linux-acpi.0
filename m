From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.23-rc6: S4 and S5 no longer listed as supported on Toshiba Satellite A40
Date: Fri, 21 Sep 2007 16:33:07 +0200
Message-ID: <200709211633.08100.rjw@sisk.pl>
References: <200709192014.08443.elendil@planet.nl> <200709202253.07571.rjw@sisk.pl> <46F3CF88.4010303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:43228 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756728AbXIUOUF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 21 Sep 2007 10:20:05 -0400
In-Reply-To: <46F3CF88.4010303@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: Frans Pop <elendil@planet.nl>, Pavel Machek <pavel@ucw.cz>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Maciek Rutecki <maciej.rutecki@gmail.com>

On Friday, 21 September 2007 16:04, Alexey Starikovskiy wrote:
> Rafael J. Wysocki wrote:
> > On Thursday, 20 September 2007 22:32, Frans Pop wrote:
> >> On Thursday 20 September 2007, Rafael J. Wysocki wrote:
> >>> On Thursday, 20 September 2007 20:33, Alexey Starikovskiy wrote:
> >>>> Frans Pop wrote:
> >>>>> On Thursday 20 September 2007, you wrote:
> >>>>>> Please try this patch.
> >>>>> Works. All states are now listed again.
> >>>>> I've not tested suspend to disk, but suspend to ram and power off
> >>>>> work fine.
> >>>>>
> >>>>>> +printk(KERN_INFO PREFIX "(supports");
> >> Note that this printk should be indented.
> >>
> >>>>>>  #ifdef CONFIG_SUSPEND
> >>>>>> -       printk(KERN_INFO PREFIX "(supports");
> >>>>>>         for (i = ACPI_STATE_S0; i < ACPI_STATE_S4; i++) {
> >>>>> Isn't there a risk now that we now end up printing
> >>>>>    ACPI: (supports)
> >>>>> if CONFIG_SUSPEND is not enabled and >S4 is not supported?
> >>>>>
> >>>>> Or, more probably, it would print
> >>>>>    ACPI: (supports S5)
> >>>> Don't know what does it mean to support S0 exactly... :)
> >> Agreed, though arguably the same goes for S5. I guess you could say they are 
> >> all states that can be switched to.
> >>
> >>>>> as it is unlikely that "off" is not supported :-)
> >>>>>
> >>>>> Maybe S0 should be taken outside the #ifdef and the loop as that
> >>>>> state is also basically always there?
> >>>> Don't think it is worth the trouble. We already have this loop almost
> >>>> completely unrolled, let's not make it complete mess...
> >>> Well, you could use "(supports S0" instead of just "(supports". ;-)
> >> After thinking about this a bit more, I think this does make sense for three 
> >> (admittedly minor) reasons:
> >> - consistency between messages with and without CONFIG_SUSPEND
> >> - consistency with /proc/acpi/sleep
> >> - avoiding unnecessary change from previous versions.
> >>
> >> Please consider the attached patch which applies on top of Alexey's. Feel 
> >> free to integrate it in his patch.
> >>
> >> Signed-off-by: Frans Pop <elendil@planet.nl>
> > 
> > Alexey, do you agree?
> Yes, was thinking to do it myself, but my ISP died this morning....

OK

I'll push the Frans' patch to Len if you don't mind.

Greetings,
Rafael
