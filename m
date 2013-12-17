From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: Removal of EXPORT_SYMBOL(acpi_os_wait_events_complete) in 3.13
Date: Tue, 17 Dec 2013 17:59:20 +0100
Message-ID: <52B082E8.8070009@intel.com>
References: <CA+5PVA7Kj0UAsGs6TzrMYYhPhOyMKzb3Qn9FHh8fMrLDTwToog@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:58699 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753694Ab3LQQ7c (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Dec 2013 11:59:32 -0500
In-Reply-To: <CA+5PVA7Kj0UAsGs6TzrMYYhPhOyMKzb3Qn9FHh8fMrLDTwToog@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Josh Boyer <jwboyer@fedoraproject.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On 12/12/2013 9:50 PM, Josh Boyer wrote:
> Hi Rafael,

Hi,

> We had a user report[1] their nvidia driver failing to load on 3.13
> because acpi_os_wait_events_complete is no longer exported.  They
> believe it was in error and I told them to contact you.  Just in case
> they don't bother to do that,

Well, they haven't so far. :-)

>   I thought I'd send you a quick email
> about it.  The commit in question is:
>
> commit 7b98118aaa5d75644c48f41fc5d0cc181e478383
> Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Date:   Thu Nov 7 01:45:40 2013 +0100
>
>      ACPI / hotplug: Consolidate deferred execution of ACPI hotplug routines
>
>
> and it doesn't mention anything about unexporting that symbol in the changelog.

It doesn't, but removing the export was intentional, because that export 
is not needed for any in-the-tree modules any more.

In principle I can add the export back, but this function is supposed to 
be an internal ACPI interface and the NVidia driver is abusing it quite 
openly, so I'm not sure.  I guess I'll just send a patch for broader 
discussion.

Thanks,
Rafael

