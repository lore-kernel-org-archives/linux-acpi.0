From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] IBM R40e blacklist for C2/C3 states: sort & remove duplicate
Date: Mon, 18 Aug 2008 17:10:17 +0200
Message-ID: <200808181710.18456.trenn@suse.de>
References: <20080815160657.25828.qmail@serverkommune.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns.suse.de ([195.135.220.2]:46301 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750924AbYHRPKW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 18 Aug 2008 11:10:22 -0400
In-Reply-To: <20080815160657.25828.qmail@serverkommune.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Rosner <kernel-bugs@digital-trauma.de>
Cc: linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Andi Kleen <ak@linux.intel.com>

On Thursday 31 July 2008 23:35:35 Thomas Rosner wrote:
> Sort the entries in the IBM R40e C2/C3-states blacklist and remove a
> duplicate. Please apply.
=46WIW, the R40e can do c-state switching, but must use the RSDT instea=
d of the=20
XSDT.
The patchseries (posted on linux-acpi a while ago):
[PATCH 1/3] ACPICA: Add acpi_gbl_force_rsdt variable
Re: [PATCH 2/3] Introduce acpi_root_table=3Drsdt boot param and dmi lis=
t to=20
force rsdt
[PATCH 3/3] Remove R40e c-state blacklist

did introduce a switch to be able to load blacklisted machines to use t=
he RSDT
(only some rare specific T4x or T5x are known which need it) instead of=
 the=20
XSDT and moves the R40e blacklist to use the RSDT and thus enables c-st=
ates=20
for these machines.

The patch has not been taken:
--------------------
Appropriate workaround for a distro release? =C2=A0Yes.
Appropriate patch for upstream? =C2=A0No.

Upstream should fix the root cause, which is to figure out when the RSD=
T=20
and XSDT disagree, which Windows is using, and use that one. =C2=A0Litt=
ering=20
upstream with DMI entries simply hides the test cases that we know abou=
t
and delays the correct fix.
--------------------

IMO it's time to repost above patchset and take it until the "root caus=
e" is=20
found.

The blacklist should also just match:
> -	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
> -	  DMI_MATCH(DMI_BIOS_VERSION,"1SET")}, (void *)1},
all other entries can vanish.

I can repost if people think that the root cause cannot be fixed for .2=
7=20
anymore and above is considered as a workaround that should be taken fo=
r now.

      Thomas


> Signed-off-by: Thomas Rosner <kernel-bugs@digital-trauma.de>
> CC: Len Brown <len.brown@intel.com>
> CC: Andie Kleen <ak@linux.intel.com>
> ---
>  drivers/acpi/processor_idle.c |    9 +++------
>  1 files changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_i=
dle.c
> index 556ee15..3e9f59d 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -128,12 +128,6 @@ static int set_max_cstate(const struct dmi_syste=
m_id
> *id) static struct dmi_system_id __cpuinitdata processor_power_dmi_ta=
ble[]
> =3D { { set_max_cstate, "IBM ThinkPad R40e", {
>  	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
> -	  DMI_MATCH(DMI_BIOS_VERSION,"1SET70WW")}, (void *)1},
> -	{ set_max_cstate, "IBM ThinkPad R40e", {
> -	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
> -	  DMI_MATCH(DMI_BIOS_VERSION,"1SET60WW")}, (void *)1},
> -	{ set_max_cstate, "IBM ThinkPad R40e", {
> -	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
>  	  DMI_MATCH(DMI_BIOS_VERSION,"1SET43WW") }, (void*)1},
>  	{ set_max_cstate, "IBM ThinkPad R40e", {
>  	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
> @@ -174,6 +168,9 @@ static struct dmi_system_id __cpuinitdata
> processor_power_dmi_table[] =3D { { set_max_cstate, "IBM ThinkPad R40=
e", {
>  	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
>  	  DMI_MATCH(DMI_BIOS_VERSION,"1SET68WW") }, (void*)1},
> +	{ set_max_cstate, "IBM ThinkPad R40e", {
> +	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
> +	  DMI_MATCH(DMI_BIOS_VERSION,"1SET70WW")}, (void *)1},
>  	{ set_max_cstate, "Medion 41700", {
>  	  DMI_MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
>  	  DMI_MATCH(DMI_BIOS_VERSION,"R01-A1J")}, (void *)1},


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
