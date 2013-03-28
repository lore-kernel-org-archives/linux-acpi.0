From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI / ACPI: Always resume devices on ACPI wakeup notifications
Date: Thu, 28 Mar 2013 13:12:42 -0600
Message-ID: <CAErSpo4PeJFikKZQvZVTFzZDu+mA--MsgbP7WZYBdd0hJBpAow@mail.gmail.com>
References: <2282655.IicBMMa6jN@vostro.rjw.lan> <2457825.yjlrJCricN@vostro.rjw.lan>
 <CAErSpo6oNPKn5eQV_ERaw1659-9N_Dti7ewKiRfVCy2Xw9rzbg@mail.gmail.com>
 <1433753.0tcctuHSKe@vostro.rjw.lan> <51547D45.6030106@fold.natur.cuni.cz>
 <CAErSpo7QXe1-R5_jXCcc3g_J-_HXqO3V12nNB=Z6eCAt-vwKfA@mail.gmail.com> <20130328182326.GA5995@xanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f177.google.com ([209.85.214.177]:46597 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751110Ab3C1TNE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Mar 2013 15:13:04 -0400
Received: by mail-ob0-f177.google.com with SMTP id eh20so9681745obb.36
        for <linux-acpi@vger.kernel.org>; Thu, 28 Mar 2013 12:13:04 -0700 (PDT)
In-Reply-To: <20130328182326.GA5995@xanatos>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>, "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Thu, Mar 28, 2013 at 12:23 PM, Sarah Sharp
<sarah.a.sharp@linux.intel.com> wrote:
> On Thu, Mar 28, 2013 at 11:49:05AM -0600, Bjorn Helgaas wrote:
>> On Thu, Mar 28, 2013 at 11:26 AM, Martin Mokrejs
>> <mmokrejs@fold.natur.cuni.cz> wrote:
>> >
>> >
>> > Rafael J. Wysocki wrote:
>> >> On Thursday, March 28, 2013 10:46:10 AM Bjorn Helgaas wrote:
>> >>> On Thu, Mar 28, 2013 at 10:41 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> >>>> On Thursday, March 28, 2013 10:21:30 AM Bjorn Helgaas wrote:
>> >>>>> On Thu, Mar 28, 2013 at 6:57 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> >>>>> If you have
>> >>>>> a URL for a bugzilla or mailing list report of the original problem,
>> >>>>> that would be good, too.  It'd be nice if users and distros could
>> >>>>> match problem reports with this solution, but I can't tell what the
>> >>>>> user-visible issue was.  I assume that Sarah tested this (or somebody
>> >>>>> else reproduced the problem and tested the fix)?
>> >>>>
>> >>>> Sarah reported it to me privately and I'm afraid I don't have any pointers
>> >>>> to publicly available mailing list archives etc.
>> >>>
>> >>> Do you at least have a description of how a user could determine
>> >>> whether he is seeing the problem fixed by this patch?
>> >>
>> >> Yeah.  For example, when the problem is visible on a USB controller and that
>> >> controller is runtime-suspended, then plugging a new USB device into one
>> >> of the controller's ports won't wake the controller up without the patch.
>> >
>> > Hi,
>> >  I am wondering for a week or two why nobody answered any of my bug reports,
>> > not even Sarah who asked for more details. I am think the fix is about my report
>> > under thread "Re: 3.8.2: xhci port is dead until pcieport PME# goes to disabled"
>> > and I really wonder why I wasn't Cc:ed and listed as a reporter provided it is
>> > about my report. But I should better wait what Sarah says. ;-)
>
> Actually, it didn't occur to me that your issue might be related at all.
> Sure, you can try this patch, on top of Greg's usb-linus branch, and see
> if it fixes your issue.
>
> I just reproduced this on an internal machine, and decided to report it
> privately to Rafael first, in case the early hardware was just broken.
>
> Bjorn, I see that you're encouraging people to have their bugs and
> symptoms in a bug tracker.  I've also been doing that within Intel, in a
> private JIRA issue tracker.  I've been discussing if we can duplicate
> some bugs or features that don't contain Intel confidential information
> to a public JIRA at 01.org.  I don't really want to use
> bugzilla.kernel.org because, quite frankly, the interface is archaic,
> and in the past I've gotten pushback from other devs about tracking
> "someday" features in there.

My main concern is that often there's more information relevant to a
change than it makes sense to put in the changelog, so I like to
include a URL to that additional info.  I don't really care if that's
for a mailing list archive, a bugzilla, a JIRA instance, etc.  Issue
trackers are more convenient than mailing lists for collecting dmesg
logs, acpidumps, etc.  The archaic bugzilla interface notwithstanding,
I'm not sure it would be an improvement to have a collection of dozens
of issue trackers controlled by random organizations.  I'd rather have
a single place and confidence that it will stick around.

Bjorn
