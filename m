From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: ACPI: EC: Fix logspam in "GPE storm avoidance" code
Date: Wed, 29 Oct 2008 13:08:36 -0200
Message-ID: <20081029150836.GA31678@khazad-dum.debian.net>
References: <49071C33.7030308@tuffmail.co.uk> <4907590E.4070104@suse.de> <20081029001231.GA22985@khazad-dum.debian.net> <49083216.60202@tuffmail.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:54880 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752390AbYJ2PIp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Oct 2008 11:08:45 -0400
Content-Disposition: inline
In-Reply-To: <49083216.60202@tuffmail.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Cc: Alexey Starikovskiy <astarikovskiy@suse.de>, linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

On Wed, 29 Oct 2008, Alan Jenkins wrote:
> Henrique de Moraes Holschuh wrote:
> > On Tue, 28 Oct 2008, Alexey Starikovskiy wrote:
> >> Alan Jenkins wrote:
> >>> <http://bugzilla.kernel.org/show_bug.cgi?id=11841>
> >>> "plenty of line "ACPI: EC: non-query interrupt received,
> >>>  switching to interrupt mode" in dmesg"
> >>>       
> >> Probably, it is better to make pr_debug().
> >>     
> >
> > Please don't do that.  This code has had a lot of churn, and *regressions*
> > as of lately, and sometimes we only notice these because we see those
> > messages in the logs.  Moving them to pr_debug() pretty much makes them
> > utterly useless in a large number of the cases they could be of help.
> >
> > Besides, I very much doubt we will stop seing EC interrupt crappage. Not
> > only our code is NOT good and resilient enough yet (if it were, there
> > wouldn't be so many patches flying about it), the vendors are obviously
> > getting this wrong at a fast rate.
> >
> > We need those messages.  Rate-limit them, but don't hide them or move them
> > to pr_debug, please.
> 
> Please have a look at the dmesg attached to the bug.  They're already
> rate-limited.

If people are considering moving it to pr_debug, it is not rate-limited
enough (one per mode switch is not enough if the EC or the code is behaving
so bad that it switches modes too often)...

> When in GPE storm avoidance mode, they will trigger once for each
> transaction.  Transactions happen frequently, and will happen
> continually once e.g. gnome-power-manager is polling the battery level. 
> In this special case, they're not a useful message to users or
> blackbox-level testers; they are only useful as part of a full DEBUG
> trace that actually shows the transactions.

Well, if they move to pr_debug _only_ when in GPE storm avoidance mode, AND
we get the logging of entering AND exiting GPE storm avoidance modes, that
would be quite acceptable, I think.

> My original patch suppresses the message in this particular case, but it
> preserves it for the common non-storm case, where it may provide useful
> information.  And the message would still happen once on boot, before
> the GPE storm is detected.  Unfortunately my patch also makes the driver
> a little less robust.  If the robustness issue can be addressed, do you
> accept that it's a good idea to suppress the flood of duplicate messages
> reported in this bug?

As I said above, if you supress them ONLY during GPE storm avoidance, then
yes, I am quite OK with it.

But we really should have GPE storm avoidance events logged, if we don't do
that already.

> We already have... damn.  I think you missed a more important omission. 
> There _used_ to be a message that says we've switched to storm avoidance
> mode.  However, it was removed in the latest re-write.  This bug report
> suggests that a) the cause would have been more obvious if we had the
> GPE storm message, and b) the stormy case wasn't really tested so we
> really do need a message, in case it goes wrong.

Indeed, that's bad, and needs to be fixed IMHO.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
