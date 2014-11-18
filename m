From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v5 01/18] ARM64: Move the init of cpu_logical_map(0)
 before unflatten_device_tree()
Date: Tue, 18 Nov 2014 16:57:13 +0000
Message-ID: <20141118165713.GT18842@arm.com>
References: <1413553034-20956-1-git-send-email-hanjun.guo@linaro.org>
 <1413553034-20956-2-git-send-email-hanjun.guo@linaro.org>
 <546B4D8D.2020605@linaro.org>
 <20141118164312.GL28279@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss-mx-na.foss.arm.com ([217.140.108.86]:60467 "EHLO
	foss-mx-na.foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932577AbaKRQ5S (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 18 Nov 2014 11:57:18 -0500
Content-Disposition: inline
In-Reply-To: <20141118164312.GL28279@e104818-lin.cambridge.arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <Mark.Rutland@arm.com>, Olof Johansson <olof@lixom.net>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Lv Zheng <lv.zheng@intel.com>, Robert Moore <robert.moore@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Kangk

On Tue, Nov 18, 2014 at 04:43:13PM +0000, Catalin Marinas wrote:
> On Tue, Nov 18, 2014 at 01:45:49PM +0000, Hanjun Guo wrote:
> > On 2014=E5=B9=B410=E6=9C=8817=E6=97=A5 21:36, Hanjun Guo wrote:
> > > It always make sense to initialize CPU0's logical map entry from =
the
> > > hardware values, so move the initialization of cpu_logical_map(0)
> > > before unflatten_device_tree() which is needed by ACPI code later=
=2E
> > >
> > > Acked-by: Olof Johansson <olof@lixom.net>
> > > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > > Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> >=20
> > Could you merge this patch first in 3.19? It was acked by Olof and
> > Mark, and it will make sense without ACPI too.
>=20
> I think it can go in for 3.19 (it's Will's turn this time ;)).

This patch doesn't apply on for-next/core, as it conflicts with some of
Rutland's rework ("arm64: log physical ID of boot CPU").

Will
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
