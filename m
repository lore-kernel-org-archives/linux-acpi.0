From: Daniel Walker <danielwa@cisco.com>
Subject: Re: ACPI message loglevel not set
Date: Mon, 24 Jul 2017 16:01:45 -0700
Message-ID: <57f76eaa-fc88-0be9-a8c7-7441a7588dab@cisco.com>
References: <5b3ca2da-d4c3-c4dc-e967-eef9effaaf49@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcdn-iport-3.cisco.com ([173.37.86.74]:8970 "EHLO
        rcdn-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751864AbdGXXLJ (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Jul 2017 19:11:09 -0400
In-Reply-To: <5b3ca2da-d4c3-c4dc-e967-eef9effaaf49@cisco.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, xe-linux-external@cisco.com


Sorry, one more time to remove the html (hopefully) ..


On 07/19/2017 03:43 PM, Daniel Walker wrote:
>
>
> Hi,
>
>
> We have noticed that in this file,
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/acpi/acoutput.h
>
> There are these print macros
>
> |#define ACPI_INFO(plist) acpi_info plist #define ACPI_WARNING(plist) 
> acpi_warning plist #define ACPI_EXCEPTION(plist) acpi_exception plist 
> #define ACPI_ERROR(plist) acpi_error plist #define 
> ACPI_BIOS_WARNING(plist) acpi_bios_warning plist #define 
> ACPI_BIOS_ERROR(plist) acpi_bios_error plist |
>
> It seems that these don't translate to the appropriate Linux KERN_* 
> loglevels. We noticed this because our test group started reporting 
> these as warning messages because they print out with the default 
> loglevel (KERN_WARN) ..
>
> Is this intentional or an over site ?
>
> Thanks,
> Daniel
> || 


