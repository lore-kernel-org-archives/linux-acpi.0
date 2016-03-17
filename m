From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/3] ACPI: move ACPI_SYSTEM_HID to acpi_drivers.h
Date: Thu, 17 Mar 2016 22:54:23 +0100
Message-ID: <CAJZ5v0hiBjU_GBZE+XeRy=xLdAXQPJQBiOhK2PaeBurjvhr+1g@mail.gmail.com>
References: <1458157022-18633-1-git-send-email-pprakash@codeaurora.org>
	<1458157022-18633-2-git-send-email-pprakash@codeaurora.org>
	<CAJZ5v0jewRqgvi7Ei939ddafnNJEQw+cv2cjGWrFNK2pZ0-2rQ@mail.gmail.com>
	<56EAE10B.8070404@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f195.google.com ([209.85.217.195]:36458 "EHLO
	mail-lb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936894AbcCQVyZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Mar 2016 17:54:25 -0400
Received: by mail-lb0-f195.google.com with SMTP id sx8so1037753lbb.3
        for <linux-acpi@vger.kernel.org>; Thu, 17 Mar 2016 14:54:24 -0700 (PDT)
In-Reply-To: <56EAE10B.8070404@codeaurora.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Prakash, Prashanth" <pprakash@codeaurora.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, harba@codeaurora.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>

On Thu, Mar 17, 2016 at 5:53 PM, Prakash, Prashanth
<pprakash@codeaurora.org> wrote:
> Hi Rafael,
>
> On 3/16/2016 7:50 PM, Rafael J. Wysocki wrote:
>>  #include "internal.h"
>> @@ -22,7 +24,6 @@ ACPI_MODULE_NAME("scan");
>>  extern struct acpi_device *acpi_root;
>>
>>  #define ACPI_BUS_CLASS                 "system_bus"
>> -#define ACPI_BUS_HID                   "LNXSYBUS"
>> No.
>>
>> This is not a valid device ID and should never be used as such.
> Section 5.6.6 in ACPI 6.1 is defining the notification value for the graceful
> shutdown request as a ACPI device specific value(0x81) and it is targeting
> the system bus(\_SB), so we took the current approach of creating a sybus
> driver to handle the notifications targeting the system bus.
>
> Let me go through the code again and see if we can avoid using the
> ACPI_BUS_HID.

You can.

> In the meantime, if you have any specific thoughts on
> how this should be handled, please let us know.

Your goal is relatively simple.  You want to register a notify handler
for the \_SB object.  You don't need a driver for that, because the
\_SB object is always present, so you don't need to enumerate it or
wait for it to show up etc.

I'd just scan the namespace 1 level below the root and install the
handler for the object with the matching name (not a fake device ID).

Thanks,
Rafael
