From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: reverted battery current conversion fix
Date: Tue, 16 Dec 2008 12:28:32 -0200
Message-ID: <20081216142832.GC13379@khazad-dum.debian.net>
References: <87zlixxaht.fsf@szonett.ki.iif.hu> <49476A1B.7020107@suse.de> <87tz94h08k.fsf@tac.ki.iif.hu> <49478749.8000900@suse.de> <87ljuggxhf.fsf@tac.ki.iif.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:60907 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754444AbYLPO2g (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Dec 2008 09:28:36 -0500
Content-Disposition: inline
In-Reply-To: <87ljuggxhf.fsf@tac.ki.iif.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ferenc Wagner <wferi@niif.hu>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, linux-acpi@vger.kernel.org, "Rafael J.Wysocki" <rjw@sisk.pl>

On Tue, 16 Dec 2008, Ferenc Wagner wrote:
> Alexey Starikovskiy <astarikovskiy@suse.de> writes:
> > Ferenc Wagner wrote:
> >> Alexey Starikovskiy <astarikovskiy@suse.de> writes:
> >>> Ferenc Wagner wrote:
> >>>> the wild values probably came from some application, which
> >>>> previously worked around the wrong sysfs current value (supposedly
> >>>> correctly interpreting it as power) and thus got broken by the fix.
> >>>
> >>> Yes, the application is kpowersaved and it is written with the
> >>> assumption that it could get remaining time by dividing either
> >>> energy_now or charge_now by current_now.
> >>
> >> So the first choice depends on the current buggy kernel behaviour.
> >> What's the plan of action in such cases?  I found some notes that
> >> kpowersaved can or could use HAL for getting this information, in
> >> which case HAL also should be fixed.  At least their bug tracker[1] on
> >> SF doesn't contain any such issue, maybe one should be added by
> >> somebody actually using it if the kernel is to be fixed.
> >
> > Currently, Rafael suggests, that it is too late to fix the kernel...
> 
> Too late for 2.6.28 or too late for ever?  The ACPI sysfs interface
> appeared about one year ago, if I read the git log right,
> documentation followed this spring.  If the supposedly clean sysfs
> interface can't live up to its very precise and well thought out
> documentation, that should be documented at least.  :(  What a pity.

I sure hope it is "too late for 2.6.28" :-)

I can tell you what *I* do on thinkpad-acpi: I fix it, but I warn the users
beforehand, and in the release notes, and in the commit message.  And I have
documented that fact in the rules of engagement for the thinkpad-acpi sysfs
interface, to make it extremely clear to all parties involved.

Note that "broken" != "not as neat as we'd like".  In this case, it *is*
clearly broken, so what is happening is not a gratuitous ABI change.  And if
someone in userspace worked around the broken crap, IT IS THEIR FAULT for
doing it in the first place instead of demanding that we fix the mess when
they noticed it existed.

PS: a little foresight can help wonders.  I suggest adding a version
read-only attribute to the sysfs interface, and increase it when you do any
ABI change that userspace could notice (be them fixes or something else).

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
