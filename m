From: Jean Pihet <jean.pihet-OTs2U3NB0ngRmelmmXo44Q@public.gmane.org>
Subject: Re: [RFC PATCH v4 2/4] ARM: omap: Remove cpuidle timekeeping and irq
	enable/disable
Date: Thu, 2 Feb 2012 17:21:21 +0100
Message-ID: <CAORVsuXLPjc7X+D1jVP1KyjgUWZhtUnA3F-iz-d-DqtHRmLShA@mail.gmail.com>
References: <1328065215-28108-1-git-send-email-rob.lee@linaro.org>
	<1328065215-28108-3-git-send-email-rob.lee@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
In-Reply-To: <1328065215-28108-3-git-send-email-rob.lee-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <http://lists.linaro.org/mailman/options/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linaro.org/pipermail/linaro-dev>
List-Post: <mailto:linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>
List-Help: <mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.linaro.org/mailman/listinfo/linaro-dev>,
	<mailto:linaro-dev-request-cunTk1MwBs8s++Sfvej+rw@public.gmane.org?subject=subscribe>
Sender: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
Errors-To: linaro-dev-bounces-cunTk1MwBs8s++Sfvej+rw@public.gmane.org
To: Robert Lee <rob.lee-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: khilman-l0cyMroinI0@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linaro-dev-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, deepthi-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nicolas.pitre-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, Baohua.Song-kQvG35nSl+M@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, arnd.bergmann-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-PelNFVqkFnVyf+4FbqDuWQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Rob,

On Wed, Feb 1, 2012 at 4:00 AM, Robert Lee <rob.lee-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org> wrote:
> Now that the core cpuidle driver keeps time and handles irq enabling,
> remove this functionality. =A0Also, remove irq disabling as all paths to
> cpuidle_idle_call already call local_irq_disable. =A0Also, restructure
> idle functions as needed by the cpuidle core driver changes.
>
> Signed-off-by: Robert Lee <rob.lee-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> ---
> =A0arch/arm/mach-omap2/cpuidle34xx.c | =A0 96 ++++++++++++++++-----------=
---------
> =A01 files changed, 43 insertions(+), 53 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/cpuidle34xx.c b/arch/arm/mach-omap2/cpui=
dle34xx.c
> index 464cffd..9ecded5 100644
> --- a/arch/arm/mach-omap2/cpuidle34xx.c
> +++ b/arch/arm/mach-omap2/cpuidle34xx.c
...

> @@ -100,23 +107,20 @@ static int omap3_enter_idle(struct cpuidle_device *=
dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct cpu=
idle_driver *drv,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int index)
> =A0{
> - =A0 =A0 =A0 struct omap3_idle_statedata *cx =3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cpuidle_get_statedata(&dev-=
>states_usage[index]);
> - =A0 =A0 =A0 struct timespec ts_preidle, ts_postidle, ts_idle;
> - =A0 =A0 =A0 u32 mpu_state =3D cx->mpu_state, core_state =3D cx->core_st=
ate;
> - =A0 =A0 =A0 int idle_time;
> + =A0 =A0 =A0 struct omap3_idle_drvdata *dd =3D dev->states_usage[index].=
driver_data
A build error is triggered by the missing ";".

...

> @@ -147,18 +151,12 @@ static int omap3_enter_idle(struct cpuidle_device *=
dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pwrdm_for_each_clkdm(core_pd, _cpuidle_all=
ow_idle);
> =A0 =A0 =A0 =A0}
>
> -return_sleep_time:
> - =A0 =A0 =A0 getnstimeofday(&ts_postidle);
> - =A0 =A0 =A0 ts_idle =3D timespec_sub(ts_postidle, ts_preidle);
> -
> - =A0 =A0 =A0 local_irq_enable();
> +leave:
> =A0 =A0 =A0 =A0local_fiq_enable();
>
> - =A0 =A0 =A0 idle_time =3D ts_idle.tv_nsec / NSEC_PER_USEC + ts_idle.tv_=
sec * \
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 USEC_PER_SEC;
> -
> - =A0 =A0 =A0 /* Update cpuidle counters */
> - =A0 =A0 =A0 dev->last_residency =3D idle_time;
> + =A0 =A0 =A0 /* Restore original PER state if it was modified */
> + =A0 =A0 =A0 if (dd->per_next_state !=3D dd->per_saved_state)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm_set_next_pwrst(per_pd, dd->per_saved_=
state);
This code is not necessarily balanced with the PER state change in
omap3_enter_idle_bm (cf. "/* Are we changing PER target state? */"
here below), since in the core cpuidle code there is no guarantee that
the calls to pre_enter and enter callbacks are balanced.
In general I fear that splitting the code in two functions introduces
a risk of programming non-coherent settings in the PRCM.

...

> @@ -255,8 +255,9 @@ static int omap3_enter_idle_bm(struct cpuidle_device =
*dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int index)
> =A0{
> =A0 =A0 =A0 =A0int new_state_idx;
> - =A0 =A0 =A0 u32 core_next_state, per_next_state =3D 0, per_saved_state =
=3D 0, cam_state;
> - =A0 =A0 =A0 struct omap3_idle_statedata *cx;
> + =A0 =A0 =A0 u32 core_next_state, cam_state;
> + =A0 =A0 =A0 struct omap3_idle_drvdata *dd =3D dev->states_usage[index].=
driver_data;
> + =A0 =A0 =A0 struct omap3_idle_statedata *cx =3D &dd->state_data[index];
> =A0 =A0 =A0 =A0int ret;
The build throws a few warnings about unused variables:

arch/arm/mach-omap2/cpuidle34xx.c: In function 'omap3_enter_idle_bm':
arch/arm/mach-omap2/cpuidle34xx.c:261: warning: unused variable 'ret'
arch/arm/mach-omap2/cpuidle34xx.c:257: warning: unused variable 'new_state_=
idx'

...

>
> =A0DEFINE_PER_CPU(struct cpuidle_device, omap3_idle_dev);
> @@ -337,7 +329,8 @@ static inline void _fill_cstate(struct cpuidle_driver=
 *drv,
> =A0 =A0 =A0 =A0state->exit_latency =A0 =A0 =3D cpuidle_params_table[idx].=
exit_latency;
> =A0 =A0 =A0 =A0state->target_residency =3D cpuidle_params_table[idx].targ=
et_residency;
> =A0 =A0 =A0 =A0state->flags =A0 =A0 =A0 =A0 =A0 =A0=3D CPUIDLE_FLAG_TIME_=
VALID;
> - =A0 =A0 =A0 state->enter =A0 =A0 =A0 =A0 =A0 =A0=3D omap3_enter_idle_bm;
> + =A0 =A0 =A0 state->pre_enter =A0 =A0 =A0 =A0=3D omap3_enter_idle_bm;
> + =A0 =A0 =A0 state->enter =A0 =A0 =A0 =A0 =A0 =A0=3D omap3_enter_idle;
> =A0 =A0 =A0 =A0sprintf(state->name, "C%d", idx + 1);
> =A0 =A0 =A0 =A0strncpy(state->desc, descr, CPUIDLE_DESC_LEN);
>
...

Also the line at 373 is not needed anymore in omap3_idle_init, since
the enter callback is filled in in the _fill_cstate function:
        /* C1 . MPU WFI + Core active */
        _fill_cstate(drv, 0, "MPU ON + CORE ON");
        (&drv->states[0])->enter =3D omap3_enter_idle;             <=3D=3D
not needed anymore
        drv->safe_state_index =3D 0;

More testing on OMAP3 is needed. Let me come back with the results asap.

Regards,
Jean
