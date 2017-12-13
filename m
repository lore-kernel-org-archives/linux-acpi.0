From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPICA: Fix indentation
Date: Wed, 13 Dec 2017 23:27:08 +0100
Message-ID: <CAJZ5v0gFRa991=zs=7DoyLWzVtEBp2XqoEbmxwzgEd55Nw4Nnw@mail.gmail.com>
References: <1512750553-15467-1-git-send-email-gomonovych@gmail.com>
 <CAJZ5v0hgt8MLkxSHeN1A49p4g6VCr-r8x7RGun9eVmtx0PZKgg@mail.gmail.com> <CF6A88132359CE47947DB4C6E1709ED539668D71@ORSMSX110.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f193.google.com ([74.125.82.193]:45589 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752617AbdLMW1J (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Dec 2017 17:27:09 -0500
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED539668D71@ORSMSX110.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Schmauss, Erik" <erik.schmauss@intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Vasyl Gomonovych <gomonovych@gmail.com>, "Moore, Robert" <robert.moore@intel.com>, "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "devel@acpica.org" <devel@acpica.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Wed, Dec 13, 2017 at 10:53 PM, Schmauss, Erik
<erik.schmauss@intel.com> wrote:
>
>> -----Original Message-----
>> From: rjwysocki@gmail.com [mailto:rjwysocki@gmail.com] On Behalf Of Rafael
>> J. Wysocki
>> Sent: Friday, December 8, 2017 9:06 AM
>> To: Vasyl Gomonovych <gomonovych@gmail.com>
>> Cc: Moore, Robert <robert.moore@intel.com>; Zheng, Lv
>> <lv.zheng@intel.com>; Wysocki, Rafael J <rafael.j.wysocki@intel.com>; Len
>> Brown <lenb@kernel.org>; ACPI Devel Maling List <linux-acpi@vger.kernel.org>;
>> devel@acpica.org; Linux Kernel Mailing List <linux-kernel@vger.kernel.org>;
>> Schmauss, Erik <erik.schmauss@intel.com>
>> Subject: Re: [PATCH] ACPICA: Fix indentation
>>
>> On Fri, Dec 8, 2017 at 5:29 PM, Vasyl Gomonovych <gomonovych@gmail.com>
>> wrote:
>> > This patch avoids that smatch reports the following:
>> > drivers/acpi/acpica/exdump.c:623 acpi_ex_dump_operand() warn:
>> > inconsistent indenting
>> >
>> > Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
>>
>> This is ACPICA code, so changes like this should go in via the upstream.
>>
>
> Hi,
>> Erik may want to pick this up, however.
>>
>
> Thanks for pointing this out. I found  solution to fix the indentation issue. It will be in the next release.

Cool, thanks!
