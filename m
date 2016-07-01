From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH 1/3] ACPI: fix incorrect counts returned by
 acpi_parse_entries_array()
Date: Fri, 1 Jul 2016 16:38:42 -0600
Message-ID: <13b0f0eb-a027-a439-a967-08ee188c9d96@redhat.com>
References: <1467408081-7418-1-git-send-email-ahs3@redhat.com>
 <1467408081-7418-2-git-send-email-ahs3@redhat.com>
 <CAJZ5v0h2_uRYNC-+naQuycNUS86fNy0zO_vAXarfM006sMWEwQ@mail.gmail.com>
 <719ba3ec-4a05-6ddc-3fbc-8b6d8eab9807@redhat.com>
 <CAJZ5v0gPn=fRNOdbbNYesWm=MArE4xRuu_tPDjCRq8ZEq9o_TA@mail.gmail.com>
 <343f1fce-2699-2449-2965-7f00fd96ed94@redhat.com>
 <CAJZ5v0jtxbTmVxi4y-aHpuD6m095047kknfJtkN+rCtJGXWtxQ@mail.gmail.com>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:34890 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752393AbcGAWio (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Jul 2016 18:38:44 -0400
Received: by mail-io0-f176.google.com with SMTP id f30so111708372ioj.2
        for <linux-acpi@vger.kernel.org>; Fri, 01 Jul 2016 15:38:44 -0700 (PDT)
In-Reply-To: <CAJZ5v0jtxbTmVxi4y-aHpuD6m095047kknfJtkN+rCtJGXWtxQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

On 07/01/2016 03:56 PM, Rafael J. Wysocki wrote:
> On Fri, Jul 1, 2016 at 11:50 PM, Al Stone <ahs3@redhat.com> wrote:
>> On 07/01/2016 03:44 PM, Rafael J. Wysocki wrote:
>>> On Fri, Jul 1, 2016 at 11:36 PM, Al Stone <ahs3@redhat.com> wrote:
>>>> On 07/01/2016 03:25 PM, Rafael J. Wysocki wrote:
>>>>> On Fri, Jul 1, 2016 at 11:21 PM, Al Stone <ahs3@redhat.com> wrote:
>>>>>> The static function acpi_parse_entries_array() is provided an array of
>>>>>> type struct acpi_subtable_proc that has a callback function and a count.
>>>>>> The count should reflect how many times the callback has been successfully
>>>>>> called.  However, the current code only increments the 0th element of the
>>>>>> array, regardless of the number of entries in the array, or which callback
>>>>>> has been invoked.  The fix is to use the index into the array, instead of
>>>>>> a pointer to the beginning of the array.
>>>>>
>>>>> OK, so it would be good to say what the consequences of the problem are too.
>>>>>
>>>>
>>>> Hrm.  So replace the last sentence with something like:
>>>>
>>>>    The fix is to use the index into the array, instead of
>>>>    a pointer to the beginning of the array, so that the count
>>>>    for each element in the array in incremented by the
>>>>    corresponding callback.
>>>>
>>>> That feels a little clunky but is it closer to what you were
>>>> thinking?
>>>
>>> Well, not really.
>>>
>>> The code is arguably incorrect, but is there anything that does not
>>> work as expected as a result?  Any functional breakage?  Any
>>> misleading messages printed?
>>>
>>
>> That's the odd thing; there is no breakage.  Of any sort.
>>
>> But, no one relies on those values for anything at this point.  I've got a
>> couple of ideas I'm working on that are easier if it does work right, however.
> 
> That's information that should go into the changelog too.
> 
> "There are no functional consequences of the issue, but fixing it is
> necessary for future work."
> 
> Or similar.
> 

Will do in v2.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
