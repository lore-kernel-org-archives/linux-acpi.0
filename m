From: Li Zefan <lizf@cn.fujitsu.com>
Subject: Re: [PATCH 4/4] remove goto statement
Date: Tue, 19 Feb 2008 10:22:35 +0800
Message-ID: <47BA3D6B.20804@cn.fujitsu.com>
References: <1203368213-30528-1-git-send-email-gcosta@redhat.com> <1203368213-30528-2-git-send-email-gcosta@redhat.com> <1203368213-30528-3-git-send-email-gcosta@redhat.com> <1203368213-30528-4-git-send-email-gcosta@redhat.com> <47BA2E93.4040002@cn.fujitsu.com> <47BA39FA.7050102@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([222.73.24.84]:54838 "EHLO song.cn.fujitsu.com"
	rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1759128AbYBSCYB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 18 Feb 2008 21:24:01 -0500
In-Reply-To: <47BA39FA.7050102@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Glauber Costa <gcosta@redhat.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, andrew.grover@intel.com, paul.s.diefenbaugh@intel.com, linux@brodo.de, anil.s.keshavamurthy@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org

Glauber Costa wrote:
> Li Zefan wrote:
>> Glauber Costa =D0=B4=B5=C0:
>>> This patch removes goto statements in favour of plain returns
>>> in places that had nothing left behind that would justify
>>> such construction
>>> ---
>>>  drivers/acpi/processor_core.c |    4 ++--
>>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor=
_core.c
>>> index 06a230a..70f62b6 100644
>>> --- a/drivers/acpi/processor_core.c
>>> +++ b/drivers/acpi/processor_core.c
>>> @@ -651,7 +651,7 @@ static int __cpuinit acpi_processor_star
>>> =20
>>>  	result =3D acpi_processor_add_fs(device);
>>>  	if (result)
>>> -		goto end;
>>> +		return result;
>>> =20
>>>  	status =3D acpi_install_notify_handler(pr->handle, ACPI_DEVICE_NO=
TIFY,
>>>  					     acpi_processor_notify, pr);
>>> @@ -675,7 +675,7 @@ #endif
>>>  			"%s is registered as cooling_device%d\n",
>>>  			device->dev.bus_id, cdev->id);
>>>  	else
>>> -		goto end;
>>> +		return result;
>>> =20
>>>  	result =3D sysfs_create_link(&device->dev.kobj, &cdev->device.kob=
j,
>>>  					"thermal_cooling");
>> Seems you forgot to remove the 'end' label ?
> yes, in fact, thanks for pointing.
>=20
> However, the patches are as split up as I could do, and it should not
> affect the others. I can re send this one, the whole series, or
> whatever, depending on what the maintainer wants.
>=20
> So, what's gonna be?
>=20

IMO a revised [PATCH 4/4] will do, since it won't affect the other 3 pa=
tches :)
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
