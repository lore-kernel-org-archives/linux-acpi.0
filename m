From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 3/3] ACPI: fix acpi_parse_entries_array() so it reports
 overflow correctly
Date: Sat, 2 Jul 2016 00:45:50 +0200
Message-ID: <CAJZ5v0gHw+Pf1CQBkG7gTHsc+t78T34VP1-0H9eRt+hCVmJRog@mail.gmail.com>
References: <1467408081-7418-1-git-send-email-ahs3@redhat.com>
 <1467408081-7418-4-git-send-email-ahs3@redhat.com> <CAJZ5v0hmfnARBC1+ZaGoJtQoHJ-Pp2mwz7HRR5EVybX0o--cxg@mail.gmail.com>
 <707a387c-43a0-daf4-a2c5-98e1d016f2b4@redhat.com> <CAJZ5v0i0sXTPP9S4ZAFNPRkatOkHUhYoFwuJS8-Tn8a3iT=-=A@mail.gmail.com>
 <203614ca-e846-4eac-fd6a-eb389b37fa08@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36341 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115AbcGAWpx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Jul 2016 18:45:53 -0400
In-Reply-To: <203614ca-e846-4eac-fd6a-eb389b37fa08@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <ahs3@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

On Sat, Jul 2, 2016 at 12:38 AM, Al Stone <ahs3@redhat.com> wrote:
> On 07/01/2016 03:54 PM, Rafael J. Wysocki wrote:
>> On Fri, Jul 1, 2016 at 11:44 PM, Al Stone <ahs3@redhat.com> wrote:
>>> On 07/01/2016 03:40 PM, Rafael J. Wysocki wrote:
>>>> On Fri, Jul 1, 2016 at 11:21 PM, Al Stone <ahs3@redhat.com> wrote:
>>>>> The function acpi_parse_entries_array() has a limiting parameter,
>>>>> max_entries, which tells the function to stop looking at subtables
>>>>> once that limit has been reached.  Further, if the limit is reached,
>>>>> it is reported.  However, the logic is incorrect in that the loop
>>>>> to examine all subtables will always stop when exactly max_entries
>>>>> have been found, regardless of whether or not there are still subtables
>>>>> to examine, and it will always report that zero subtables have been
>>>>> ignored.  This change allows the loop to continue to look at all
>>>>> subtables and count all the ones of interest; if we have already
>>>>> reached the number of max_entries, though, we will not invoke the
>>>>> callback functions.  If the max_entries limit has been exceeded,
>>>>> report on that, as before, but more accurately, listing how many
>>>>> subtables of interest there are in total (as was meant), and how
>>>>> many entries each subtable type occupied.
>>>>
>>>> The problem appears to be that, if max_entries has been reached, it
>>>> prints "ignored 0", although it should count all of the entries in
>>>> that case too in principle.  Do I think correctly?
>>>>
>>>
>>> Exactly.  That's how I interpreted the comments.  And it fit what I
>>> needed it to do if the comments were correct.
>>>
>>> Of course, it could be the code was correct and the comments were
>>> wrong :).  I preferred not to think that.
>>
>> I guess whoever implemented this function thought that the overhead
>> for counting stuff was not useful in case max_entries had been
>> reached.  I'm not really sure I disagree with that. :-)
>
> I'm not sure I disagree, either :).
>
>> I agree that printing "ignored 0" in that case is misleading, but the
>> fix might be to simply avoid printing how many entries have been
>> ignored then.  Maybe it will suffice to print how many entries have
>> been found and what the limit was?
>
> That could work.
>
> Unless I've misunderstood the code, though, the situation that seemed likely
> to me is, for example, to suppose that the first five subtables out of 20 are
> of a single type and cause my max_entries limit to be reached.  If I have three
> callbacks, I'd end up with two other callback functions that would never get
> called, even if some of the remaining 15 subtables are pertinent and could help
> get the boot process further along.

That depends on what max_entries is used for which I don't recall ATM.

So before making changes here, I'd recommend looking for code that
uses max_entries in non-trivial ways and finding the reasons why it is
used.

Maybe it is just not really needed or maybe it should just be replaced
with something else.  In any case, without any research in that
direction, I'd rather do the simplest fix possible.
