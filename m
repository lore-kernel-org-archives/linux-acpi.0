From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH 1/1] ACPI: bus.c, fix error handling in acpi_bus_init
Date: Sat, 21 Feb 2009 14:05:30 +0100
Message-ID: <499FFC1A.7010906@gmail.com>
References: <1234731354-7472-1-git-send-email-jirislaby@gmail.com> <alpine.LFD.2.00.0902202352551.19156@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f161.google.com ([209.85.218.161]:35970 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753196AbZBUNFk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 21 Feb 2009 08:05:40 -0500
In-Reply-To: <alpine.LFD.2.00.0902202352551.19156@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On 21.2.2009 05:58, Len Brown wrote:
> On Sun, 15 Feb 2009, Jiri Slaby wrote:
>
>> There was a misplaced status test. Move it to correct place and
>> rollback appropriately.
>
> hmm, looks like this has been broken since the day
> acpi_os_initialize1() was invented in 2004.

It comes from bitkeeper times, I checked, it looked like a typo.

> Turns out that the bug and its fix are moot, however,
> as acpi_os_initialize1() is hard-coded to return success,
> opting for BUG_ON() if it sees a failure...

BUG_ON is not noreturn e.g. on embedded, anyway it would crash later in 
this case. I was thinking about returning a failure when one of them is 
NULL, but fell back to not do so and check only retval in the caller.

> So unless that changes, I'd prefer to keep the code
> simple and just not check its status -- which is effectively
> what we're doing right now.

Ok, no problem. Will repost.

Thanks.
