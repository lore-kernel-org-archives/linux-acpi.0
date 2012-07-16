From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH 4/5] acpi : remove power from acpi_processor_cx structure
Date: Mon, 16 Jul 2012 11:23:37 -0400
Message-ID: <20120716152337.GA13540@phenom.dumpdata.com>
References: <1342127026-1526-1-git-send-email-daniel.lezcano@linaro.org>
 <1342127026-1526-4-git-send-email-daniel.lezcano@linaro.org>
 <20120713001701.GB13574@phenom.dumpdata.com>
 <50001325.8010500@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:35531 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890Ab2GPPcS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Jul 2012 11:32:18 -0400
Content-Disposition: inline
In-Reply-To: <50001325.8010500@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: rjw@sisk.pl, lenb@kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org

On Fri, Jul 13, 2012 at 02:23:01PM +0200, Daniel Lezcano wrote:
> On 07/13/2012 02:17 AM, Konrad Rzeszutek Wilk wrote:
> > On Thu, Jul 12, 2012 at 11:03:45PM +0200, Daniel Lezcano wrote:
> >> Remove the power field as it is not used.
> >>
> > It looks to be used in drivers/xen/xen-acpi-processor.c.
> >=20
> > I could emulate some value and stick it in there.. but I am
> > more curious - what is the intent of this value?
>=20
> At the first glance, this value is the power consumption of the
> specified state. I am not sure all acpi returns a correct value.

Like in milliwatts?
>=20
> I can imagine the power should be copied to the cpuidle_state structu=
re
> to the power field where it is used by the governor to choose the bet=
ter
> C-state. As it is not specified, cpuidle will assume the C-State N
> consumes less than the C-State N-1.
>=20
> If we want to add the power consumption we should also set the
> 'power_specified' flag for the driver, but that could change the
> behavior of the cpuidle driver.
>=20
> Anyway, IMO, this field is useless for this structure and should be
> specified later, if that makes sense, directly in the cpuidle_state
> structure like the other drivers do.
>=20
> If nobody complains, I will remove the field also from Xen and resend
> this patch.

Go for it. Looking at the Xen hypervisor code it just assigns the value
to its own structure and does nothing to it.

>=20
> Thanks
>   -- Daniel
>=20
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> ---
> >>  drivers/acpi/processor_idle.c |    2 --
> >>  include/acpi/processor.h      |    1 -
> >>  2 files changed, 0 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processo=
r_idle.c
> >> index d044588..99ba58f 100644
> >> --- a/drivers/acpi/processor_idle.c
> >> +++ b/drivers/acpi/processor_idle.c
> >> @@ -485,8 +485,6 @@ static int acpi_processor_get_power_info_cst(s=
truct acpi_processor *pr)
> >>  		if (obj->type !=3D ACPI_TYPE_INTEGER)
> >>  			continue;
> >> =20
> >> -		cx.power =3D obj->integer.value;
> >> -
> >>  		current_count++;
> >>  		memcpy(&(pr->power.states[current_count]), &cx, sizeof(cx));
> >> =20
> >> diff --git a/include/acpi/processor.h b/include/acpi/processor.h
> >> index 0957457..87bb9d7 100644
> >> --- a/include/acpi/processor.h
> >> +++ b/include/acpi/processor.h
> >> @@ -58,7 +58,6 @@ struct acpi_processor_cx {
> >>  	u32 address;
> >>  	u8 entry_method;
> >>  	u32 latency;
> >> -	u32 power;
> >>  	u64 time;
> >>  	u8 bm_sts_skip;
> >>  	char desc[ACPI_CX_DESC_LEN];
> >> --=20
> >> 1.7.5.4
> >>
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe linux-ac=
pi" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
>=20
> --=20
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software f=
or ARM SoCs
>=20
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
