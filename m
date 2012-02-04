From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [RFC PATCH v4 1/4] cpuidle: Add time keeping and irq enabling
Date: Sat, 4 Feb 2012 14:06:15 -0800
Message-ID: <CAJOA=zOhKtt5GohHfYp6=xVTODR2a_RGkDNTwozbusrBSsqE+w@mail.gmail.com>
References: <1328065215-28108-1-git-send-email-rob.lee@linaro.org>
 <1328065215-28108-2-git-send-email-rob.lee@linaro.org> <CAMbhsRQxgvRN0skteFxeDBqmUArTa3wu2uZPqowDnBTSWuqScg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from na3sys009aog118.obsmtp.com ([74.125.149.244]:48438 "EHLO
	na3sys009aog118.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751024Ab2BDWGg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 4 Feb 2012 17:06:36 -0500
In-Reply-To: <CAMbhsRQxgvRN0skteFxeDBqmUArTa3wu2uZPqowDnBTSWuqScg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Colin Cross <ccross@google.com>
Cc: Robert Lee <rob.lee@linaro.org>, nicolas.pitre@linaro.org, linaro-dev@lists.linaro.org, nicolas.ferre@atmel.com, linux@arm.linux.org.uk, khilman@ti.com, kgene.kim@samsung.com, daniel.lezcano@linaro.org, magnus.damm@gmail.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, patches@linaro.org, arnd.bergmann@linaro.org, len.brown@intel.com, linux-pm@vger.kernel.org, nsekhar@ti.com, s.hauer@pengutronix.de, Baohua.Song@csr.com, vincent.guittot@linaro.org, linux@maxim.org.za, shawn.guo@freescale.com, deepthi@linux.vnet.ibm.com, broonie@opensource.wolfsonmicro.com, amit.kucheria@linaro.org, amit.kachhap@linaro.org

On Sat, Feb 4, 2012 at 11:02 AM, Colin Cross <ccross@google.com> wrote:
> On Tue, Jan 31, 2012 at 7:00 PM, Robert Lee <rob.lee@linaro.org> wrot=
e:
>> Make necessary changes to add implement time keepign and irq enablin=
g
> keeping
>> in the core cpuidle code. =A0This will allow the remove of these
>> functionalities from the platform cpuidle implementations.
>>
>> Signed-off-by: Robert Lee <rob.lee@linaro.org>
>> ---
>> =A0drivers/cpuidle/cpuidle.c | =A0 75 ++++++++++++++++++++++++++++++=
+++++---------
>> =A0include/linux/cpuidle.h =A0 | =A0 26 ++++++++++-----
>> =A02 files changed, 76 insertions(+), 25 deletions(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index 59f4261..8ea0fc3 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
>> @@ -57,14 +57,18 @@ static int __cpuidle_register_device(struct cpui=
dle_device *dev);
>> =A0* cpuidle_idle_call - the main idle loop
>> =A0*
>> =A0* NOTE: no locks or semaphores should be used here
>> + * NOTE: Should only be called from a local irq disabled context
>> =A0* return non-zero on failure
>> + *
>> =A0*/
>> =A0int cpuidle_idle_call(void)
>> =A0{
>> =A0 =A0 =A0 =A0struct cpuidle_device *dev =3D __this_cpu_read(cpuidl=
e_devices);
>> =A0 =A0 =A0 =A0struct cpuidle_driver *drv =3D cpuidle_get_driver();
>> =A0 =A0 =A0 =A0struct cpuidle_state *target_state;
>> - =A0 =A0 =A0 int next_state, entered_state;
>> + =A0 =A0 =A0 int idx, ret =3D 0;
>> + =A0 =A0 =A0 ktime_t t1, t2;
>> + =A0 =A0 =A0 s64 diff;
>>
>> =A0 =A0 =A0 =A0if (off)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
>> @@ -86,37 +90,76 @@ int cpuidle_idle_call(void)
>> =A0#endif
>>
>> =A0 =A0 =A0 =A0/* ask the governor for the next state */
>> - =A0 =A0 =A0 next_state =3D cpuidle_curr_governor->select(drv, dev)=
;
>> + =A0 =A0 =A0 idx =3D cpuidle_curr_governor->select(drv, dev);
>> +
>> + =A0 =A0 =A0 target_state =3D &drv->states[idx];
>> +
>> + =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0* Check with the device to see if it can enter this=
 state or if another
>> + =A0 =A0 =A0 =A0* state should be used.
>> + =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 if (target_state->pre_enter) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 idx =3D target_state->
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pre_enter(dev, drv, id=
x);
> Unnecessary line wrap and braces.
>
> What's the point of the pre_enter call? =A0This seems very similar to
> the prepare call that was removed in 3.2. =A0Drivers can already demo=
te

Hi Colin,

I asked Rob to re-introduce the .prepare callback (not .pre_enter).

The short version of why I requested this is so that I can experiment
with modifying wake-up latency and theshold values dynamically based
on PM QoS constraints.  For an OMAP-specific example, I'd like to see
our C-states no longer model both MPU and CORE power domains, and
instead only model the MPU.  Then when entering idle the PM QoS
constraints against the CORE power domain's wake-up latency can be
considered in the .prepare callback which will affect the C-state
parameters as well as program the CORE low power target state.

=2Epre_enter isn't really right for the above case so I'm happy for it
to be dropped, but I'll probably re-introduce something like .prepare
in the future...

Regards,
Mike

> the target state in their enter call. =A0The only thing you do betwee=
n
> pre_enter and enter is trace and account for the time. =A0Is there so=
me
> long call you don't want included in the idle time? =A0Some
> documentation would help, and you need to very clearly define the
> semantics of when post_enter gets called when pre_enter or enter
> return errors.
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
