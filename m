From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: [PATCH] PCI / ACPI: Always resume devices on ACPI wakeup
 notifications
Date: Thu, 28 Mar 2013 11:23:26 -0700
Message-ID: <20130328182326.GA5995@xanatos>
References: <2282655.IicBMMa6jN@vostro.rjw.lan>
 <2457825.yjlrJCricN@vostro.rjw.lan>
 <CAErSpo6oNPKn5eQV_ERaw1659-9N_Dti7ewKiRfVCy2Xw9rzbg@mail.gmail.com>
 <1433753.0tcctuHSKe@vostro.rjw.lan>
 <51547D45.6030106@fold.natur.cuni.cz>
 <CAErSpo7QXe1-R5_jXCcc3g_J-_HXqO3V12nNB=Z6eCAt-vwKfA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:28610 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752386Ab3C1SXf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Mar 2013 14:23:35 -0400
Content-Disposition: inline
In-Reply-To: <CAErSpo7QXe1-R5_jXCcc3g_J-_HXqO3V12nNB=Z6eCAt-vwKfA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Thu, Mar 28, 2013 at 11:49:05AM -0600, Bjorn Helgaas wrote:
> On Thu, Mar 28, 2013 at 11:26 AM, Martin Mokrejs
> <mmokrejs@fold.natur.cuni.cz> wrote:
> >
> >
> > Rafael J. Wysocki wrote:
> >> On Thursday, March 28, 2013 10:46:10 AM Bjorn Helgaas wrote:
> >>> On Thu, Mar 28, 2013 at 10:41 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >>>> On Thursday, March 28, 2013 10:21:30 AM Bjorn Helgaas wrote:
> >>>>> On Thu, Mar 28, 2013 at 6:57 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >>>>> If you have
> >>>>> a URL for a bugzilla or mailing list report of the original problem,
> >>>>> that would be good, too.  It'd be nice if users and distros could
> >>>>> match problem reports with this solution, but I can't tell what the
> >>>>> user-visible issue was.  I assume that Sarah tested this (or somebody
> >>>>> else reproduced the problem and tested the fix)?
> >>>>
> >>>> Sarah reported it to me privately and I'm afraid I don't have any pointers
> >>>> to publicly available mailing list archives etc.
> >>>
> >>> Do you at least have a description of how a user could determine
> >>> whether he is seeing the problem fixed by this patch?
> >>
> >> Yeah.  For example, when the problem is visible on a USB controller and that
> >> controller is runtime-suspended, then plugging a new USB device into one
> >> of the controller's ports won't wake the controller up without the patch.
> >
> > Hi,
> >  I am wondering for a week or two why nobody answered any of my bug reports,
> > not even Sarah who asked for more details. I am think the fix is about my report
> > under thread "Re: 3.8.2: xhci port is dead until pcieport PME# goes to disabled"
> > and I really wonder why I wasn't Cc:ed and listed as a reporter provided it is
> > about my report. But I should better wait what Sarah says. ;-)

Actually, it didn't occur to me that your issue might be related at all.
Sure, you can try this patch, on top of Greg's usb-linus branch, and see
if it fixes your issue.

I just reproduced this on an internal machine, and decided to report it
privately to Rafael first, in case the early hardware was just broken.

Bjorn, I see that you're encouraging people to have their bugs and
symptoms in a bug tracker.  I've also been doing that within Intel, in a
private JIRA issue tracker.  I've been discussing if we can duplicate
some bugs or features that don't contain Intel confidential information
to a public JIRA at 01.org.  I don't really want to use
bugzilla.kernel.org because, quite frankly, the interface is archaic,
and in the past I've gotten pushback from other devs about tracking
"someday" features in there.

If you're interested in making bugs and features more traceable, would
it help you for us to file scrubbed bugs/features in a public JIRA
instance?  If so, I'll talk with our admins further.

Sarah Sharp
