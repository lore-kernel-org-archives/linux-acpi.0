From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] drivers: acpi: make ACPI_PROCFS_POWER X86 only
Date: Fri, 15 May 2015 02:02 +0200
Message-ID: <1701495.Dtn0xvTX7m@vostro.rjw.lan>
References: <1430476021-12247-1-git-send-email-lorenzo.pieralisi@arm.com> <5544CC8F.70203@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61295 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1423011AbbENXgr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 14 May 2015 19:36:47 -0400
In-Reply-To: <5544CC8F.70203@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Lan Tianyu <tianyu.lan@intel.com>

On Saturday, May 02, 2015 09:09:35 PM Hanjun Guo wrote:
> On 2015=E5=B9=B405=E6=9C=8801=E6=97=A5 18:27, Lorenzo Pieralisi wrote=
:
> > The ACPI procfs power interface is initialized by compilation units
> > that are only selectable on X86 platforms. Since its usage is
> > deprecated and it cannot even be used on platforms other than X86
> > it should be compiled in only on X86 platforms.
> >
> > This patch makes CONFIG_ACPI_PROCFS_POWER dependent on X86, so
> > that other architectures are prevented from compiling it in for
> > no purpose.
> >
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > Cc: Hanjun Guo <hanjun.guo@linaro.org>
> > Cc: Lan Tianyu <tianyu.lan@intel.com>
> > Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>=20
> I think this proc fs was not used for IA64 (it is
> for server platform) too.
>=20
> Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

Queued up for 4.2, thanks!


--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
