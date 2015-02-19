From: Robert Richter <rric@kernel.org>
Subject: Re: [PATCH v8 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
Date: Thu, 19 Feb 2015 17:10:48 +0100
Message-ID: <20150219161048.GD4201@rric.localhost>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
 <20150212100235.GA30412@rric.localhost>
 <54DD65F2.9050108@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:40780 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751784AbbBSQKy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Feb 2015 11:10:54 -0500
Content-Disposition: inline
In-Reply-To: <54DD65F2.9050108@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, phoenix.liyi@huawei.com, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, Mark Langsdorf <mlangsdo@redhat.com>

On 13.02.15 10:48:18, Hanjun Guo wrote:
> On 2015=E5=B9=B402=E6=9C=8812=E6=97=A5 18:02, Robert Richter wrote:
> >On 02.02.15 20:45:28, Hanjun Guo wrote:
> >>This is the v8 of ACPI core patches for ARM64 based on ACPI 5.1, th=
ere are
> >>some updates since v7:
> >>
> >>  - Add two more documantation to explain why we need ACPI in ARM64=
 servers
> >>    by Grant, and recommendations and prohibitions on the use of th=
e numerous
> >>    ACPI tables and objects by Al Stone.
> >>
> >>  - Add two patches which is need to map acpi tables after acpi_gbl=
_permanent_mmap
> >>    is set
> >>
> >>  - Add another patch "dt / chosen: Add linux,uefi-stub-generated-d=
tb property"
> >>    to address that if firmware providing no dtb, we can try ACPI c=
onfiguration data
> >>    even if no "acpi=3Dforce" is passed in early parameters. (I thi=
nk ACPI for XEN and
> >>    kexec need consider sperately as disscussed, correct me if I'm =
wrong).
> >>
> >>  - Add CC in the patch to the subsystem maintainers and modify the=
 subject
> >>    of the patch to explicitly show the subsystem touched by this p=
atch set,
> >>    please help us to review and ack them if they make sense, thank=
s.
> >>
> >>  - Add Tested-by from Qualcomm and Redhat;
> >>
> >>  - Make ACPI depends on PCI suggested by Catalin;
> >>
> >>  - Clean up SMP init function as Lorenzo suggested, remove physica=
l
> >>    CPU hot-plug code in the patch;
> >>
> >>  - Address some comments from Marc and explicitly state that will
> >>    implment statcked irqdomain and GIC init framework when GICv3 a=
nd
> >>    ITS, GICv2m are implemented;
> >>
> >>  - Rebased on top of 3.19-rc7.
> >
> >Patches tested on Cavium ThunderX. For the whole series:
> >
> >  Tested-by: Robert Richter <rrichter@cavium.com>
> >  Acked-by: Robert Richter <rrichter@cavium.com>
>=20
> Hi Robert, thank you very much.
>=20
> I'm going to send out v9 to address some of the comments, I think
> your Acked-by still apply if no objection from you :)

Right, unless you hear from me. ;)

-Robert
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
