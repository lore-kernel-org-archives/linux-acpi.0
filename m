From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi: video: Move ACPI_VIDEO_NOTIFY_* defines to acpi/video.h
Date: Thu, 24 Nov 2016 02:27:16 +0100
Message-ID: <4010260.RhimP6FkGx@vostro.rjw.lan>
References: <20161109171556.4003-1-hdegoede@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:48484 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934630AbcKXBTa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 23 Nov 2016 20:19:30 -0500
In-Reply-To: <20161109171556.4003-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hans de Goede <hdegoede@redhat.com>
Cc: Ben Skeggs <bskeggs@redhat.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, Dave Airlie <airlied@redhat.com>, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-acpi@vger.kernel.org

On Wednesday, November 09, 2016 06:15:56 PM Hans de Goede wrote:
> acpi_video.c passed the ACPI_VIDEO_NOTIFY_* defines as type code to
> acpi_notifier_call_chain(). Move these defines to acpi/video.h so
> that acpi_notifier listeners can check the type code using these
> defines.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

I've applied this one, but I'd like to get an ACK from the DRM folks on
the second one.

Thanks,
Rafael

