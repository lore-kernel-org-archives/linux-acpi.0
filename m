From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH v6 4/8] usb: add runtime pm support for usb port device
Date: Tue, 22 Jan 2013 11:30:07 +0800
Message-ID: <50FE07BF.6070209@intel.com>
References: <1358777887-2656-1-git-send-email-tianyu.lan@intel.com> <1358777887-2656-5-git-send-email-tianyu.lan@intel.com> <20130121212459.GA20083@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:52201 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756395Ab3AVDbz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Jan 2013 22:31:55 -0500
In-Reply-To: <20130121212459.GA20083@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: lenb@kernel.org, sarah.a.sharp@linux.intel.com, stern@rowland.harvard.edu, rjw@sisk.pl, oneukum@suse.de, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org

On 2013=E5=B9=B401=E6=9C=8822=E6=97=A5 05:24, Greg KH wrote:
> On Mon, Jan 21, 2013 at 10:18:03PM +0800, Lan Tianyu wrote:
>> This patch is to add runtime pm callback for usb port device.
>> Set/clear PORT_POWER feature in the resume/suspend callbak.
>> Add portnum for struct usb_port to record port number. Do
>> pm_rumtime_get_sync/put(portdev) when a device is plugged/unplugged
>> to prevent it from being powered off when it is active.
>>
>> Acked-by: Alan Stern <stern@rowland.harvard.edu>
>> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>> ---
>>  drivers/usb/core/hub.c  |   18 ++++++++++++++++++
>>  drivers/usb/core/hub.h  |    4 ++++
>>  drivers/usb/core/port.c |   45 ++++++++++++++++++++++++++++++++++++=
+++++++++
>>  3 files changed, 67 insertions(+)
>>
>> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
>> index 29ca6ed..8c1f9a5 100644
>> --- a/drivers/usb/core/hub.c
>> +++ b/drivers/usb/core/hub.c
>> @@ -714,6 +714,18 @@ static void hub_tt_work(struct work_struct *wor=
k)
>>  	spin_unlock_irqrestore (&hub->tt.lock, flags);
>>  }
>> =20
>> +int usb_hub_set_port_power(struct usb_device *hdev, int port1,
>> +		bool set)
>=20
> As this is a new global USB function, please provide the proper
> kerneldoc comments describing what it does.
>=20
OK. I will add later and actually the function will be only used in the
driver/usb/core/hub.c and port.c.
> thanks,
>=20
> greg k-h
>=20


--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
