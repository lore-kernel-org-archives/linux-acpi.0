From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/3] ACPI: fix acpi_parse_entries_array() so it traverses
 all subtables
Date: Sat, 2 Jul 2016 00:01:26 +0200
Message-ID: <CAJZ5v0j8LWL-hNm=6tLTzjyqDRu+MFpibzjWjipy9dLUYJwvrA@mail.gmail.com>
References: <1467408081-7418-1-git-send-email-ahs3@redhat.com>
 <1467408081-7418-3-git-send-email-ahs3@redhat.com> <CAJZ5v0ig+E33Bb+eMuQpQQV4_RfX9MVbDf=WRTM6WDg=2LFGyQ@mail.gmail.com>
 <3b06c1f7-d1d1-f86a-ba3c-ef566af2f6db@redhat.com> <CAJZ5v0htLm0r0gk+t=_acBfeVA5ErW-bDRDEXHtKKQsAapEC5g@mail.gmail.com>
 <00e1e2ec-b7e1-606d-3faa-271560864d0e@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35635 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751900AbcGAWB2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Jul 2016 18:01:28 -0400
In-Reply-To: <00e1e2ec-b7e1-606d-3faa-271560864d0e@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <ahs3@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

On Fri, Jul 1, 2016 at 11:55 PM, Al Stone <ahs3@redhat.com> wrote:
> On 07/01/2016 03:46 PM, Rafael J. Wysocki wrote:
>> On Fri, Jul 1, 2016 at 11:41 PM, Al Stone <ahs3@redhat.com> wrote:
>>> On 07/01/2016 03:32 PM, Rafael J. Wysocki wrote:
>>>> On Fri, Jul 1, 2016 at 11:21 PM, Al Stone <ahs3@redhat.com> wrote:
>>>>> Without this patch, the acpi_parse_entries_array() function will return
>>>>> the very first time there is any error found in either the array of
>>>>> callback functions or if one of the callbacks returns an non-zero value.
>>>>> However, the array of callbacks could still have valid entries further
>>>>> on in the array, or the callbacks may be able to process subsequent
>>>>> subtables without error.  The change here makes the function consistent
>>>>> with its description so that it will properly return the sum of all
>>>>> matching entries for all proc handlers, instead of stopping abruptly
>>>>> as it does today.
>>>>
>>>> I'm not sure I follow.
>>>>
>>>> You seem to be saying that the function should process all of the
>>>> subtables etc even though errors have been found for some of them, but
>>>> it still will return an error in the end if there are any errors.  How
>>>> exactly does it help to continue processing in case of an error, then?
>>>
>>> The use case I have in mind is to simply count all of the subtables of
>>> a certain type.  If for some reason, the callback -- or any other callback
>>> -- fails, the traversal of all the subtables stops immediately.  So, I
>>> could have two callbacks, and if the first one fails on the first subtable
>>> of its type, traversal stops.  The count for the second callback will be
>>> zero which may or may not be correct.
>>
>> It will be zero, because the callback has not been invoked at all.
>> Why is this incorrect?
>>
>
> Because there could be additional subtables after the one causing a failure
> that the second callback could have counted; e.g., if the failure is on the
> first subtable of 20 in the MADT, the following 19 would be ignored, even if
> they were all the right subtype for the second callback.

Let me rephrase: Is there any practical value of invoking any more
callbacks if one of them has failed?  If so, what is it?

You are changing semantics from "abort on the first failure" to
"process everything and count errors".  That's quite a bit different
and I'm trying to understand why the latter is better.
