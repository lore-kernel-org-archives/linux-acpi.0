From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 5/5] ACPI: Update the t-state for every affected cpu when t-state is changed
Date: Sat, 2 Feb 2008 03:53:01 -0500
Message-ID: <200802020353.02051.lenb@kernel.org>
References: <1201499756.17068.27.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52095 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757460AbYBBIxX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 2 Feb 2008 03:53:23 -0500
In-Reply-To: <1201499756.17068.27.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org

On Monday 28 January 2008 00:55, Zhao Yakui wrote:
> Subject: ACPI : Update the t-state for every affected cpu when t-stat=
e is changed
> >From : Zhao Yakui <yakui.zhao@intel.com>
>=20
> According to ACPI spec, the _TSD object provides T-state control cros=
s
> logical processor dependency information to OSPM. So the t-state
> coordination should be considered when T-state for one cpu is changed=
=2E
>=20
> According to ACPI spec, three types of coordination are defined.
> SW_ALL, SW_ANY and HW_ALL.
> SW_ALL: it means that OSPM needs to initiate T-state transition on=20
> all processors in the domain. It is necessary to call throttling set =
function
> for all affected cpus.
> SW_ANY: it means that OSPM may initiate T-state transition on any pro=
cessor in=20
> the domain.=20
> HW_ALL: Apec only says that hardware will perform the coordination an=
d doesn't=20
> recommend how OSPM coordinate T-state among the affected cpus. So it =
is treated
> as the type of SW_ALL. It means that OSPM needs to initiate t-state t=
ransition
> on all the processors in the domain.
>=20
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> ---
>  drivers/acpi/processor_throttling.c |   79 +++++++++++++++++++++++++=
++++++++---
>  1 file changed, 74 insertions(+), 5 deletions(-)
>=20
> Index: linux-2.6/drivers/acpi/processor_throttling.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/acpi/processor_throttling.c
> +++ linux-2.6/drivers/acpi/processor_throttling.c
> @@ -68,7 +68,7 @@ static int acpi_processor_update_tsd_coo
> =20
>  	/*
>  	 * Now that we have _TSD data from all CPUs, lets setup T-state
> -	 * coordination among all CPUs.
> +	 * coordination between all CPUs.
>  	 */
>  	for_each_possible_cpu(i) {
>  		pr =3D processors[i];
> @@ -988,6 +988,11 @@ int acpi_processor_set_throttling(struct
>  {
>  	cpumask_t saved_mask;
>  	int ret;
> +	unsigned int i;
> +	struct acpi_processor *match_pr;
> +	struct acpi_processor_throttling *p_throttling;
> +	struct throttling_tstate t_state;
> +	cpumask_t online_throttling_cpus;
> =20
>  	if (!pr)
>  		return -EINVAL;
> @@ -998,12 +1003,76 @@ int acpi_processor_set_throttling(struct
>  	if ((state < 0) || (state > (pr->throttling.state_count - 1)))
>  		return -EINVAL;
> =20
> +	saved_mask =3D current->cpus_allowed;
> +	t_state.target_state =3D state;
> +	p_throttling =3D &(pr->throttling);
> +	cpus_and(online_throttling_cpus, cpu_online_map,
> +			p_throttling->shared_cpu_map);
>  	/*
> -	 * Migrate task to the cpu pointed by pr.
> +	 * The throttling notifier will be called for every
> +	 * affected cpu in order to get one proper T-state.
> +	 * The notifier event is THROTTLING_PRECHANGE.
>  	 */
> -	saved_mask =3D current->cpus_allowed;
> -	set_cpus_allowed(current, cpumask_of_cpu(pr->id));
> -	ret =3D pr->throttling.acpi_processor_set_throttling(pr, state);

drivers/acpi/processor_throttling.c:990: warning: =E2=80=98ret=E2=80=99=
 may be used uninitialized in this function

-Len

> +	for_each_cpu_mask(i, online_throttling_cpus) {
> +		t_state.cpu =3D i;
> +		acpi_processor_throttling_notifier(THROTTLING_PRECHANGE,
> +							&t_state);
> +	}
> +	/*
> +	 * The function of acpi_processor_set_throttling will be called
> +	 * to switch T-state. If the coordination type is SW_ALL or HW_ALL,
> +	 * it is necessary to call it for every affected cpu. Otherwise
> +	 * it can be called only for the cpu pointed by pr.
> +	 */
> +	if (p_throttling->shared_type =3D=3D DOMAIN_COORD_TYPE_SW_ANY) {
> +		set_cpus_allowed(current, cpumask_of_cpu(pr->id));
> +		ret =3D p_throttling->acpi_processor_set_throttling(pr,
> +						t_state.target_state);
> +	} else {
> +		/*
> +		 * When the T-state coordination is SW_ALL or HW_ALL,
> +		 * it is necessary to set T-state for every affected
> +		 * cpus.
> +		 */
> +		for_each_cpu_mask(i, online_throttling_cpus) {
> +			match_pr =3D processors[i];
> +			/*
> +			 * If the pointer is invalid, we will report the
> +			 * error message and continue.
> +			 */
> +			if (!match_pr) {
> +				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> +					"Invalid Pointer for CPU %d\n", i));
> +				continue;
> +			}
> +			/*
> +			 * If the throttling control is unsupported on CPU i,
> +			 * we will report the error message and continue.
> +			 */
> +			if (!match_pr->flags.throttling) {
> +				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> +					"Throttling Controll is unsupported "
> +					"on CPU %d\n", i));
> +				continue;
> +			}
> +			t_state.cpu =3D i;
> +			set_cpus_allowed(current, cpumask_of_cpu(i));
> +			ret =3D match_pr->throttling.
> +				acpi_processor_set_throttling(
> +				match_pr, t_state.target_state);
> +		}
> +	}
> +	/*
> +	 * After the set_throttling is called, the
> +	 * throttling notifier is called for every
> +	 * affected cpu to update the T-states.
> +	 * The notifier event is THROTTLING_POSTCHANGE
> +	 */
> +	for_each_cpu_mask(i, online_throttling_cpus) {
> +		t_state.cpu =3D i;
> +		acpi_processor_throttling_notifier(THROTTLING_POSTCHANGE,
> +							&t_state);
> +	}
>  	/* restore the previous state */
>  	set_cpus_allowed(current, saved_mask);
>  	return ret;
>=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
