From: Rob Lee <rob.lee@linaro.org>
Subject: Re: [RFC PATCH v4 2/4] ARM: omap: Remove cpuidle timekeeping and irq enable/disable
Date: Thu, 2 Feb 2012 11:35:54 -0600
Message-ID: <CAMXH7KEURU-TETr21fU_xrdETxgiscYG4PaVcDbhevojzuQUeg@mail.gmail.com>
References: <1328065215-28108-1-git-send-email-rob.lee@linaro.org>
	<1328065215-28108-3-git-send-email-rob.lee@linaro.org>
	<CAORVsuXLPjc7X+D1jVP1KyjgUWZhtUnA3F-iz-d-DqtHRmLShA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:64633 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932740Ab2BBRfz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Feb 2012 12:35:55 -0500
In-Reply-To: <CAORVsuXLPjc7X+D1jVP1KyjgUWZhtUnA3F-iz-d-DqtHRmLShA@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: len.brown@intel.com, khilman@ti.com, nicolas.pitre@linaro.org, linaro-dev@lists.linaro.org, linux@arm.linux.org.uk, kgene.kim@samsung.com, linux-pm@vger.kernel.org, magnus.damm@gmail.com, linux-acpi@vger.kernel.org, arnd.bergmann@linaro.org, patches@linaro.org, nsekhar@ti.com, s.hauer@pengutronix.de, Baohua.Song@csr.com, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, deepthi@linux.vnet.ibm.com, broonie@opensource.wolfsonmicro.com

On Thu, Feb 2, 2012 at 10:21 AM, Jean Pihet <jean.pihet@newoldbits.com>=
 wrote:
> Rob,
>
> On Wed, Feb 1, 2012 at 4:00 AM, Robert Lee <rob.lee@linaro.org> wrote=
:
>> Now that the core cpuidle driver keeps time and handles irq enabling=
,
>> remove this functionality. =A0Also, remove irq disabling as all path=
s to
>> cpuidle_idle_call already call local_irq_disable. =A0Also, restructu=
re
>> idle functions as needed by the cpuidle core driver changes.
>>
>> Signed-off-by: Robert Lee <rob.lee@linaro.org>
>> ---
>> =A0arch/arm/mach-omap2/cpuidle34xx.c | =A0 96 ++++++++++++++++------=
--------------
>> =A01 files changed, 43 insertions(+), 53 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2=
/cpuidle34xx.c
>> index 464cffd..9ecded5 100644
>> --- a/arch/arm/mach-omap2/cpuidle34xx.c
>> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
> ...
>
>> @@ -100,23 +107,20 @@ static int omap3_enter_idle(struct cpuidle_dev=
ice *dev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struc=
t cpuidle_driver *drv,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int i=
ndex)
>> =A0{
>> - =A0 =A0 =A0 struct omap3_idle_statedata *cx =3D
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_get_statedata(=
&dev->states_usage[index]);
>> - =A0 =A0 =A0 struct timespec ts_preidle, ts_postidle, ts_idle;
>> - =A0 =A0 =A0 u32 mpu_state =3D cx->mpu_state, core_state =3D cx->co=
re_state;
>> - =A0 =A0 =A0 int idle_time;
>> + =A0 =A0 =A0 struct omap3_idle_drvdata *dd =3D dev->states_usage[in=
dex].driver_data
> A build error is triggered by the missing ";".

Argh, last minute change and I didn't build afterward.

>
> ...
>
>> @@ -147,18 +151,12 @@ static int omap3_enter_idle(struct cpuidle_dev=
ice *dev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pwrdm_for_each_clkdm(core_pd, _cpuidl=
e_allow_idle);
>> =A0 =A0 =A0 =A0}
>>
>> -return_sleep_time:
>> - =A0 =A0 =A0 getnstimeofday(&ts_postidle);
>> - =A0 =A0 =A0 ts_idle =3D timespec_sub(ts_postidle, ts_preidle);
>> -
>> - =A0 =A0 =A0 local_irq_enable();
>> +leave:
>> =A0 =A0 =A0 =A0local_fiq_enable();
>>
>> - =A0 =A0 =A0 idle_time =3D ts_idle.tv_nsec / NSEC_PER_USEC + ts_idl=
e.tv_sec * \
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USEC_PER_SEC;
>> -
>> - =A0 =A0 =A0 /* Update cpuidle counters */
>> - =A0 =A0 =A0 dev->last_residency =3D idle_time;
>> + =A0 =A0 =A0 /* Restore original PER state if it was modified */
>> + =A0 =A0 =A0 if (dd->per_next_state !=3D dd->per_saved_state)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_set_next_pwrst(per_pd, dd->per_s=
aved_state);
> This code is not necessarily balanced with the PER state change in
> omap3_enter_idle_bm (cf. "/* Are we changing PER target state? */"
> here below), since in the core cpuidle code there is no guarantee tha=
t
> the calls to pre_enter and enter callbacks are balanced.
> In general I fear that splitting the code in two functions introduces
> a risk of programming non-coherent settings in the PRCM.

Agree, in general it does introduce that new risk.  For the platform
code changes, I tried to keep the code paths the same as before.  I
see now where I created a problem though:

=2E..
	if (target_state->pre_enter) {
		idx =3D target_state->
			pre_enter(dev, drv, idx);
	}

	if (idx < 0) {
		local_irq_enable();
		return idx;
	}

	if (need_resched()) {
		local_irq_enable();
		return -EBUSY;
	}

=2E..

The only way the core cpuidle pre_enter can get called without enter
without enter is if the omap3 next_valid_state() returned a negative
value.  If this ever happened in the existing omap3 code, it would
cause it to break anyway.  But, this particular need_resched() call
could cause an exit that results in difference behavior than before.
One solution to that is just to move the need_resched check before the
pre_enter call.

>
> ...
>
>> @@ -255,8 +255,9 @@ static int omap3_enter_idle_bm(struct cpuidle_de=
vice *dev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int inde=
x)
>> =A0{
>> =A0 =A0 =A0 =A0int new_state_idx;
>> - =A0 =A0 =A0 u32 core_next_state, per_next_state =3D 0, per_saved_s=
tate =3D 0, cam_state;
>> - =A0 =A0 =A0 struct omap3_idle_statedata *cx;
>> + =A0 =A0 =A0 u32 core_next_state, cam_state;
>> + =A0 =A0 =A0 struct omap3_idle_drvdata *dd =3D dev->states_usage[in=
dex].driver_data;
>> + =A0 =A0 =A0 struct omap3_idle_statedata *cx =3D &dd->state_data[in=
dex];
>> =A0 =A0 =A0 =A0int ret;
> The build throws a few warnings about unused variables:
>
> arch/arm/mach-omap2/cpuidle34xx.c: In function 'omap3_enter_idle_bm':
> arch/arm/mach-omap2/cpuidle34xx.c:261: warning: unused variable 'ret'
> arch/arm/mach-omap2/cpuidle34xx.c:257: warning: unused variable 'new_=
state_idx'
>
> ...
>

Got it, not sure why I missed this.

>>
>> =A0DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
>> @@ -337,7 +329,8 @@ static inline void _fill_cstate(struct cpuidle_d=
river *drv,
>> =A0 =A0 =A0 =A0state->exit_latency =A0 =A0 =3D cpuidle_params_table[=
idx].exit_latency;
>> =A0 =A0 =A0 =A0state->target_residency =3D cpuidle_params_table[idx]=
=2Etarget_residency;
>> =A0 =A0 =A0 =A0state->flags =A0 =A0 =A0 =A0 =A0 =A0=3D CPUIDLE_FLAG_=
TIME_VALID;
>> - =A0 =A0 =A0 state->enter =A0 =A0 =A0 =A0 =A0 =A0=3D omap3_enter_id=
le_bm;
>> + =A0 =A0 =A0 state->pre_enter =A0 =A0 =A0 =A0=3D omap3_enter_idle_b=
m;
>> + =A0 =A0 =A0 state->enter =A0 =A0 =A0 =A0 =A0 =A0=3D omap3_enter_id=
le;
>> =A0 =A0 =A0 =A0sprintf(state->name, "C%d", idx + 1);
>> =A0 =A0 =A0 =A0strncpy(state->desc, descr, CPUIDLE_DESC_LEN);
>>
> ...
>
> Also the line at 373 is not needed anymore in omap3_idle_init, since
> the enter callback is filled in in the _fill_cstate function:
> =A0 =A0 =A0 =A0/* C1 . MPU WFI + Core active */
> =A0 =A0 =A0 =A0_fill_cstate(drv, 0, "MPU ON + CORE ON");
> =A0 =A0 =A0 =A0(&drv->states[0])->enter =3D omap3_enter_idle; =A0 =A0=
 =A0 =A0 =A0 =A0 <=3D=3D
> not needed anymore
> =A0 =A0 =A0 =A0drv->safe_state_index =3D 0;
>
> More testing on OMAP3 is needed. Let me come back with the results as=
ap.
>

Understand and thanks for reviewing.

> Regards,
> Jean
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
