From: Glauber Costa <gcosta@redhat.com>
Subject: Re: [PATCH 4/4] remove goto statement
Date: Mon, 18 Feb 2008 23:07:54 -0300
Message-ID: <47BA39FA.7050102@redhat.com>
References: <1203368213-30528-1-git-send-email-gcosta@redhat.com> <1203368213-30528-2-git-send-email-gcosta@redhat.com> <1203368213-30528-3-git-send-email-gcosta@redhat.com> <1203368213-30528-4-git-send-email-gcosta@redhat.com> <47BA2E93.4040002@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:40428 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758008AbYBSCPt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 18 Feb 2008 21:15:49 -0500
In-Reply-To: <47BA2E93.4040002@cn.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Li Zefan <lizf@cn.fujitsu.com>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org, andrew.grover@intel.com, paul.s.diefenbaugh@intel.com, linux@brodo.de, anil.s.keshavamurthy@intel.com, lenb@kernel.org, linux-acpi@vger.kernel.org

Li Zefan wrote:
> Glauber Costa =D0=B4=B5=C0:
>> This patch removes goto statements in favour of plain returns
>> in places that had nothing left behind that would justify
>> such construction
>> ---
>>  drivers/acpi/processor_core.c |    4 ++--
>>  1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_=
core.c
>> index 06a230a..70f62b6 100644
>> --- a/drivers/acpi/processor_core.c
>> +++ b/drivers/acpi/processor_core.c
>> @@ -651,7 +651,7 @@ static int __cpuinit acpi_processor_star
>> =20
>>  	result =3D acpi_processor_add_fs(device);
>>  	if (result)
>> -		goto end;
>> +		return result;
>> =20
>>  	status =3D acpi_install_notify_handler(pr->handle, ACPI_DEVICE_NOT=
IFY,
>>  					     acpi_processor_notify, pr);
>> @@ -675,7 +675,7 @@ #endif
>>  			"%s is registered as cooling_device%d\n",
>>  			device->dev.bus_id, cdev->id);
>>  	else
>> -		goto end;
>> +		return result;
>> =20
>>  	result =3D sysfs_create_link(&device->dev.kobj, &cdev->device.kobj=
,
>>  					"thermal_cooling");
>=20
> Seems you forgot to remove the 'end' label ?
yes, in fact, thanks for pointing.

However, the patches are as split up as I could do, and it should not
affect the others. I can re send this one, the whole series, or
whatever, depending on what the maintainer wants.

So, what's gonna be?
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
