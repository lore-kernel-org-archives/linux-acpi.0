From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH] ACPI/Power: Check physical device's runtime pm status
 before requesting to resume it
Date: Thu, 17 Oct 2013 09:02:34 +0800
Message-ID: <525F372A.5070807@intel.com>
References: <1381479385-1614-1-git-send-email-tianyu.lan@intel.com> <16284735.7LFgSiThhv@vostro.rjw.lan> <525E5BBD.5030108@intel.com> <4608605.e0aa4PbnhL@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:22026 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760887Ab3JQBM5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 16 Oct 2013 21:12:57 -0400
In-Reply-To: <4608605.e0aa4PbnhL@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Lan Tianyu <lantianyu1986@gmail.com>, Aaron Lu <aaron.lu@intel.com>

On 2013=E5=B9=B410=E6=9C=8816=E6=97=A5 20:42, Rafael J. Wysocki wrote:
> On Wednesday, October 16, 2013 05:26:21 PM Lan Tianyu wrote:
>> This is a multi-part message in MIME format.
>> --------------090400010209000300030201
>> Content-Type: text/plain; charset=3DUTF-8
>> Content-Transfer-Encoding: 8bit
>>
>> On 10/16/2013 05:22 AM, Rafael J. Wysocki wrote:
>>> On Tuesday, October 15, 2013 04:58:28 PM Lan Tianyu wrote:
>>>> On 2013=C3=A5=C2=B9=C2=B410=C3=A6=C2=9C=C2=8811=C3=A6=C2=97=C2=A5 =
19:19, Rafael J. Wysocki wrote:
>>>>> On Friday, October 11, 2013 04:16:25 PM tianyu.lan@intel.com
>>>>> wrote:
>>>>>> From: Lan Tianyu <tianyu.lan@intel.com>
>>>>>>
>>>>>> Currently, when one power resource is turned on, devices owning
>>>>>> it will be requested to resume regardless of their runtime pm
>>>>>> status. ACPI power resource maybe turn on in some devices'
>>>>>> runtime pm resume callback(E.G, usb port) while turning on the
>>>>>> power resource will trigger one new resume request of the
>>>>>> device. It causes infinite loop between resume and suspend.
>>>>>> This has happened on clearing usb port's PM Qos NO_POWER_OFF
>>>>>> flag twice. This patch is to add check of physical device's
>>>>>> runtime pm status and request resume if the device is
>>>>>> suspended.
>>>>>>
>>>>>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com> ---
>>>>>> drivers/acpi/power.c | 6 ++++-- 1 file changed, 4
>>>>>> insertions(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c index
>>>>>>  0dbe5cd..228c138 100644 --- a/drivers/acpi/power.c +++
>>>>>> b/drivers/acpi/power.c @@ -250,8 +250,10 @@ static void
>>>>>> acpi_power_resume_dependent(struct work_struct *work)
>>>>>>
>>>>>> mutex_lock(&adev->physical_node_lock);
>>>>>>
>>>>>> -	list_for_each_entry(pn, &adev->physical_node_list, node) -
>>>>>> pm_request_resume(pn->dev); +	list_for_each_entry(pn,
>>>>>> &adev->physical_node_list, node) { +		if
>>>>>> (pm_runtime_suspended(pn->dev)) + pm_request_resume(pn->dev);
>>>>>> + }
>>>>>
>>>>> This is racy, because the status may change right after you check
>>>>> it and before you call pm_request_resume().
>>>>
>>>> Yes, the runtime status may be changed just after the check.
>>>>
>>>>>
>>>>> Besides, pm_request_resume() checks the status of the device and
>>>>>  won't try to resume it if it is not suspended.
>>>>>
>>>>
>>>> For this issue, usb port is in the RPM_SUSPENDING state when
>>>> pm_request_resume() is called.
>>>
>>> Why exactly does that happen?
>>>
>>>> The deferred_resume will be set to true during this procedure and
>>>> trigger resume after finishing suspend. USB port runtime resume
>>>> callback will turn on its power resource again and the work of
>>>> acpi_power_resume_dependent() is scheduled. Because the usb port's
>>>>  usage count remains zero, it's to be suspended soon. When
>>>> pm_request_resume() of acpi_power_resume_dependent() is called, th=
e
>>>> usb port is always in the PRM_SUSPENDING. Fall in the loop of
>>>> suspend and resume.
>>>>
>>>> How about running acpi_power_dependent when turning on power
>>>> resource rather than scheduling a work to run it?
>>>
>>> Is this actually going to help?  Even if
>>> acpi_power_resume_dependent() is run synchronously from within the
>>> resume callback, it will still see RPM_SUSPENDING as the device's
>>> status, won't it?
>>>
>>>> After this, pm_request_resume() can check device's right status
>>>> just after turning on power resource.
>>>
>>> The status doesn't change until the .runtime_suspend() callback
>>> returns and running pm_request_resume() syncrhonously from that
>>> callback for the device being suspended just plain doesn't make
>>> sense.
>>>
>>>
>>> Can you please explain to me how this is possible that the USB port=
's
>>> power resource is turned "on" while the port is RPM_SUSPENDING?
>>>
>> [This mail seems not to be sent to maillist. So resend. Try again
>> Sorry for noise]
>>
>>
>> Hi Rafael:
>>
>> No, I mean the acpi_power_resume_dependent() is running while the po=
rt's
>> status is RPM_SUSPENDING. It runs from a work item and turning on po=
wer
>> resource adds the work to workqueue. There is a timeslot between run=
ning
>> acpi_power_resume_dependent() and turning on power resource. In the
>> timeslot, the device runtime pm status maybe change.
>>
>> In this case, changing PM Qos flag will do pm_runtime_get_sync and
>> pm_runtime_put usb port. The usb port is without device attached and=
 so
>> it will be resumed and suspended soon during changing PM Qos flag.
>>
>> Resume callback turns on power resource if NO_POWER_OFF flag has bee=
n
>> cleared and add the work of acpi_power_resume_dependent() to
>> workqueue. After resume, the usb port will be suspended while the
>> acpi_power_resume_dependent() is running. pm_request_resume() gets
>> RPM_SUSPENDING as the usb port's runtime status and set the
>> deferred_resume of usb port.
>>
>> After suspend, usb port will be resumed again and turn on power
>> resource. The work of acpi_power_resume_dependent() is also added to
>> workqueue. Because the usb port's usage count remains 0 during this
>> procedure. it will be suspended soon after resume. While suspending,
>> acpi_power_resume_dependent() is running and pm_request_resume()
>> sets deferred_resume again. The infinite look starts.
>=20
> So the problem is that the whole thing is racy.  There is no guarante=
e
> that the power resource will not be turned off after the
> acpi_power_get_inferred_state() check in acpi_power_resume_dependent(=
)
> and before rpm_resume() queued by the pm_request_resume() called from
> there runs.  Playing with the time windows doesn't make that race go =
away.
>=20
> If we did what you suggested, the race still would be there, because =
the
> queued up resume may still run after the power resource has been turn=
ed off.

Yes, the queued up resume will run after the power resource has been
turned off but normally the resume should try to turn on the power
resource before doing some hardware related operations. If so, there
will not be problem, right?

>=20
> Unfortunately, I don't see how we can fix this race in a satisfactory=
 way
> and I'm starting to think that the whole resuming of dependent device=
s may
> be a bad idea.
>=20
> IIRC, the original concern was that devices may end up in D0-uninitia=
lized
> if we don't do that, but then whoever turned the power resource on wi=
ll
> probably turn if off at one point anyway, so they will be in that sta=
te
> temporarily.  In other words, in addition to the fact that this is ra=
cy,
> there even is no reason to do it.
>=20
> I'll send a patch to rip off that stuff later today.
>=20
> Thanks,
> Rafael
>=20


--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
