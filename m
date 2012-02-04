From: Colin Cross <ccross@google.com>
Subject: Re: [RFC PATCH v4 1/4] cpuidle: Add time keeping and irq enabling
Date: Sat, 4 Feb 2012 11:02:47 -0800
Message-ID: <CAMbhsRQxgvRN0skteFxeDBqmUArTa3wu2uZPqowDnBTSWuqScg@mail.gmail.com>
References: <1328065215-28108-1-git-send-email-rob.lee@linaro.org>
	<1328065215-28108-2-git-send-email-rob.lee@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-iy0-f174.google.com ([209.85.210.174]:58868 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754224Ab2BDTCu convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Feb 2012 14:02:50 -0500
Received: by mail-iy0-f174.google.com with SMTP id b35so6384961iac.19
        for <linux-acpi@vger.kernel.org>; Sat, 04 Feb 2012 11:02:49 -0800 (PST)
In-Reply-To: <1328065215-28108-2-git-send-email-rob.lee@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Lee <rob.lee@linaro.org>
Cc: len.brown@intel.com, khilman@ti.com, nicolas.pitre@linaro.org, daniel.lezcano@linaro.org, linaro-dev@lists.linaro.org, nicolas.ferre@atmel.com, linux@arm.linux.org.uk, kgene.kim@samsung.com, mturquette@linaro.org, linux-pm@vger.kernel.org, magnus.damm@gmail.com, linux-acpi@vger.kernel.org, shawn.guo@freescale.com, arnd.bergmann@linaro.org, patches@linaro.org, nsekhar@ti.com, s.hauer@pengutronix.de, Baohua.Song@csr.com, vincent.guittot@linaro.org, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, deepthi@linux.vnet.ibm.com, broonie@opensource.wolfsonmicro.com, amit.kucheria@linaro.org, amit.kachhap@linaro.org

On Tue, Jan 31, 2012 at 7:00 PM, Robert Lee <rob.lee@linaro.org> wrote:
> Make necessary changes to add implement time keepign and irq enabling
keeping
> in the core cpuidle code. =A0This will allow the remove of these
> functionalities from the platform cpuidle implementations.
>
> Signed-off-by: Robert Lee <rob.lee@linaro.org>
> ---
> =A0drivers/cpuidle/cpuidle.c | =A0 75 +++++++++++++++++++++++++++++++=
++++---------
> =A0include/linux/cpuidle.h =A0 | =A0 26 ++++++++++-----
> =A02 files changed, 76 insertions(+), 25 deletions(-)
>
> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
> index 59f4261..8ea0fc3 100644
> --- a/drivers/cpuidle/cpuidle.c
> +++ b/drivers/cpuidle/cpuidle.c
> @@ -57,14 +57,18 @@ static int __cpuidle_register_device(struct cpuid=
le_device *dev);
> =A0* cpuidle_idle_call - the main idle loop
> =A0*
> =A0* NOTE: no locks or semaphores should be used here
> + * NOTE: Should only be called from a local irq disabled context
> =A0* return non-zero on failure
> + *
> =A0*/
> =A0int cpuidle_idle_call(void)
> =A0{
> =A0 =A0 =A0 =A0struct cpuidle_device *dev =3D __this_cpu_read(cpuidle=
_devices);
> =A0 =A0 =A0 =A0struct cpuidle_driver *drv =3D cpuidle_get_driver();
> =A0 =A0 =A0 =A0struct cpuidle_state *target_state;
> - =A0 =A0 =A0 int next_state, entered_state;
> + =A0 =A0 =A0 int idx, ret =3D 0;
> + =A0 =A0 =A0 ktime_t t1, t2;
> + =A0 =A0 =A0 s64 diff;
>
> =A0 =A0 =A0 =A0if (off)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENODEV;
> @@ -86,37 +90,76 @@ int cpuidle_idle_call(void)
> =A0#endif
>
> =A0 =A0 =A0 =A0/* ask the governor for the next state */
> - =A0 =A0 =A0 next_state =3D cpuidle_curr_governor->select(drv, dev);
> + =A0 =A0 =A0 idx =3D cpuidle_curr_governor->select(drv, dev);
> +
> + =A0 =A0 =A0 target_state =3D &drv->states[idx];
> +
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Check with the device to see if it can enter this =
state or if another
> + =A0 =A0 =A0 =A0* state should be used.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 if (target_state->pre_enter) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 idx =3D target_state->
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pre_enter(dev, drv, idx=
);
Unnecessary line wrap and braces.

What's the point of the pre_enter call?  This seems very similar to
the prepare call that was removed in 3.2.  Drivers can already demote
the target state in their enter call.  The only thing you do between
pre_enter and enter is trace and account for the time.  Is there some
long call you don't want included in the idle time?  Some
documentation would help, and you need to very clearly define the
semantics of when post_enter gets called when pre_enter or enter
return errors.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
