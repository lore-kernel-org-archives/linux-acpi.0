From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH 0/3] ACPI: Support for platform initiated graceful
 shutdown
Date: Wed, 11 May 2016 14:59:21 -0600
Message-ID: <582b4ea3-ee9a-6961-a4aa-374beda10de2@redhat.com>
References: <1458157022-18633-1-git-send-email-pprakash@codeaurora.org>
 <21470c3b-c176-ef46-fc93-081d482b4cab@redhat.com>
 <57326EA8.1060806@codeaurora.org>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:36229 "EHLO
	mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751391AbcEKU7X (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 11 May 2016 16:59:23 -0400
Received: by mail-io0-f173.google.com with SMTP id i75so65359447ioa.3
        for <linux-acpi@vger.kernel.org>; Wed, 11 May 2016 13:59:23 -0700 (PDT)
In-Reply-To: <57326EA8.1060806@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Prakash, Prashanth" <pprakash@codeaurora.org>, linux-acpi@vger.kernel.org
Cc: harba@codeaurora.org, rjw@rjwysocki.net

On 05/10/2016 05:28 PM, Prakash, Prashanth wrote:
> Hi Al,
> 
> I should have v2 sometime next week.
> 
> Sorry about the delay. Vacation and couple of other issues kept me little busy and couldn't update this patch set in a timely manner.
> 
> Thanks,
> Prashanth

No worries, Prashanth.  Just curiosity, on my part.  Thanks for posting these.

> On 5/10/2016 4:50 PM, Al Stone wrote:
>> On 03/16/2016 01:36 PM, Prashanth Prakash wrote:
>>> This patch-set adds support for platform initited graceful shutdown as
>>> described in the sections 5.6.6(Table-143) and 6.3.5.1 of ACPI 6.1 spec
>>>
>>> Jonathan (Zhixiong) Zhang (1):
>>>   ACPI: move ACPI_SYSTEM_HID to acpi_drivers.h
>>>
>>> Prashanth Prakash (2):
>>>   ACPI / sybus: add a driver for LNXSYBUS device
>>>   ACPI: update the definition of common notification values
>>>
>>>  drivers/acpi/Kconfig        |   6 +++
>>>  drivers/acpi/Makefile       |   1 +
>>>  drivers/acpi/scan.c         |   3 +-
>>>  drivers/acpi/sybus.c        | 116 ++++++++++++++++++++++++++++++++++++++++++++
>>>  include/acpi/acpi_drivers.h |   1 +
>>>  include/acpi/actypes.h      |   2 +-
>>>  6 files changed, 127 insertions(+), 2 deletions(-)
>>>  create mode 100644 drivers/acpi/sybus.c
>>>
>> Is v2 coming along soon?  I'd like to try these out on a couple of
>> systems.  Thanks, Prashanth.
>>
> 


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
