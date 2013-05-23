From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI:add _STA evaluating at do_acpi_find_child()
Date: Thu, 23 May 2013 02:06:59 +0200
Message-ID: <2230710.zxq3zIVHyr@vostro.rjw.lan>
References: <1369135173-4457-1-git-send-email-jeff.wu@amd.com> <CAOLK0pwfVugT+B8HEKUcEJ72Aqdmj2QMreJrcP1wBwyP+sToaA@mail.gmail.com> <CAPb2CAO9r=etC=JjqpytT3-Z+=gmFCwAa+CC6dh8BkpSgSBXPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:46459 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754052Ab3EVX6P (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 May 2013 19:58:15 -0400
In-Reply-To: <CAPb2CAO9r=etC=JjqpytT3-Z+=gmFCwAa+CC6dh8BkpSgSBXPA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jeff Wu <zlinuxkernel@gmail.com>
Cc: Lan Tianyu <lantianyu1986@gmail.com>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, lekensteyn@gmail.com, Sergio Perez <dagobertstaler@gmail.com>, shane.huang@amd.com, Aaron Lu <aaron.lwe@gmail.com>

On Wednesday, May 22, 2013 03:42:04 PM Jeff Wu wrote:
> 2013/5/22 Lan Tianyu <lantianyu1986@gmail.com>:
> > 2013/5/22 Jeff Wu <zlinuxkernel@gmail.com>:
> >> 2013/5/21 Lan Tianyu <lantianyu1986@gmail.com>:
> >>>> From: Jeff Wu <zlinuxkernel@gmail.com>
> >>>>
> >>>> Once do_acpi_find_child() found the first matching handle, it makes the acpi_get_child()
> >>>> loop stop and return the matching handle. But, at some of the platforms, a "_ADR" is
> >>>> with the multiple devices, and if one is enabled, the others will be disabled.
> >>>> Just like a case:
> >>>> Address : 0x1FFFF ; handle : SB_PCI0.SATA.DEV0
> >>>> Address : 0x1FFFF ; handle : SB_PCI0.SATA.DEV1
> >>>> Address : 0x1FFFF ; handle : SB_PCI0.SATA.DEV2
> >>>>
> >>>> If DEV0 and DEV1 are disabled and DEV2 is enabled, the target is to get DEV2 handle, but
> >>>> actually it always return the first disabled device DEV0 handle. So add a _STA evaluating
> >>>> at do_acpi_find_child() to check the device status. If the object exists, but it is disabled,
> >>>> acpi_get_child() will continue looping to get the correct handle that the object exists and
> >>>> is enabled.
> >>>>
> >>>>
> >>>> Signed-off-by: Jeff Wu <zlinuxkernel@gmail.com>
> >>>> ---
> >>>>  drivers/acpi/glue.c | 5 ++++-
> >>>>  1 file changed, 4 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/acpi/glue.c b/drivers/acpi/glue.c
> >>>> index 40a84cc..ace6c2e 100644
> >>>> --- a/drivers/acpi/glue.c
> >>>> +++ b/drivers/acpi/glue.c
> >>>> @@ -81,11 +81,14 @@ static struct acpi_bus_type *acpi_get_bus_type(struct device *dev)
> >>>>  static acpi_status do_acpi_find_child(acpi_handle handle, u32 lvl_not_used,
> >>>>                                       void *addr_p, void **ret_p)
> >>>>  {
> >>>> -       unsigned long long addr;
> >>>>         acpi_status status;
> >>>> +       unsigned long long addr = 0, sta = 0;
> >>>>
> >>>>         status = acpi_evaluate_integer(handle, METHOD_NAME__ADR, NULL, &addr);
> >>>>         if (ACPI_SUCCESS(status) && addr == *((u64 *)addr_p)) {
> >>>> +               status = acpi_bus_get_status_handle(handle, &sta);
> >>>> +               if (ACPI_SUCCESS(status) && !(sta & ACPI_STA_DEVICE_ENABLED))
> >>>> +                       return AE_CTRL_DEPTH;
> >>> Will this affect other devices? Since the device maybe disabled during
> >>> do binding with ACPI.
> >>> After some operations, the device would be enabled.
> >> At our platforms, DEV1 use for win8,DEV2 use for win7,DEV1 use for Linux.
> >> If these devices are disabled when do init, they will always be
> >> disabled ,so, work fine.
> >>
> >> At some of the platforms, the devices may be disabled during do the
> >> first binding ,if their status are changed,do they not do re-binding ?
> > Currently, the glue binding operation takes place when the device  is
> > created. In my mind, there is no re-binding operation after the device being
> > created, Unless the device being removed and created again.
> Thank you very much.
> So, as your suggestion, it is a better solution to add a new function
> for the same _ADR devices,

I don't really think this is a good idea, because then it won't be clear when
to use which version.

Your patch kind of makes sense (although we don't need to initialize both
local variables to 0), but the Tianyu's concern is valid in principle either.

Perhaps it would be better to make do_acpi_find_child() return the disabled
device if its the only one matching or the first enabled matching device
otherwise?

Rafael


> >>> Hi Rafael:
> >>>                  How about add a new function
> >>> "acpi_get_children_with_same_addr" to return a list
> >>> which contains all these child devices with same _ADR.And then do some
> >>> special check in the specific
> >>> bus glue callback. Since these cases are no common.
> >>>
> >>>>                 *ret_p = handle;
> >>>>                 return AE_CTRL_TERMINATE;
> >>>>         }
> >>>> --
> >>>> 1.8.1.2
> >>>>
> >>>>
> >>>> --
> >>>> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> >>>> the body of a message to majordomo@vger.kernel.org
> >>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >>>
> >>>
> >>>
> >>> --
> >>> Best regards
> >>> Tianyu Lan
> >
> >
> >
> > --
> > Best regards
> > Tianyu Lan
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
