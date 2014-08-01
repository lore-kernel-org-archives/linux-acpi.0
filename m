From: Lan Tianyu <tianyu.lan@intel.com>
Subject: Re: [PATCH] ACPI/Processor: Add CPU_STARTING_FROZEN check in the
 acpi_cpu_soft_notify()
Date: Fri, 01 Aug 2014 10:51:46 +0800
Message-ID: <53DB00C2.2040500@intel.com>
References: <1406798426-16483-1-git-send-email-tianyu.lan@intel.com> <1560513.OlLhy0HTTU@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1560513.OlLhy0HTTU@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Chen, Gong" <gong.chen@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

On 2014=E5=B9=B408=E6=9C=8801=E6=97=A5 05:20, Rafael J. Wysocki wrote:
> On Thursday, July 31, 2014 05:20:26 PM Lan Tianyu wrote:
>> The callback of CPU_STARTING event can't sleep and so acpi_cpu_soft_=
notify()
>> return directly when CPU_STARTING event is triggered. But cpu hotplu=
g also
>> happens during S2RAM. The action will become CPU_STARTING_FROZEN. Th=
is
>> patch is to fix missing check the frozen event.
>>
>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>=20
> There is work to restructure the handling of CPU_TASKS_FROZEN under w=
ay
> and Chen Gong is driving it.  That's likely to conflict with the last
> two patches from you.  Can you please coordinate with Gong?

Hi Rafael:

Thanks for reminder. I just checked Chen Gong's patchset "Gloabl CPU
Hot-plug flag _FROZEN Clean up". There is no conflict between our
patches. Gong's patch is to remove the following macro.

CPU_ONLINE_FROZEN
CPU_UP_PREPARE_FROZEN
CPU_UP_CANCELED_FROZEN
CPU_DOWN_PREPARE_FROZEN
CPU_DOWN_FAILED_FROZEN
CPU_DEAD_FROZEN
CPU_DYING_FROZEN
CPU_STARTING_FROZEN

CPU_TASKS_FROZEN is still available and the CPU events during S2RAM
are still (CPU_xxx | CPU_TASKS_FROZEN).

BTW, this is a bug fix from my opinion and it should be backported to
stable tree.

>=20
> Rafael
>=20
>=20
>> ---
>>  drivers/acpi/processor_driver.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/processor_driver.c b/drivers/acpi/processo=
r_driver.c
>> index 4fcbd67..66e2249 100644
>> --- a/drivers/acpi/processor_driver.c
>> +++ b/drivers/acpi/processor_driver.c
>> @@ -125,7 +125,7 @@ static int acpi_cpu_soft_notify(struct notifier_=
block *nfb,
>>  	 * CPU_STARTING and CPU_DYING must not sleep. Return here since
>>  	 * acpi_bus_get_device() may sleep.
>>  	 */
>> -	if (action =3D=3D CPU_STARTING || action =3D=3D CPU_DYING)
>> +	if ((action & ~CPU_TASKS_FROZEN) =3D=3D CPU_STARTING || action =3D=
=3D CPU_DYING)
>>  		return NOTIFY_DONE;
>> =20
>>  	if (!pr || acpi_bus_get_device(pr->handle, &device))
>>
>=20


--=20
Best regards
Tianyu Lan
