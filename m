From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH] ACPI: Execute the _PTS method when system reboot
Date: Tue, 31 May 2016 05:59:38 -0400
Message-ID: <574D608A.1070102@redhat.com>
References: <1462772495-71113-1-git-send-email-hehy1@lenovo.com> <BCBE834BAC19744BA2C3AC4D68DBF2198D8270D9@CNMAILEX03.lenovo.com> <574429C7.3050101@redhat.com> <BCBE834BAC19744BA2C3AC4D68DBF2198D85B47D@CNMAILEX03.lenovo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43772 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750696AbcEaJ7l (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 31 May 2016 05:59:41 -0400
In-Reply-To: <BCBE834BAC19744BA2C3AC4D68DBF2198D85B47D@CNMAILEX03.lenovo.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ocean HY1 He <hehy1@lenovo.com>, "jcm@redhat.com" <jcm@redhat.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Tanaka <dtanaka@lenovo.com>, Nagananda Chumbalkar <nchumbalkar@lenovo.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "lenb@kernel.org" <lenb@kernel.org>, "wefu@redhat.com" <wefu@redhat.com>



On 05/29/2016 11:28 PM, Ocean HY1 He wrote:
>> -----Original Message-----
>> From: Prarit Bhargava [mailto:prarit@redhat.com]
>> Sent: Tuesday, May 24, 2016 6:16 PM
>> To: Ocean HY1 He; jcm@redhat.com
>> Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; David =
Tanaka;
>> Nagananda Chumbalkar; rjw@rjwysocki.net; lenb@kernel.org;
>> wefu@redhat.com
>> Subject: Re: [PATCH] ACPI: Execute the _PTS method when system reboo=
t
>>
>>
>>
>> On 05/24/2016 02:41 AM, Ocean HY1 He wrote:
>>> Hi Prarit and Jon,
>>>
>>> How do you think of this?
>>>
>>> Thanks.
>>>
>>> Ocean He / =BA=CE=BA=A3=D1=F3
>>> SW Development Dept.
>>> Beijing Design Center
>>> Enterprise Product Group
>>> Mobile: 18911778926
>>> E-mail: hehy1@lenovo.com
>>> No.6 Chuang Ye Road, Haidian District, Beijing, China 100085
>>>
>>> -----Original Message-----
>>> From: Ocean HY1 He
>>> Sent: Monday, May 16, 2016 11:04 AM
>>> To: rjw@rjwysocki.net; lenb@kernel.org
>>> Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; David
>> Tanaka; Nagananda Chumbalkar
>>> Subject: RE: [PATCH] ACPI: Execute the _PTS method when system
>> reboot
>>>
>>> To whom may concern,
>>>
>>> A Lenovo feature depends on _PTS method execution when reboot. And
>> after check the ACPI spec, I think _PTS should be exectued when rebo=
o.
>> This patch could fix the problem.
>>>
>>> Any comments of this patch? Many thanks!
>>>
>>> Ocean He / =BA=CE=BA=A3=D1=F3
>>> SW Development Dept.
>>> Beijing Design Center
>>> Enterprise Product Group
>>> Mobile: 18911778926
>>> E-mail: hehy1@lenovo.com
>>> No.6 Chuang Ye Road, Haidian District, Beijing, China 100085
>>>
>>> -----Original Message-----
>>> From: Ocean HY1 He
>>> Sent: Monday, May 09, 2016 1:50 PM
>>> To: rjw@rjwysocki.net; lenb@kernel.org
>>> Cc: linux-acpi@vger.kernel.org; linux-kernel@vger.kernel.org; David
>> Tanaka; Ocean HY1 He; Nagananda Chumbalkar
>>> Subject: [PATCH] ACPI: Execute the _PTS method when system reboot
>>>
>>> The _PTS control method is defined in the section 7.4.1 of acpi 6.0
>>> spec. The _PTS control method is executed by the OS during the slee=
p
>>> transition process for S1, S2, S3, S4, and for orderly S5 shutdown.
>>> The sleeping state value (For example, 1, 2, 3, 4 or 5 for the S5
>>> soft-off state) is passed to the _PTS control method. This method
>>> is called after OSPM has notified native device drivers of the slee=
p
>>> state transition and before the OSPM has had a chance to fully
>>> prepare the system for a sleep state transition.
>>>
>>> The _PTS control method provides the BIOS a mechanism for performin=
g
>>> some housekeeping, such as writing the sleep type value to the
>> embedded
>>> controller, before entering the system sleeping state.
>>>
>>> According to section 7.5 of acpi 6.0 spec, _PTS should run after _T=
TS.
>>>
>>> Thus, a _PTS block notifier is added to the reboot notifier list so=
 that
>>> the _PTS object will also be evaluated when the system reboot.
>>>
>>> Signed-off-by: Ocean He <hehy1@lenovo.com>
>>> Signed-off-by: Nagananda Chumbalkar <nchumbalkar@lenovo.com>
>>> ---
>>>  drivers/acpi/sleep.c | 27 +++++++++++++++++++++++++++
>>>  1 file changed, 27 insertions(+)
>>>
>>> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
>>> index 2a8b596..8b290fb 100644
>>> --- a/drivers/acpi/sleep.c
>>> +++ b/drivers/acpi/sleep.c
>>> @@ -55,6 +55,26 @@ static struct notifier_block tts_notifier =3D {
>>>  	.priority	=3D 0,
>>>  };
>>>
>>> +static int pts_notify_reboot(struct notifier_block *this,
>>> +			unsigned long code, void *x)
>>> +{
>>> +	acpi_status status;
>>> +
>>> +	status =3D acpi_execute_simple_method(NULL, "\\_PTS",
>> ACPI_STATE_S5);
>>> +	if (ACPI_FAILURE(status) && status !=3D AE_NOT_FOUND) {
>>> +		/* It won't break anything. */
>>> +		printk(KERN_NOTICE "Failure in evaluating _PTS object\n");
>>
>> ^^^^
>> 	pr_debug("No _PTS object found.\n");
>>
>> It isn't a warning or error, so don't put the word "Failure" in ther=
e.
>>
>> Beyond that, looks entirely reasonable to me.
>>
>> P.
>>
> Hi Prarit,
>=20
> The message outputs when _PTS is found but fail to execute. I copy th=
is code
> from existed function acpi_sleep_tts_switch(). I just wants to keep n=
ew codes
> as the same style as existed codes. Make sense? ;-)

Not really.  "Failure" is something that QE groups look for when testin=
g,
debugging, or verifying.  This message implies something went wrong whe=
n the
_PTS object is an optional implementation of ACPI.

P.

>=20
> Ocean.
>>
>>> +	}
>>> +
>>> +	return NOTIFY_DONE;
>>> +}
>>> +
>>> +static struct notifier_block pts_notifier =3D {
>>> +	.notifier_call	=3D pts_notify_reboot,
>>> +	.next		=3D NULL,
>>> +	.priority	=3D 0,
>>> +};
>>> +
>>>  static int acpi_sleep_prepare(u32 acpi_state)
>>>  {
>>>  #ifdef CONFIG_ACPI_SLEEP
>>> @@ -896,5 +916,12 @@ int __init acpi_sleep_init(void)
>>>  	 * object can also be evaluated when the system enters S5.
>>>  	 */
>>>  	register_reboot_notifier(&tts_notifier);
>>> +
>>> +	/*
>>> +	 * According to section 7.5 of acpi 6.0 spec, _PTS should run aft=
er
>>> +	 * _TTS when the system enters S5.
>>> +	 */
>>> +	register_reboot_notifier(&pts_notifier);
>>> +
>>>  	return 0;
>>>  }
>>>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
