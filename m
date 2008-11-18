From: Shan Wei <shanwei@cn.fujitsu.com>
Subject: Re: [Bugme-new] [Bug 12056] New: the serial device(ttyS0) is unuseable
 after booting the kernel
Date: Tue, 18 Nov 2008 11:04:15 +0800
Message-ID: <492230AF.6050200@cn.fujitsu.com>
References: <bug-12056-10286@http.bugzilla.kernel.org/> <20081117185309.68d19017.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:59489 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1751867AbYKRDOE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Nov 2008 22:14:04 -0500
In-Reply-To: <20081117185309.68d19017.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yasunori Goto <y-goto@jp.fujitsu.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, Zhao Yakui <yakui.zhao@intel.com>, Li Shaohua <shaohua.li@intel.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>, bugme-daemon@bugzilla.kernel.org

=E4=BA=94=E5=B3=B6=E6=AE=BF

  Forward the mail to you.
  If i miss something, welcome you comment.


Andrew Morton says:
> (switched to email.  Please respond via emailed reply-to-all, not via=
 the
> bugzilla web interface).
>=20
> On Mon, 17 Nov 2008 18:44:44 -0800 (PST) bugme-daemon@bugzilla.kernel=
=2Eorg wrote:
>=20
>> http://bugzilla.kernel.org/show_bug.cgi?id=3D12056
>>
>>            Summary: the serial device(ttyS0) is unuseable after boot=
ing the
>>                     kernel
>>            Product: ACPI
>>            Version: 2.5
>>      KernelVersion: 2.6.28-rc3
>>           Platform: All
>>         OS/Version: Linux
>>               Tree: Mainline
>>             Status: NEW
>>           Severity: blocking
>>           Priority: P1
>>          Component: ACPICA-Core
>>         AssignedTo: acpi_acpica-core@kernel-bugs.osdl.org
>>         ReportedBy: shanwei@cn.fujitsu.com
>>
>>
>> Latest working kernel version:2.6.28-rc3
>> Earliest failing kernel version:2.6.28-rc1
>> Distribution:
>> Hardware Environment:fujitsu's PG
>> Software Environment:
>> Problem Description:
>>
>>   When i switch to the kernel of 2.6.28-rc3, the serial device=20
>> (ttyS0) is unused. But on 2.6.27, it's ok.=20
>>
>> On 2.6.28-rc3:
>> [root@DaVid compiler]# setserial /dev/ttyS0
>> /dev/ttyS0, UART: unknown, Port: 0x03f8, IRQ: 4
>>
>> On 2.6.27:
>> [root@DaVid compiler]# setserial /dev/ttyS0
>> /dev/ttyS0, UART: 16550A, Port: 0x03f8, IRQ: 4
>>
>>   The problem comes from this patch 39a0ad871000d2a016a4fa113a6e53d2=
2aabf25d___
>> For the device that is not present but functional, it unload the dri=
ver for the
>> device.=20
>>   In the following patch, I try to fix it whthout check the present =
bit when
>> adding device. After applied the patch, the serial device is useable=
 again.
>>
>> diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
>> index 383e47c..bcc731b 100644
>> --- a/drivers/pnp/pnpacpi/core.c
>> +++ b/drivers/pnp/pnpacpi/core.c
>> @@ -154,7 +154,7 @@ static int __init pnpacpi_add_device(struct acpi=
_device
>> *device)
>>          */
>>         status =3D acpi_get_handle(device->handle, "_CRS", &temp);
>>         if (ACPI_FAILURE(status) || !ispnpidacpi(acpi_device_hid(dev=
ice)) ||
>> -           is_exclusive_device(device) || (!device->status.present)=
)
>> +           is_exclusive_device(device))
>>                 return 0;
>>
>>         dev =3D pnp_alloc_dev(&pnpacpi_protocol, num, acpi_device_hi=
d(device));
>>
>> Steps to reproduce:
>> 1)build the kernel of 2.6.28-rc3;
>> 2)check the device with ___setserial /dev/ttyS0___
>>
>>
>=20
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
