From: Josh Boyer <jwboyer@fedoraproject.org>
Subject: Re: Removal of EXPORT_SYMBOL(acpi_os_wait_events_complete) in 3.13
Date: Tue, 17 Dec 2013 12:07:35 -0500
Message-ID: <CA+5PVA72hyt3uX8MSia2NWuxOdi4SdjvCu3=DuQCqkmEnQA7vg@mail.gmail.com>
References: <CA+5PVA7Kj0UAsGs6TzrMYYhPhOyMKzb3Qn9FHh8fMrLDTwToog@mail.gmail.com>
	<52B082E8.8070009@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:36211 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452Ab3LQRHg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Dec 2013 12:07:36 -0500
Received: by mail-oa0-f41.google.com with SMTP id j17so6960339oag.28
        for <linux-acpi@vger.kernel.org>; Tue, 17 Dec 2013 09:07:36 -0800 (PST)
In-Reply-To: <52B082E8.8070009@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, Dec 17, 2013 at 11:59 AM, Rafael J. Wysocki
<rafael.j.wysocki@intel.com> wrote:
> On 12/12/2013 9:50 PM, Josh Boyer wrote:
>>
>> Hi Rafael,
>
>
> Hi,
>
>
>> We had a user report[1] their nvidia driver failing to load on 3.13
>> because acpi_os_wait_events_complete is no longer exported.  They
>> believe it was in error and I told them to contact you.  Just in case
>> they don't bother to do that,
>
>
> Well, they haven't so far. :-)
>
>
>>   I thought I'd send you a quick email
>> about it.  The commit in question is:
>>
>> commit 7b98118aaa5d75644c48f41fc5d0cc181e478383
>> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Date:   Thu Nov 7 01:45:40 2013 +0100
>>
>>      ACPI / hotplug: Consolidate deferred execution of ACPI hotplug
>> routines
>>
>>
>> and it doesn't mention anything about unexporting that symbol in the
>> changelog.
>
>
> It doesn't, but removing the export was intentional, because that export is
> not needed for any in-the-tree modules any more.
>
> In principle I can add the export back, but this function is supposed to be
> an internal ACPI interface and the NVidia driver is abusing it quite openly,
> so I'm not sure.  I guess I'll just send a patch for broader discussion.

Eh.  If it was an intentional then I personally wouldn't bother to put
it back just to satisfy an out-of-tree user.  Particularly one where
you have no idea what they're using it for.

josh
