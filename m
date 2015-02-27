From: Shannon Zhao <zhaoshenglong@huawei.com>
Subject: Re: [PATCH v9 21/21] ARM64 / ACPI: additions of ACPI documentation
 for arm64
Date: Fri, 27 Feb 2015 19:22:45 +0800
Message-ID: <54F05385.2080506@huawei.com>
References: <1424853601-6675-1-git-send-email-hanjun.guo@linaro.org> <1424853601-6675-22-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([119.145.14.65]:58931 "EHLO
	szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751635AbbB0LX3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Feb 2015 06:23:29 -0500
In-Reply-To: <1424853601-6675-22-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Will Deacon <will.deacon@arm.com>, Olof Johansson <olof@lixom.net>, Grant Likely <grant.likely@linaro.org>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, Mark Brown <broonie@kernel.org>, Robert Richter <rric@kernel.org>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Al Stone <al.stone@linaro.org>, Yi Li <phoenix.liyi@huawei.com>, Mark Langsdorf <mlangsdo@redhat.com>, "Huangpeng (Peter)" <peter.huangpeng@huawei.com>

On 2015/2/25 16:40, Hanjun Guo wrote:
> +Not yet implemented are:
> +
> +	-- Section 10: power source and power meter devices
> +
> +	-- Section 11: thermal management
> +
> +	-- Section 12: embedded controllers interface
> +
> +	-- Section 13: SMBus interfaces
> +
> +	-- Section 17: NUMA support (prototypes have been submitted for
> +	   review)
> +
>=20

Here at the end of the file. Redundant blank line.

> +ACPI is also important because hardware and OS vendors have already =
worked
> +out how to use it to support the general purpose ecosystem. The infr=
astructure
> +is in place, the bindings are in place, and the process is in place.=
 DT does
> +exactly what we need it to when working with vertically integrated d=
evices,
> +but we don=E2=80=99t have good processes for supporting what the ser=
ver vendors need.
> +We could potentially get there with DT, but doing so doesn=E2=80=99t=
 buy us anything.
> +ACPI already does what the hardware vendors need, Microsoft won=E2=80=
=99t collaborate
> +with us on DT, and the hardware vendors would still need to provide =
two
> +completely separate firmware interface; one for Linux and one for Wi=
ndows.
> +

And Here at the end of the file. Redundant blank line.

--=20
Thanks,
Shannon

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
