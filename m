From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 part1 07/11] ARM64 / ACPI: Introduce
 arch_fix_phys_package_id() for cpu topology
Date: Fri, 25 Apr 2014 15:52:49 +0100
Message-ID: <20140425145249.GP12304@sirena.org.uk>
References: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>
 <1398432017-8506-8-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dROjoSqrs89UHd/j"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:45176 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840AbaDYOxR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Apr 2014 10:53:17 -0400
Content-Disposition: inline
In-Reply-To: <1398432017-8506-8-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Catalin Marinas <catalin.marinas@arm.com>, linaro-acpi@lists.linaro.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>, Sudeep Holla <Sudeep.Holla@arm.com>, Grant Likely <grant.likely@linaro.org>, Charles.Garcia-Tobin@arm.com


--dROjoSqrs89UHd/j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 25, 2014 at 09:20:13PM +0800, Hanjun Guo wrote:

> +/*
> + * Use the CPU slot number provided by ACPI to update the physical
> + * package id, then we can get the right value in the "physical id"
> + * field of /proc/cpuinfo.
> + */
> +void arch_fix_phys_package_id(int num, u32 slot)
> +{
> +	struct cpu_topology *cpuid_topo = &cpu_topology[num];
> +
> +	if (cpuid_topo->cluster_id == -1)
> +		cpuid_topo->cluster_id = slot;
> +}
> +EXPORT_SYMBOL_GPL(arch_fix_phys_package_id);

This isn't going to work once we parse the MPIDR - we will always have a
cluster ID from MPIDR unless the system is uniprocessor (which doesn't
seem like it's going to be a common or useful case).  We'll either need
to have something in the topology parsing path which goes out and
queries ACPI before we try to parse MPIDR or this will need to just set
whatever it's told to set unconditionally.

--dROjoSqrs89UHd/j
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTWna+AAoJELSic+t+oim9z5kP/RUW9e6O5K38ZsHwAQLQf4DJ
nJ1vuI8l/1PmuZmYAh2CH9oXc6km+GBT1xXHv2msrlUAUc3FM0LffSENzaow5BXv
tX8BPevGo1wasXAJTLzRbqvNiBGdAjNjfbqr/+kRsxDhv0ngucVu0kq8JaY0tBQw
edRvJzRQSfySGKwhFc7Qf1qg8W8Stnsc8hIrCg5uoYWzR4yqnUoF4BWSm7xeReoj
jhhZvbGjDLs6eq4xdYS+hIoN0TAyz1QVheYDHr79I9lR0k1Kxfgc1VASQs0Pk2rN
9o4LaQ7qoRDj7Up6aK/ufwmoc2b3o5LKZl2BJJe8A/jHI6FfHGdd4hgNr0NbAlvQ
yOXF2Bl7h7ySB+cUgptoT1hDQBK7Ljf0xUFmBsqKVRBZ09F9k2DhZ2PjCvpCYbhI
plKbhQtoiGB39gk8mSElySkBcVfo9eNJDDJwVP3ZziJMxOMXtoiMRHAz+XZwaZxD
n7vv2U/rLPMtH1dpUPT6WTw4tkZ9o2sGAp+3ArarYKlIOgkMXpREXY+/kHFUMMDv
3CCgX6ynW7mwks1dS15YvFYWh7+l3LiH0No+Ak3t0ECQX4YK2upJs1kcL4dUzfuV
ZJ35Mf9yPwlev9u+U6XKXVgbhudiB++ObDDVab+GiqlwTBlHiVA0ZjhFPzdLHTN5
93VDiR+yX9jDd+aoxCY8
=ra0i
-----END PGP SIGNATURE-----

--dROjoSqrs89UHd/j--
