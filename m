From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] acpi/video_detect: Add force_native quirk for HP Pavilion dv6
Date: Wed, 30 Nov 2016 23:31:26 +0100
Message-ID: <1881928.OixtbhRnUt@aspire.rjw.lan>
References: <20161129143216.7261-1-hdegoede@redhat.com> <20161129143216.7261-2-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:51754 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754141AbcK3WfA (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 30 Nov 2016 17:35:00 -0500
In-Reply-To: <20161129143216.7261-2-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, stable@vger.kernel.org

On Tuesday, November 29, 2016 03:32:16 PM Hans de Goede wrote:
> The HP Pavilion dv6 has a non-working acpi_video0 backlight interface
> and an intel_backlight interface which works fine. Add a force_native
> quirk for it so that the non-working acpi_video0 interface does not get
> registered.
> 
> Note that there are quite a few HP Pavilion dv6 variants, some
> woth ATI and some with NVIDIA hybrid gfx, both seem to need this
> quirk to have working backlight control. There are also some versions
> with only Intel integrated gfx, these may not need this quirk, but it
> should not hurt there.
> 
> BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1204476
> BugLink: https://bugs.launchpad.net/ubuntu/+source/linux-lts-trusty/+bug/1416940
> Cc: stable@vger.kernel.org

It's always good to say what the oldest -stable series this applies to is.

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Anyway, both [1-2/2] applied.

Thanks,
Rafael

