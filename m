From: "Prakash, Prashanth" <pprakash@codeaurora.org>
Subject: Re: [PATCH 0/3] ACPI: Support for platform initiated graceful
 shutdown
Date: Tue, 10 May 2016 17:28:40 -0600
Message-ID: <57326EA8.1060806@codeaurora.org>
References: <1458157022-18633-1-git-send-email-pprakash@codeaurora.org>
 <21470c3b-c176-ef46-fc93-081d482b4cab@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:47229 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437AbcEJX2o (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 May 2016 19:28:44 -0400
In-Reply-To: <21470c3b-c176-ef46-fc93-081d482b4cab@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ahs3@redhat.com, linux-acpi@vger.kernel.org
Cc: harba@codeaurora.org, rjw@rjwysocki.net

Hi Al,

I should have v2 sometime next week.

Sorry about the delay. Vacation and couple of other issues kept me little busy and couldn't update this patch set in a timely manner.

Thanks,
Prashanth

On 5/10/2016 4:50 PM, Al Stone wrote:
> On 03/16/2016 01:36 PM, Prashanth Prakash wrote:
>> This patch-set adds support for platform initited graceful shutdown as
>> described in the sections 5.6.6(Table-143) and 6.3.5.1 of ACPI 6.1 spec
>>
>> Jonathan (Zhixiong) Zhang (1):
>>   ACPI: move ACPI_SYSTEM_HID to acpi_drivers.h
>>
>> Prashanth Prakash (2):
>>   ACPI / sybus: add a driver for LNXSYBUS device
>>   ACPI: update the definition of common notification values
>>
>>  drivers/acpi/Kconfig        |   6 +++
>>  drivers/acpi/Makefile       |   1 +
>>  drivers/acpi/scan.c         |   3 +-
>>  drivers/acpi/sybus.c        | 116 ++++++++++++++++++++++++++++++++++++++++++++
>>  include/acpi/acpi_drivers.h |   1 +
>>  include/acpi/actypes.h      |   2 +-
>>  6 files changed, 127 insertions(+), 2 deletions(-)
>>  create mode 100644 drivers/acpi/sybus.c
>>
> Is v2 coming along soon?  I'd like to try these out on a couple of
> systems.  Thanks, Prashanth.
>

