From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: reverted battery current conversion fix
Date: Tue, 16 Dec 2008 16:06:33 +0100
Message-ID: <200812161606.34110.rjw@sisk.pl>
References: <87zlixxaht.fsf@szonett.ki.iif.hu> <87ljuggxhf.fsf@tac.ki.iif.hu> <20081216142832.GC13379@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:55105 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755327AbYLPPHH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 Dec 2008 10:07:07 -0500
In-Reply-To: <20081216142832.GC13379@khazad-dum.debian.net>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Ferenc Wagner <wferi@niif.hu>, Alexey Starikovskiy <astarikovskiy@suse.de>, linux-acpi@vger.kernel.org

On Tuesday, 16 of December 2008, Henrique de Moraes Holschuh wrote:
> On Tue, 16 Dec 2008, Ferenc Wagner wrote:
> > Alexey Starikovskiy <astarikovskiy@suse.de> writes:
> > > Ferenc Wagner wrote:
> > >> Alexey Starikovskiy <astarikovskiy@suse.de> writes:
> > >>> Ferenc Wagner wrote:
> > >>>> the wild values probably came from some application, which
> > >>>> previously worked around the wrong sysfs current value (supposedly
> > >>>> correctly interpreting it as power) and thus got broken by the fix.
> > >>>
> > >>> Yes, the application is kpowersaved and it is written with the
> > >>> assumption that it could get remaining time by dividing either
> > >>> energy_now or charge_now by current_now.
> > >>
> > >> So the first choice depends on the current buggy kernel behaviour.
> > >> What's the plan of action in such cases?  I found some notes that
> > >> kpowersaved can or could use HAL for getting this information, in
> > >> which case HAL also should be fixed.  At least their bug tracker[1] on
> > >> SF doesn't contain any such issue, maybe one should be added by
> > >> somebody actually using it if the kernel is to be fixed.
> > >
> > > Currently, Rafael suggests, that it is too late to fix the kernel...

Actually no, I didn't say that.

What I said is that it was too late to change the interpretation of
'current_now' in the case when energy units were used.

> > Too late for 2.6.28 or too late for ever?  The ACPI sysfs interface
> > appeared about one year ago, if I read the git log right,
> > documentation followed this spring.  If the supposedly clean sysfs
> > interface can't live up to its very precise and well thought out
> > documentation, that should be documented at least.  :(  What a pity.
> 
> I sure hope it is "too late for 2.6.28" :-)

For 2.6.28 it's obviously too late, but I think it generally is too late to
change whatever is reported via 'current_now', because the userland already
started to rely on that.

> I can tell you what *I* do on thinkpad-acpi: I fix it, but I warn the users
> beforehand, and in the release notes, and in the commit message.  And I have
> documented that fact in the rules of engagement for the thinkpad-acpi sysfs
> interface, to make it extremely clear to all parties involved.
> 
> Note that "broken" != "not as neat as we'd like".  In this case, it *is*
> clearly broken, so what is happening is not a gratuitous ABI change.

That only is a semantic difference.  The breakage is actually the same.

> And if someone in userspace worked around the broken crap, IT IS THEIR FAULT
> for doing it in the first place instead of demanding that we fix the mess when
> they noticed it existed.

I think they didn't understand the interface and found the working settings by
experimentation.  It's not their fault that had to do that.

> PS: a little foresight can help wonders.  I suggest adding a version
> read-only attribute to the sysfs interface, and increase it when you do any
> ABI change that userspace could notice (be them fixes or something else).

Good idea, but it doesn't help in this particular case.

Thanks,
Rafael
