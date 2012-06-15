From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH 2/3] USB/ACPI: Add usb port's acpi power control in the
 xhci PORT_POWER feature request process.
Date: Fri, 15 Jun 2012 15:05:28 +0800
Message-ID: <4FDADEB8.6080609@intel.com>
References: <1339381474-17413-1-git-send-email-tianyu.lan@intel.com> <1339381474-17413-3-git-send-email-tianyu.lan@intel.com> <20120613193038.GA6312@kroah.com> <4FD99142.4010403@intel.com> <20120614154445.GE17140@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:36362 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751478Ab2FOHMb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Jun 2012 03:12:31 -0400
In-Reply-To: <20120614154445.GE17140@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: lenb@kernel.org, sarah.a.sharp@linux.intel.com, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu

On 2012=E5=B9=B406=E6=9C=8814=E6=97=A5 23:44, Greg KH wrote:
> On Thu, Jun 14, 2012 at 03:22:42PM +0800, Lan Tianyu wrote:
>> On 2012=E5=B9=B406=E6=9C=8814=E6=97=A5 03:30, Greg KH wrote:
>>> On Mon, Jun 11, 2012 at 10:24:33AM +0800, Lan Tianyu wrote:
>>>> On our developping machine, bios can provide usb port's  power con=
trol via
>>>> acpi. This patch is to provide usb port's power control way throug=
h setting
>>>> or clearing PORT_POWER feature requests. Add two functions usb_acp=
i_power_manageable()
>>>> and usb_acpi_set_power_state(). The first one is used to find whet=
her the
>>>> usb port has acpi power resource and the second is to set the powe=
r state.
>>>> They are invoked in the xhci_hub_control() where clearing or setti=
ng PORT_POWER
>>>> feature requests are processed.
>>>>
>>>> Signed-off-by: Lan Tianyu<tianyu.lan@intel.com>
>>>> ---
>>>>   drivers/usb/core/usb-acpi.c |   28 ++++++++++++++++++++++++++++
>>>>   drivers/usb/host/xhci-hub.c |   10 ++++++++++
>>>>   include/linux/usb.h         |   10 ++++++++++
>>>>   3 files changed, 48 insertions(+), 0 deletions(-)
>>>>
>>>> diff --git a/drivers/usb/core/usb-acpi.c b/drivers/usb/core/usb-ac=
pi.c
>>>> index 82c90d0..e95f26f 100644
>>>> --- a/drivers/usb/core/usb-acpi.c
>>>> +++ b/drivers/usb/core/usb-acpi.c
>>>> @@ -19,6 +19,34 @@
>>>>
>>>>   #include "usb.h"
>>>>
>>>> +bool usb_acpi_power_manageable(struct usb_device *hdev, int port1=
)
>>>> +{
>>>> +	acpi_handle port_handle;
>>>> +
>>>> +	port_handle =3D usb_get_hub_port_acpi_handle(hdev,
>>>> +		port1);
>>>> +	return port_handle ? acpi_bus_power_manageable(port_handle) : fa=
lse;
>>>
>>> Ick, I _really_ hate the ? : usage in C, please use real if stateme=
nts
>>> so that everyone can read and understand them easier.  You do that =
a lot
>>> here, please fix them all.
>>>
>> Ok. But in some places, for example
>> dev_dbg(&hdev->dev, "The power of hub port %d was set to %s\n",
>> 		port1, enable ? "enable" : "disable");
>> try to print two result. ?: is more convenient. If I use "if" statem=
ent,
>> that will be
>> if (enable)
>> 	result =3D "enable";
>> else
>> 	result =3D "disable";
>> dev_dbg(&hdev->dev, "The power of hub port %d was set to %s\n",
>> 		port1, result);
>>
>> This just looks a little complex.
>
> I understand that, which is why I didn't complain about that.  But ev=
en
> then, you could just change the line to:
> 	dev_dbg(&hdev->dev, "The power of hub port %d was set to %d\n", port=
1, enable);
> and you would be able to tell what is going on.
>
Ok. I get it.
>
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(usb_acpi_power_manageable);
>>>> +
>>>> +int usb_acpi_set_power_state(struct usb_device *hdev, int port1, =
bool enable)
>>>> +{
>>>> +	acpi_handle port_handle;
>>>> +	unsigned char state;
>>>> +	int error =3D -EINVAL;
>>>> +
>>>> +	port_handle =3D (acpi_handle)usb_get_hub_port_acpi_handle(hdev,
>>>> +		port1);
>>>> +	state =3D enable ? ACPI_STATE_D0 : ACPI_STATE_D3_COLD;
>>>> +	error =3D acpi_bus_set_power(port_handle, state);
>>>
>>> You forgot to check port_handle here.
>>>
>>> Why not call usb_acpi_power_manageable() to ensure that you can do =
this?
>>
>> In my code, usb_acpi_power_manageable() is invoked before
>> usb_acpi_set_power_state().
>
> Are you sure that all future callers will always do this?
>
>> Do you mean I should call usb_acpi_power_manageable() in the
>> usb_acpi_set_power_state()?
>
> Maybe, if it makes sense to.  But don't fail, like you currently do, =
if
> someone doesn't do that, as you aren't telling the caller that they a=
re
> required to do so.

How about to add kernel-doc to make future user notice it? On the other=
 side,
I check the acpi_bus_set_power and if the port didn't have acpi power r=
esource,
it would return error and no harm.

>
> thanks,
>
> greg k-h

--=20
Best Regards
Tianyu Lan
linux kernel enabling team
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
