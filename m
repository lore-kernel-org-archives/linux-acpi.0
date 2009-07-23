From: Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] powernow-k8: don't load powernow-k8 driver when acpi=off
Date: Thu, 23 Jul 2009 10:25:35 +0200
Message-ID: <200907231025.36670.trenn@suse.de>
References: <1248315070.2670.16.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:44979 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752400AbZGWIZi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Jul 2009 04:25:38 -0400
In-Reply-To: <1248315070.2670.16.camel@rzhang-dt>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: davej@redhat.com, linux-acpi <linux-acpi@vger.kernel.org>, cpufreq@vger.kernel.org, Len Brown <lenb@kernel.org>, howl.nsp@gmail.com, "Langsdorf, Mark" <mark.langsdorf@amd.com>

On Thursday 23 July 2009 04:11:10 Zhang Rui wrote:
> when acpi=3Doff, powernow-k8 driver is still loaded, and fails with
> a firmware bug warning message.
> http://bugzilla.kernel.org/show_bug.cgi?id=3D13695#c5

Powernow-k8 can theoretically fetch info from a non-acpi
table for specific 1 core systems, but I agree that in nearly
all cases this won't work anyway. And acpi should still
be switched on.

Mark should get a chance to look at this before it's submitted,
though.

> this is misleading,
> we should not load powernow-k8 driver when acpi=3Doff.
> http://bugzilla.kernel.org/show_bug.cgi?id=3D13695
>=20
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>

Reviewed-by: Thomas Renninger <trenn@suse.de>

> Tested-by: David Santamar=C3=ADa Rogado <howl.nsp@gmail.com>
> ---
>  arch/x86/kernel/cpu/cpufreq/powernow-k8.c |    3 +++
>  1 file changed, 3 insertions(+)
>=20
> Index: linux-2.6/arch/x86/kernel/cpu/cpufreq/powernow-k8.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/arch/x86/kernel/cpu/cpufreq/powernow-k8.c
> +++ linux-2.6/arch/x86/kernel/cpu/cpufreq/powernow-k8.c
> @@ -1436,6 +1436,9 @@ static int __cpuinit powernowk8_init(voi
>  {
>  	unsigned int i, supported_cpus =3D 0;
> =20
> +	if (acpi_disabled)
> +		return 0;
> +
>  	for_each_online_cpu(i) {
>  		int rc;
>  		smp_call_function_single(i, check_supported_cpu, &rc, 1);
>=20
>=20
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
