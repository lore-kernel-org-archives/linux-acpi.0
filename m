From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 3/3] ACPI: Don't create a platform_device for IOAPIC/IOxAPIC
Date: Thu, 23 Mar 2017 02:06:44 +0100
Message-ID: <CAJZ5v0i9hFPAtoHra4g4-2eZ4FH_rkQhn07g7Z-hKnrDWDPUSg@mail.gmail.com>
References: <1490204005-2733-1-git-send-email-joro@8bytes.org>
 <1490204005-2733-4-git-send-email-joro@8bytes.org> <2232546.0OJbVJtxLm@aspire.rjw.lan>
 <20170322225853.GH8329@suse.de> <CAJZ5v0jdRDsevqmXXgksX_DKBy2kSKy9q3ciVd2AOR1FgQP5gw@mail.gmail.com>
 <CAJZ5v0iLDUUtGQeBRGTrz75o71S8uYAtjVP7p4H97e7-dRZhgA@mail.gmail.com> <20170322235805.GH7266@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:34292 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbdCWBGp (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 22 Mar 2017 21:06:45 -0400
In-Reply-To: <20170322235805.GH7266@8bytes.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Joerg Roedel <jroedel@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Mar 23, 2017 at 12:58 AM, Joerg Roedel <joro@8bytes.org> wrote:
> On Thu, Mar 23, 2017 at 12:44:18AM +0100, Rafael J. Wysocki wrote:
>> On Thu, Mar 23, 2017 at 12:41 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> >
>> > It is not dead.
>> >
>> > Platform devices are actually created by it, but they never go away.
>>
>> IOW, they should never be created for anything hot-removable.
>>
>> If they are, this is a bug (as you noticed).
>
> Okay, in this case patch 2 can be omitted.
>
> But for my understanding, platform_devices created in acpi_bus_attach()
> that are not hot-removable don't take a reference to the host_bridge,
> right (at least when the host-bridge is hot-removable)?

They shouldn't.

> Otherwise this would be a leak again in case the host-bridge gets
> removed.

Right.

The main problem is that representing anything hot-removable as a
platform device is inherently fragile, as the platform bus type has no
idea whatever about things that may physically go away and platform
drivers don't expect that devices may vanish from under them in
general and so on.  Unregistration alone doesn't help much with that,
so IMO at least for now it's better to avoid using platform_device for
hot-removable stuff.

Thanks,
Rafael
