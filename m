From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: Re: [PATCH v2 3/3] ACPI / button: Send "open" state after boot/resume
Date: Mon, 30 May 2016 10:10:41 +0200
Message-ID: <CAN+gG=EaTOSbkx82HCYwLOtR9b_6291obNnpokJ2PhOXD8bWHw@mail.gmail.com>
References: <cbdaec17aba78c61f466efff8883d49067f2dad5.1463472125.git.lv.zheng@intel.com>
	<cover.1464332745.git.lv.zheng@intel.com>
	<4472be3d63af1b56c2f0f7cfbccd73538dc36252.1464332745.git.lv.zheng@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:35409 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754038AbcE3IKm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 30 May 2016 04:10:42 -0400
In-Reply-To: <4472be3d63af1b56c2f0f7cfbccd73538dc36252.1464332745.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lv Zheng <lv.zheng@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Bastien Nocera:" <hadess@hadess.net>, Valdis.Kletnieks@vt.edu

On Fri, May 27, 2016 at 9:16 AM, Lv Zheng <lv.zheng@intel.com> wrote:
> Linux userspace (systemd-logind) keeps on rechecking lid state when the
> lid state is closed. If it failed to update the lid state to open after
> boot/resume, the system suspending right after the boot/resume could be
> resulted.
> Graphics drivers also uses the lid notifications to implment
> MODESET_ON_LID_OPEN option.
>
> Before the situation is improved from the userspace and from the graphics
> driver, simply send initial "open" lid state to avoid issues. After this is
> improved from the userspace and from the graphics driver, Linux kernel
> could simply revert this minimal commit.
>
> Link 1: https://lkml.org/2016/3/7/460
> Link 2: https://github.com/systemd/systemd/issues/2087
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> Cc: Bastien Nocera: <hadess@hadess.net>
> ---
>  drivers/acpi/button.c |    3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/acpi/button.c b/drivers/acpi/button.c
> index e706e4b..6e77312 100644
> --- a/drivers/acpi/button.c
> +++ b/drivers/acpi/button.c
> @@ -342,6 +342,8 @@ static int acpi_button_resume(struct device *dev)
>         struct acpi_button *button = acpi_driver_data(device);
>
>         button->suspended = false;
> +       if (button->type == ACPI_BUTTON_TYPE_LID)
> +               return acpi_lid_notify_state(device, 1);

As Valdis replied on 0/3, I don't think this is a good solution (even
temporary). Linux should not assume the current state of a input
device, and sending unconditionally 1 here is wrong. If the device is
on a docking station, you will wake up the wrong monitor and screw the
user session (and this will be a regression).

How about we simply send the current LID state stored in the ACPI?
something like calling acpi_lid_send_state() directly?

[15 min later, after writing a long email]

Well, it looks like we already have that in the kernel and for a long
time apparently.

So, I think the issue is that Microsoft does not wake up the system by
lid opening (seen in one of the comments in the mentioned bugs and by
looking at the behavior on the surface devices). It must be just
querying it's state on resume or might even not care at all until it
receives a close event.

If I read correctly, we managed to get the 3 bogus devices to a
correct state at the ACPI level (/proc/acpi/button/lid/LID0/state),
but we did not get the notification. Given that the LID state is
triggered by an ACPI operation region, there is no guarantee that the
resume of the acpi/button.c driver will be called after the region has
been updated/called.

I propose as a workaround to enable a kthread that will monitor the
lid state and update the correct value to userspace (5 sec of polling
time should be enough given that systemd checks every 20 sec).
We should probably have this workaround only for a set of known
devices, as it might just be temporary for those until the actual
underlying problem is fixed (wrong DSDT in the Surface 3 case that
doesn't notify at all, issue in the EC for the Surface Pro 1 and the
Samsung N210).

Cheers,
Benjamin


>         return 0;
>  }
>  #endif
> @@ -422,6 +424,7 @@ static int acpi_button_add(struct acpi_device *device)
>         if (error)
>                 goto err_remove_fs;
>         if (button->type == ACPI_BUTTON_TYPE_LID) {
> +               (void)acpi_lid_notify_state(device, 1);
>                 /*
>                  * This assumes there's only one lid device, or if there are
>                  * more we only care about the last one...
> --
> 1.7.10
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
