From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH 2/3] ACPI: fix acpi_parse_entries_array() so it traverses
 all subtables
Date: Fri, 1 Jul 2016 17:07:37 -0600
Message-ID: <17ed6d8d-e8f7-ec0a-4e98-e1a251edd320@redhat.com>
References: <1467408081-7418-1-git-send-email-ahs3@redhat.com>
 <1467408081-7418-3-git-send-email-ahs3@redhat.com>
 <CAJZ5v0ig+E33Bb+eMuQpQQV4_RfX9MVbDf=WRTM6WDg=2LFGyQ@mail.gmail.com>
 <3b06c1f7-d1d1-f86a-ba3c-ef566af2f6db@redhat.com>
 <CAJZ5v0htLm0r0gk+t=_acBfeVA5ErW-bDRDEXHtKKQsAapEC5g@mail.gmail.com>
 <00e1e2ec-b7e1-606d-3faa-271560864d0e@redhat.com>
 <CAJZ5v0j8LWL-hNm=6tLTzjyqDRu+MFpibzjWjipy9dLUYJwvrA@mail.gmail.com>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:36033 "EHLO
	mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932081AbcGAXHj (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Jul 2016 19:07:39 -0400
Received: by mail-it0-f51.google.com with SMTP id a5so29689370ita.1
        for <linux-acpi@vger.kernel.org>; Fri, 01 Jul 2016 16:07:39 -0700 (PDT)
In-Reply-To: <CAJZ5v0j8LWL-hNm=6tLTzjyqDRu+MFpibzjWjipy9dLUYJwvrA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

On 07/01/2016 04:01 PM, Rafael J. Wysocki wrote:
> On Fri, Jul 1, 2016 at 11:55 PM, Al Stone <ahs3@redhat.com> wrote:
>> On 07/01/2016 03:46 PM, Rafael J. Wysocki wrote:
>>> On Fri, Jul 1, 2016 at 11:41 PM, Al Stone <ahs3@redhat.com> wrote:
>>>> On 07/01/2016 03:32 PM, Rafael J. Wysocki wrote:
>>>>> On Fri, Jul 1, 2016 at 11:21 PM, Al Stone <ahs3@redhat.com> wrote:
>>>>>> Without this patch, the acpi_parse_entries_array() function will return
>>>>>> the very first time there is any error found in either the array of
>>>>>> callback functions or if one of the callbacks returns an non-zero value.
>>>>>> However, the array of callbacks could still have valid entries further
>>>>>> on in the array, or the callbacks may be able to process subsequent
>>>>>> subtables without error.  The change here makes the function consistent
>>>>>> with its description so that it will properly return the sum of all
>>>>>> matching entries for all proc handlers, instead of stopping abruptly
>>>>>> as it does today.
>>>>>
>>>>> I'm not sure I follow.
>>>>>
>>>>> You seem to be saying that the function should process all of the
>>>>> subtables etc even though errors have been found for some of them, but
>>>>> it still will return an error in the end if there are any errors.  How
>>>>> exactly does it help to continue processing in case of an error, then?
>>>>
>>>> The use case I have in mind is to simply count all of the subtables of
>>>> a certain type.  If for some reason, the callback -- or any other callback
>>>> -- fails, the traversal of all the subtables stops immediately.  So, I
>>>> could have two callbacks, and if the first one fails on the first subtable
>>>> of its type, traversal stops.  The count for the second callback will be
>>>> zero which may or may not be correct.
>>>
>>> It will be zero, because the callback has not been invoked at all.
>>> Why is this incorrect?
>>>
>>
>> Because there could be additional subtables after the one causing a failure
>> that the second callback could have counted; e.g., if the failure is on the
>> first subtable of 20 in the MADT, the following 19 would be ignored, even if
>> they were all the right subtype for the second callback.
> 
> Let me rephrase: Is there any practical value of invoking any more
> callbacks if one of them has failed?  If so, what is it?
> 
> You are changing semantics from "abort on the first failure" to
> "process everything and count errors".  That's quite a bit different
> and I'm trying to understand why the latter is better.
> 

Agreed, it is a shift in semantics.

The practical value to me is being able to use acpi_parse_entries_array() to
solve a broader range of problems.  The situation I have is that I need to
count three different subtable types in the MADT.  I could call
acpi_table_parse_madt() three different times, or I could call
acpi_parse_entries_array() once -- it seemed to me the second makes for cleaner
code and will be slightly more efficient (one map/unmap of the table, vs
three), but that only works if all of the subtables are traversed.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
