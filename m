From: Len Brown <lenb@kernel.org>
Subject: Re: ACPI Thermal workaround hooks
Date: Sat, 11 Aug 2007 00:41:50 -0400
Message-ID: <200708110041.51069.lenb@kernel.org>
References: <11866391363162-git-send-email-len.brown@intel.com> <1186680825.8780.268.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56786 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750883AbXHKEl5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 11 Aug 2007 00:41:57 -0400
In-Reply-To: <1186680825.8780.268.camel@queen.suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: linux-acpi@vger.kernel.org


Thanks for the feedback, Thomas.

On Thursday 09 August 2007 13:33, Thomas Renninger wrote:
> On Thu, 2007-08-09 at 01:58 -0400, Len Brown wrote:
> > In response to the outcry after I deleted the trip-point
> > overrides, here is how I think we can work-around
> > thermal issues in a supportable way.
> > 
> > In particular, this series should address the issues
> > on Knut's AOpen Award system here:
> > http://bugzilla.kernel.org/show_bug.cgi?id=8842
> > and give us the hooks to address analogous issues in
> > other systems.
> > 
> > Please let me know what you think.
> 
> Thanks.
> This is very much appreciated.
> 
> I like the idea of boot parameters, this avoids the seduction to build
> tools on it and mis-use this as an official interface.
> 
> But where I like to see a sysfs interface for, is the passive trip point
> and allow:
>   a) lowering passive trip points
>   b) let user define his own passive trip point if none
>      is provided by BIOS
>
> I don't remember whether every trip point gets it's own sysfs file. If
> yes, adding a passive_user file, default -1 and the normal passive file
> where the current active passive trip point value is shown, is how I
> think this could be done.

My guess is that those who have active+passive cooling and want
a system that stays silent more will choose to use thermal.act=
override to raise their low temp fan trip point
to stay silent up to a higher temperature.

I think it will be less popular for those w/o active cooling to
force their passive trip-point lower to maintain a silent system
at the cost of performance -- but I'm sure there are some people
who are interested in doing so, and thermal.psv will indeed
let them do that if a passive trip point already exists
(and it usually does).

> I know you hate it, because it's not explicitly stated in ACPI spec,
> works around it a bit and so on.
> But this one is:
>   1) safe (in respect to hardware and code)
>   2) a very mighty feature

Don't get me wrong -- I make no assumption that "ACPI spec compliance"
is the end-goal here -- making users's systems useful & supportable is the end goal.
However, the reality is that the vast majority of systems are validated
for Windows, and so to make Linux most supportable on those systems,
it is usually in our best interest to behave largely like (we imagine)
Windows does on those systems.  Otherwise we exercise the BIOS where
it is poorly validated and run into snags.

Note that the thermal.psv in this series is writable by root at run-time.
But as it requires a trip-point-changed event to get noticed after
module load time, that will get you almost the feature you are looking for,
but only on systems with active cooling -- the more common ones with just critical
and passive will not be implementing hysteresis and thus would not 
be changing trip-points at run-time.  For those, you'd have to rmmod thermal
and modprobe thermal to force the new passive trip point to get noticed.

I agree, if a system doesn't have a passive trip point, it would probably
not be dangerous (from a HW standpoint) to invent one and layer it over
this mechanism.  However, I stopped short of doing that.  There have been
various discussions of doing something along those lines by integrating
throttling with cpufreq p-states, and I wonder if instead,
a more generic mechanism in that space isn't the way to go.

Note also that thermal.act behaves like thermal.psv above.  Here, however,
the system, by definition, implements active trip points -- and all the
functional ones I've seen implement hysteresis and thus implement
trip point change events -- so you could actually scribble on this
thermal.act at run-time and it would become effective upon the next trip event.
Yes, providing this override was a compromise.  I stopped short of overrides
for all possible active trips b/c I didn't want to get tangled in the
hysteresis mess, and I figured the lowest trip point is the one of
of most interest to those trying to run completely silent.  Even
this single trip-point override is not fool-proof, as there is no
guarantee that the BIOS will actually send an event at the temperature
that this gets set to.  However, it does handle the most interesting
trivial case of allowing us to ignore such an event when we don't want
to turn the fan on as soon as the BIOS default setting.

thanks,
-Len

