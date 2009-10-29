From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: [linux-pm] intermittent suspend problem again
Date: Thu, 29 Oct 2009 23:31:51 +0100
Message-ID: <87fx91q1bc.fsf@tac.ki.iif.hu>
References: <87fx93pwv2.fsf@tac.ki.iif.hu> <200910281956.44791.rjw@sisk.pl>
	<87d447m52t.fsf@tac.ki.iif.hu> <200910291936.14082.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:57146 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750898AbZJ2WcS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 29 Oct 2009 18:32:18 -0400
In-Reply-To: <200910291936.14082.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Thu, 29 Oct 2009 19:36:14 +0100")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Andrew Morton <akpm@linux-foundation.org>, yakui.zhao@intel.com, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Thursday 29 October 2009, Ferenc Wagner wrote:
>> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
>> 
>>> On Wednesday 28 October 2009, Ferenc Wagner wrote:
>>> 
>>>> Something similar to http://bugzilla.kernel.org/show_bug.cgi?id=13894
>>>> raised its ugly head again, please see my last comments on that bug.
>>>
>>> This very well may be a separete bug, so please file a new bugzilla report
>>> on this and mark it as a regression.
>> 
>> Done.
>
> Which number is this?

http://bugzilla.kernel.org/show_bug.cgi?id=14504
Submitted containing the following paragraph only:

>>>> 2.6.32-rc5 feels particularly bad, with frequent failures to switch
>>>> off the machine after "S|" or freezes after "Snapshotting system".
>>>> The former does not cause much trouble in itself, as the machine can
>>>> be switched off and resumed all right, but the latter is nasty.
>>>> Suspend to RAM works all the time.  The issue is not reproducible,
>>>> unfortunately, and the kernel change happened almost together with a
>>>> BIOS upgrade.  Yesterday I switched back to 2.6.31 to see whether it
>>>> still works stably with the new BIOS.  I'll report back my findings in
>>>> a couple of days.
>>>
>>> OK, thanks.
>>>
>>> Still, I'm really afraid we won't be able to debug it any further without a
>>> reproducible test case.
>> 
>> I've got another, fully reproducible but nevertheless neglected ACPI
>> problem, already mentioned in #13894:
>> https://bugs.freedesktop.org/show_bug.cgi?id=22126.
>
> A side note: I'm totally unhappy with _kernel_ bugs being handled at
> bugs.freedesktop.org without a notice anywhere else.  Even though they are
> related to the graphics, the kernel developers in general at least deserve the
> information that the bugs have been reported.
>
> In this particulare case, the bug is clearly related to ACPI and linux-acpi
> should have received a notification about it.

When the ACPI relation became clear to me, I notified linux-acpi, see
http://thread.gmane.org/gmane.linux.acpi.devel/42172/focus=42230

>> Well, it's probably far-fetched, but maybe the two are somehow related...
>
> Very well may be.
>
>> Can't you perhaps suggest a way forward there?  Or some tricks to create a
>> reproducible test case here?
>
> Well, you can test if the problem is reproducible in the "shutdown" mode of
> hibernation.

Ok, I'll go back to 2.6.32-rc5 for testing that.  Does that make any
difference in the "Snapshotting system" phase?  Freezes happen that
time, too, before writing out the image.

>> Btw. my gut feeling is that hibernation is getting slower with each
>> kernel release.  I didn't measure it, and didn't even care about
>> comparable initial states... But could anything explain this, or is
>> it sheer impatience?
>
> Which part of it is getting slower?  Saving the image, suspending
> devices or the entire hibernation overall?

"Snapshotting system" before saving the image and saving the image as
well.  If s2disk didn't report funny huge negative ratios all the
time, I'd probably have tried to correlate this with the number of
saved pages or similar...  But anyway, this is a minor nit, it's still
far from being unbearable.  If only it worked all the time!
-- 
Thanks,
Feri.
