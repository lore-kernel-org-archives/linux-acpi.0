From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 3/3] ACPI: Don't create a platform_device for IOAPIC/IOxAPIC
Date: Thu, 23 Mar 2017 12:19:52 +0100
Message-ID: <CAJZ5v0i_ViWrkw-reyq5zJPbDtHOOvK7BS9teneK5cmCHOazqg@mail.gmail.com>
References: <1490204005-2733-1-git-send-email-joro@8bytes.org>
 <1490204005-2733-4-git-send-email-joro@8bytes.org> <2232546.0OJbVJtxLm@aspire.rjw.lan>
 <20170322225853.GH8329@suse.de> <CAJZ5v0jdRDsevqmXXgksX_DKBy2kSKy9q3ciVd2AOR1FgQP5gw@mail.gmail.com>
 <CAJZ5v0iLDUUtGQeBRGTrz75o71S8uYAtjVP7p4H97e7-dRZhgA@mail.gmail.com>
 <20170322235805.GH7266@8bytes.org> <CAJZ5v0i9hFPAtoHra4g4-2eZ4FH_rkQhn07g7Z-hKnrDWDPUSg@mail.gmail.com>
 <20170323105029.GJ8329@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f178.google.com ([74.125.82.178]:34155 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751248AbdCWLTy (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Mar 2017 07:19:54 -0400
In-Reply-To: <20170323105029.GJ8329@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Joerg Roedel <jroedel@suse.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Joerg Roedel <joro@8bytes.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Mar 23, 2017 at 11:50 AM, Joerg Roedel <jroedel@suse.de> wrote:
> On Thu, Mar 23, 2017 at 02:06:44AM +0100, Rafael J. Wysocki wrote:
>> The main problem is that representing anything hot-removable as a
>> platform device is inherently fragile, as the platform bus type has no
>> idea whatever about things that may physically go away and platform
>> drivers don't expect that devices may vanish from under them in
>> general and so on.  Unregistration alone doesn't help much with that,
>> so IMO at least for now it's better to avoid using platform_device for
>> hot-removable stuff.
>
> Okay, thanks for the explanation. So patch 2 could be dropped, should I
> resend without that patch or do you want to pick them up from this post?

I can pick them up easily enough, thanks!

Take care,
Rafael
