From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/3] ACPI: fix incorrect counts returned by acpi_parse_entries_array()
Date: Fri, 1 Jul 2016 23:44:41 +0200
Message-ID: <CAJZ5v0gPn=fRNOdbbNYesWm=MArE4xRuu_tPDjCRq8ZEq9o_TA@mail.gmail.com>
References: <1467408081-7418-1-git-send-email-ahs3@redhat.com>
 <1467408081-7418-2-git-send-email-ahs3@redhat.com> <CAJZ5v0h2_uRYNC-+naQuycNUS86fNy0zO_vAXarfM006sMWEwQ@mail.gmail.com>
 <719ba3ec-4a05-6ddc-3fbc-8b6d8eab9807@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35402 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752118AbcGAVon (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 1 Jul 2016 17:44:43 -0400
In-Reply-To: <719ba3ec-4a05-6ddc-3fbc-8b6d8eab9807@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Al Stone <ahs3@redhat.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>

On Fri, Jul 1, 2016 at 11:36 PM, Al Stone <ahs3@redhat.com> wrote:
> On 07/01/2016 03:25 PM, Rafael J. Wysocki wrote:
>> On Fri, Jul 1, 2016 at 11:21 PM, Al Stone <ahs3@redhat.com> wrote:
>>> The static function acpi_parse_entries_array() is provided an array of
>>> type struct acpi_subtable_proc that has a callback function and a count.
>>> The count should reflect how many times the callback has been successfully
>>> called.  However, the current code only increments the 0th element of the
>>> array, regardless of the number of entries in the array, or which callback
>>> has been invoked.  The fix is to use the index into the array, instead of
>>> a pointer to the beginning of the array.
>>
>> OK, so it would be good to say what the consequences of the problem are too.
>>
>
> Hrm.  So replace the last sentence with something like:
>
>    The fix is to use the index into the array, instead of
>    a pointer to the beginning of the array, so that the count
>    for each element in the array in incremented by the
>    corresponding callback.
>
> That feels a little clunky but is it closer to what you were
> thinking?

Well, not really.

The code is arguably incorrect, but is there anything that does not
work as expected as a result?  Any functional breakage?  Any
misleading messages printed?
