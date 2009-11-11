From: Ferenc Wagner <wferi@niif.hu>
Subject: Re: [linux-pm] intermittent suspend problem again
Date: Wed, 11 Nov 2009 12:29:33 +0100
Message-ID: <87my2tnvtu.fsf@tac.ki.iif.hu>
References: <87fx93pwv2.fsf@tac.ki.iif.hu> <200910281956.44791.rjw@sisk.pl>
	<87d447m52t.fsf@tac.ki.iif.hu> <200910291936.14082.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from tac.ki.iif.hu ([193.6.222.43]:50596 "EHLO tac.ki.iif.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751496AbZKKLaP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Nov 2009 06:30:15 -0500
In-Reply-To: <200910291936.14082.rjw@sisk.pl> (Rafael J. Wysocki's message of
	"Thu, 29 Oct 2009 19:36:14 +0100")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, Jesse Barnes <jbarnes@virtuousgeek.org>, Andrew Morton <akpm@linux-foundation.org>, yakui.zhao@intel.com, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>

"Rafael J. Wysocki" <rjw@sisk.pl> writes:

> On Thursday 29 October 2009, Ferenc Wagner wrote:
>
>> "Rafael J. Wysocki" <rjw@sisk.pl> writes:
>> 
>>> On Wednesday 28 October 2009, Ferenc Wagner wrote:
>>> 
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
>> Can't you perhaps suggest a way forward there?  Or some tricks to create a
>> reproducible test case here?
>
> Well, you can test if the problem is reproducible in the "shutdown" mode of
> hibernation.

Well, both failure modes happen with "shutdown" mode as well (the S|
freeze with yesterday's git, too), but still not reproducibly.  When
s2disk is stuck in "Snapshotting system", the system is not completely
dead, it echoes line feeds and Ctrl-C at least (as added to #14504).

I wonder what you did if the issue was reproducible...  Is that totally
unapplicable if the problem happens with 10% probability only?  Slow,
sure, but until I manage to set up an automated testing bench...
-- 
Thanks,
Feri.
