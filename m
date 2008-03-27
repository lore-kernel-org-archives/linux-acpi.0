From: Sam Lin <itrs.lin@gmail.com>
Subject: Re: Kernel oops (2.6.24) while booting with battery inserted
Date: Fri, 28 Mar 2008 00:02:48 +0800
Message-ID: <47EBC528.1020803@gmail.com>
References: <47EB37BA.3050707@gmail.com>	 <1206630454.19236.79.camel@queen.suse.de> <1206631271.19236.86.camel@queen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.189]:49379 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757390AbYC0QDC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 27 Mar 2008 12:03:02 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1669703nfb.21
        for <linux-acpi@vger.kernel.org>; Thu, 27 Mar 2008 09:03:00 -0700 (PDT)
In-Reply-To: <1206631271.19236.86.camel@queen.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de, linux-acpi@vger.kernel.org

It's reported as:
http://bugzilla.kernel.org/show_bug.cgi?id=3D10339

If I load battery.ko lattery it still cause kernel oops and freeze.

Thanks,
Sam

Thomas Renninger =B4=A3=A8=EC:
> On Thu, 2008-03-27 at 16:07 +0100, Thomas Renninger wrote:
>  =20
>> On Thu, 2008-03-27 at 13:59 +0800, Sam Lin wrote:
>>    =20
>>> Hi List,
>>>
>>> I encountered kernel oops (Ubuntu 2.6.24-12) while booting with bat=
tery
>>> inserted.
>>> Some workaround are acpi=3Doff, avoiding loading battery.ko or putt=
ing
>>> battery away.
>>>
>>> Any idea ?
>>>      =20
>> Why do you need:
>> acpi_fake_ecdt
>> parameter? This does not even exist (anymore? I searched 2.6.25).
>>
>>    =20
>>> dmesg and dsdt as attachments.
>>>      =20
>> I expect removing the line:
>>         acpi_bus_generate_netlink_event(device->pnp.device_class,
>>                                         device->dev.bus_id, event,
>>                                         acpi_battery_present(battery=
));
>> in battery.c makes the machine work or at least go a bit further?
>>
>> Could it be that you compiled in ACPI modules and that:
>> fs_initcall(acpi_event_init);
>> in drivers/acpi/event.c
>> has not been called and initialized the netlink acpi stuff, but batt=
ery
>> has already tried to send an event?
>>    =20
> acpi_event_init should have been called already...
> I still think it has to do with the netlink event.
> As it is rather early, maybe because of that.
> Does it work for you if you load the battery module later?
>
> Can you open a bugreport on bugzilla.kernel.org, add .config and
> dmesg/acpidump you already sent and add me to CC.
>
> Thanks,
>
>    Thomas
>
>
>  =20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
