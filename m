From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 3/3] ACPI: Don't create a platform_device for
 IOAPIC/IOxAPIC
Date: Thu, 23 Mar 2017 00:58:05 +0100
Message-ID: <20170322235805.GH7266@8bytes.org>
References: <1490204005-2733-1-git-send-email-joro@8bytes.org>
 <1490204005-2733-4-git-send-email-joro@8bytes.org>
 <2232546.0OJbVJtxLm@aspire.rjw.lan>
 <20170322225853.GH8329@suse.de>
 <CAJZ5v0jdRDsevqmXXgksX_DKBy2kSKy9q3ciVd2AOR1FgQP5gw@mail.gmail.com>
 <CAJZ5v0iLDUUtGQeBRGTrz75o71S8uYAtjVP7p4H97e7-dRZhgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:42398 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751184AbdCVX6I (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 22 Mar 2017 19:58:08 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iLDUUtGQeBRGTrz75o71S8uYAtjVP7p4H97e7-dRZhgA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Joerg Roedel <jroedel@suse.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Mar 23, 2017 at 12:44:18AM +0100, Rafael J. Wysocki wrote:
> On Thu, Mar 23, 2017 at 12:41 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > It is not dead.
> >
> > Platform devices are actually created by it, but they never go away.
> 
> IOW, they should never be created for anything hot-removable.
> 
> If they are, this is a bug (as you noticed).

Okay, in this case patch 2 can be omitted.

But for my understanding, platform_devices created in acpi_bus_attach()
that are not hot-removable don't take a reference to the host_bridge,
right (at least when the host-bridge is hot-removable)?

Otherwise this would be a leak again in case the host-bridge gets
removed.


	Joerg

