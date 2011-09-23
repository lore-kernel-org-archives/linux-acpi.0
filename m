From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] acpica events: Call acpi_os_hotplug_execute on Ejection Requests
Date: Thu, 22 Sep 2011 19:08:49 -0600
Message-ID: <CAErSpo70F012EEh3TEdgK=rSst-27P-j8JxMDkcUaJGd29BnDg@mail.gmail.com>
References: <1316733417-22528-1-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-out.google.com ([216.239.44.51]:11379 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754603Ab1IWBJL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 22 Sep 2011 21:09:11 -0400
Received: from wpaz13.hot.corp.google.com (wpaz13.hot.corp.google.com [172.24.198.77])
	by smtp-out.google.com with ESMTP id p8N19BEJ024237
	for <linux-acpi@vger.kernel.org>; Thu, 22 Sep 2011 18:09:11 -0700
Received: from yxl11 (yxl11.prod.google.com [10.190.3.203])
	by wpaz13.hot.corp.google.com with ESMTP id p8N199Tl003666
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NOT)
	for <linux-acpi@vger.kernel.org>; Thu, 22 Sep 2011 18:09:10 -0700
Received: by yxl11 with SMTP id 11so3006417yxl.4
        for <linux-acpi@vger.kernel.org>; Thu, 22 Sep 2011 18:09:09 -0700 (PDT)
In-Reply-To: <1316733417-22528-1-git-send-email-prarit@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-acpi@vger.kernel.org, mjg@redhat.com

On Thu, Sep 22, 2011 at 5:16 PM, Prarit Bhargava <prarit@redhat.com> wr=
ote:
> This patch resolves a process hang in which a PCI card with a PCI-to-=
PCI
> bridge is removed via the acpiphp driver.
>
> The issue is that during the remove of the card an ACPI event occurs
> which is erroneously added the kacpi_notify_wq queue. =A0This add is =
done in
> acpi_ev_queue_notify_request() via a call to acpi_os_execute().
>
> Eventually, the event runs on the kacpi_notify_wq and the code attemp=
ts to
> remove the card. =A0During the hotplug remove of the device, the foll=
owing
> call sequence happens
>
> cleanup_p2p_bridge()
> =A0 =A0 =A0 =A0-> cleanup_bridge()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-> acpi_remove_notify_handler()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-> acpi_os_wait_events=
_complete()
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0-> flu=
sh_workqueue(kacpi_notify_wq)
>
> which is the queue we are currently executing on and the process will=
 hang.
>
> The problem is that the event is placed on the wrong queue. =A0The co=
de already
> contains a kacpi_hotplug_wq queue for hotplug events to be added to i=
n order
> to prevent hangs like this.

Ugh.  I see the issue, and I see how this patch works around it.

But I don't really like it because we're adding complexity and (I
think) extending knowledge of the special hotplug queue into the CA,
when I don't think we should have added the hotplug queue in the first
place.

I think the main reason we need the hotplug queue (added in
c02256be79a) is that we have driver .remove() methods calling
acpi_os_wait_events_complete() via acpi_remove_notify_handler().

I would argue that drivers should not be using
acpi_remove_notify_handler() in the first place.  Adding/removing
notify handlers should be done by the ACPI core itself.  The acpiphp
notify handlers (handle_hotplug_event_bridge() and
handle_hotplug_event_func()) are for bus-level, device-independent
events that should be handled not by the driver, but by the ACPI core.

Obviously, the ACPI core doesn't have hotplug support today (it has
nice "TBDs" in the EJECT_REQUEST/DEVICE_CHECK cases), so I guess all I
can do is complain without proposing a good alternative.  I hate that,
sorry :)

I think this is a very important issue and merits a Bugzilla reference
so we can revisit it in the future.

> Cc: mjg@redhat.com
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> ---
> =A0drivers/acpi/acpica/evmisc.c | =A0 13 ++++++++++---
> =A01 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/acpi/acpica/evmisc.c b/drivers/acpi/acpica/evmis=
c.c
> index d0b3318..a78aecc 100644
> --- a/drivers/acpi/acpica/evmisc.c
> +++ b/drivers/acpi/acpica/evmisc.c
> @@ -181,9 +181,16 @@ acpi_ev_queue_notify_request(struct acpi_namespa=
ce_node * node,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0notify_info->notify.value =3D (u16) no=
tify_value;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0notify_info->notify.handler_obj =3D ha=
ndler_obj;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_os_execute(OSL_NOTIFY_HAND=
LER, acpi_ev_notify_dispatch,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 notify_info);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Is this an Ejection Request? */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (notify_value =3D=3D 0x03)

Don't you want ACPI_NOTIFY_EJECT_REQUEST here instead of "0x03"?

I'm not confident that EJECT_REQUEST is the only value that might be a
problem.  For example, ACPI_NOTIFY_DEVICE_CHECK in
handle_hotplug_event_{bridge,func} () leads to acpiphp_check_bridge(),
which can also wind up calling acpi_remove_notify_handler().

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_os=
_hotplug_execute(acpi_ev_notify_dispatch,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 notify_info);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D acpi_os_exec=
ute(OSL_NOTIFY_HANDLER,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0acpi_ev_notify_dispatch,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0notify_info);
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ACPI_FAILURE(status)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0acpi_ut_delete_generic=
_state(notify_info);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> --
> 1.6.5.2
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
