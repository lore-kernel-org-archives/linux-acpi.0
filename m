From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v2 5/5] ACPI: button: Obselete acpi_lid_open() invocations
Date: Thu, 11 May 2017 12:33:02 +0200
Message-ID: <CAN+gG=G_yh77Vab_bvWxTOVHsiUm21-X8bajo14utjaCwf1x=Q@mail.gmail.com>
References: <2a779ae8c280c968b3237ac4a3d9580df7262a46.1493951798.git.lv.zheng@intel.com>
 <22b130fe0cf3fca19b0e14c69426fe36766cf2ee.1494311429.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36791 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754486AbdEKKdE (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 11 May 2017 06:33:04 -0400
Received: by mail-wm0-f65.google.com with SMTP id u65so5909142wmu.3
        for <linux-acpi@vger.kernel.org>; Thu, 11 May 2017 03:33:03 -0700 (PDT)
In-Reply-To: <22b130fe0cf3fca19b0e14c69426fe36766cf2ee.1494311429.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, intel-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org

On Tue, May 9, 2017 at 9:02 AM, Lv Zheng <lv.zheng@intel.com> wrote:
> Since notification side has been changed to always notify kernel listeners
> using _LID returning value. Now listeners needn't invoke acpi_lid_open(),
> it should use a spec suggested control method lid device usage model:
> register lid notification and use the notified value instead, which is the
> only way to ensure the value is correct for "button.lid_init_state=ignore"
> mode or other modes with "button.lid_fake_events=N" specified.
>
> This patch fixes i915 driver to drop acpi_lid_open() user. It's not
> possible to change nouveau_connector.c user using a simple way now. So this
> patch only marks acpi_lid_open() as deprecated to accelerate this process
> by indicating this change to the nouveau developers.

If  the only 2 users of acpi_lid_open() are intel and nouveau, and if
they should rely on the value stored in the input node, not the one
exported by the _LID method (which can be wrong on some platforms),
how about simply changing the implementation of acpi_lid_open() to
fetch the value from the input node directly?

Cheers,
Benjamin

>
> Cc: <intel-gfx@lists.freedesktop.org>
> Cc: <nouveau@lists.freedesktop.org>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> ---
>  drivers/acpi/button.c             | 7 ++++++-
>  drivers/gpu/drm/i915/intel_lvds.c | 2 +-
>  2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index 7ff3a75..50d7898 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -348,7 +348,12 @@ int acpi_lid_notifier_unregister(struct notifier_block *nb)
>  }
>  EXPORT_SYMBOL(acpi_lid_notifier_unregister);
>
> -int acpi_lid_open(void)
> +/*
> + * The intentional usage model is to register a lid notifier and use the
> + * notified value instead. Directly evaluating _LID without seeing a
> + * Notify(lid, 0x80) is not reliable.
> + */
> +int __deprecated acpi_lid_open(void)
>  {
>         if (!lid_device)
>                 return -ENODEV;
> diff --git a/drivers/gpu/drm/i915/intel_lvds.c b/drivers/gpu/drm/i915/intel_lvds.c
> index 9ca4dc4..8ca9080 100644
> --- a/drivers/gpu/drm/i915/intel_lvds.c
> +++ b/drivers/gpu/drm/i915/intel_lvds.c
> @@ -548,7 +548,7 @@ static int intel_lid_notify(struct notifier_block *nb, unsigned long val,
>         /* Don't force modeset on machines where it causes a GPU lockup */
>         if (dmi_check_system(intel_no_modeset_on_lid))
>                 goto exit;
> -       if (!acpi_lid_open()) {
> +       if (!val) {
>                 /* do modeset on next lid open event */
>                 dev_priv->modeset_restore = MODESET_ON_LID_OPEN;
>                 goto exit;
> --
> 2.7.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
