From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 3/3] ACPI: Don't create a platform_device for IOAPIC/IOxAPIC
Date: Thu, 23 Mar 2017 00:44:18 +0100
Message-ID: <CAJZ5v0iLDUUtGQeBRGTrz75o71S8uYAtjVP7p4H97e7-dRZhgA@mail.gmail.com>
References: <1490204005-2733-1-git-send-email-joro@8bytes.org>
 <1490204005-2733-4-git-send-email-joro@8bytes.org> <2232546.0OJbVJtxLm@aspire.rjw.lan>
 <20170322225853.GH8329@suse.de> <CAJZ5v0jdRDsevqmXXgksX_DKBy2kSKy9q3ciVd2AOR1FgQP5gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34098 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751711AbdCVXoU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Mar 2017 19:44:20 -0400
In-Reply-To: <CAJZ5v0jdRDsevqmXXgksX_DKBy2kSKy9q3ciVd2AOR1FgQP5gw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Joerg Roedel <jroedel@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Joerg Roedel <joro@8bytes.org>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Mar 23, 2017 at 12:41 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Mar 22, 2017 at 11:58 PM, Joerg Roedel <jroedel@suse.de> wrote:
>> Hi Rafael,
>>
>> On Wed, Mar 22, 2017 at 06:42:39PM +0100, Rafael J. Wysocki wrote:
>>> On Wednesday, March 22, 2017 06:33:25 PM Joerg Roedel wrote:
>>> > From: Joerg Roedel <jroedel@suse.de>
>>> >
>>> > No platform-device is required for IO(x)APICs, so don't even
>>> > create them.
>>> >
>>> > Signed-off-by: Joerg Roedel <jroedel@suse.de>
>>>
>>> If we do this, I'd prefer not to do [2/3], because we'll introduce code that
>>> will be essentially dead then.
>>
>> In this case the code in acpi_bus_attach() adding platform_devices is also
>> dead. Could it be removed then?
>
> It is not dead.
>
> Platform devices are actually created by it, but they never go away.

IOW, they should never be created for anything hot-removable.

If they are, this is a bug (as you noticed).

Thanks,
Rafael
