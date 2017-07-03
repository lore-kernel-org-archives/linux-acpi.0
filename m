From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3 2/2] thermal: core: introduce thermal zone device mode control
Date: Mon, 3 Jul 2017 23:07:31 +0200
Message-ID: <CAJZ5v0g5pmZFWdZBVvzsUBDvOQiUi-_BCghirKOAXdgxS2Knkg@mail.gmail.com>
References: <20170703080040.13750-1-enric.balletbo@collabora.com> <20170703080040.13750-2-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:36545 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753171AbdGCVHc (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Mon, 3 Jul 2017 17:07:32 -0400
In-Reply-To: <20170703080040.13750-2-enric.balletbo@collabora.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Zhang Rui <rui.zhang@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>, Sameer Nanda <snanda@chromium.org>

On Mon, Jul 3, 2017 at 10:00 AM, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
> From: Zhang Rui <rui.zhang@intel.com>
>
> Thermal "mode" sysfs attribute is introduced to enable/disable a thermal zone,
> and .get_mode()/.set_mode() callback is introduced for platform thermal driver
> to enable/disable the hardware thermal control logic. And thermal core takes
> no action upon thermal zone enable/disable.
>
> Actually, this is not quite right because thermal core still pokes those
> disabled thermal zones occasionally, e.g. upon system resume.
>
> To fix this, a new flag 'mode' is introduced in struct thermal_zone_device
> to represent the thermal zone mode, and several decisions have been made
> based on this flag, including
> 1. check the thermal zone mode right after it's registered.
> 2. skip updating thermal zone if the zone is disabled
> 3. stop the polling timer when the thermal zone is disabled
>
> Note: basically, this patch doesn't affect the existing always-enabled
> thermal zones much, with just one exception -
> thermal zone .get_mode() must be well prepared to reflect the real thermal
> zone status upon the thermal zone registration.
>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

I'm thinking that Rui is going to push this patch himself, in which
case there's no need to resend (and you should add your sign-off to
the patch when resending it anyway).

Thanks,
Rafael
