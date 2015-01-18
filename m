From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH v7 06/17] ARM64 / ACPI: Make PCI optional for ACPI on
 ARM64
Date: Sun, 18 Jan 2015 14:46:35 +0800
Message-ID: <54BB56CB.7040701@linaro.org>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org> <1421247905-3749-7-git-send-email-hanjun.guo@linaro.org> <20150116094913.GA13634@e104818-lin.cambridge.arm.com> <54BB51F1.8000900@linaro.org> <508480149.12941388.1421562696311.JavaMail.zimbra@zmail15.collab.prod.int.phx2.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:46272 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880AbbARGqq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 18 Jan 2015 01:46:46 -0500
Received: by mail-pa0-f42.google.com with SMTP id et14so32378362pad.1
        for <linux-acpi@vger.kernel.org>; Sat, 17 Jan 2015 22:46:46 -0800 (PST)
In-Reply-To: <508480149.12941388.1421562696311.JavaMail.zimbra@zmail15.collab.prod.int.phx2.redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jon Masters <jcm@redhat.com>
Cc: Randy Dunlap <rdunlap@infradead.org>, Arnd Bergmann <arnd@arndb.de>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Olof Johansson <olof@lixom.net>, "wangyijing@huawei.com" <wangyijing@huawei.com>, Robert Richter <rric@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <Marc.Zyngier@arm.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Rob Herring <robh@kernel.org>, grant.likel

On 2015=E5=B9=B401=E6=9C=8818=E6=97=A5 14:31, Jon Masters wrote:
> Hi Folks,
>
> Sorry for top posting from bed. The mainstream servers will all likel=
y do
 > PCIe but there are several that may not. They should not be excluded=
=2E=20
That said,
 >if we booted a previously built kernel on a system without an MCFG an=
d
 > got no ECAM/root then things would probably still work.
>
> I think it'll work out either way but for the record there is no requ=
irement to do PCIe on ARM servers that conform to spec.

OK, Catalin already said that was not the main point of the
comments for this patch, I think the title and change log
of the patch is inconsistent with the code makes Catalin confused,
I will update them in next version.

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
