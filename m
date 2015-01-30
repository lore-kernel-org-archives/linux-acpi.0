From: Timur Tabi <timur@codeaurora.org>
Subject: Re: [Linaro-acpi] [PATCH v7 04/17] ARM64 / ACPI: Introduce
 early_param for "acpi" and pass acpi=force to enable ACPI
Date: Fri, 30 Jan 2015 08:48:21 -0600
Message-ID: <54CB99B5.7070505@codeaurora.org>
References: <1421247905-3749-1-git-send-email-hanjun.guo@linaro.org> <1421247905-3749-5-git-send-email-hanjun.guo@linaro.org> <CAOZdJXU2bFR1T4ZnGavvnrUXAp5e=vNt9g6WKX46H8qs1wz-TQ@mail.gmail.com> <CAOZdJXXe+29rux1L3QYBX0yHLy3kdi+ZJrXVd=XfgYN=R6DtKA@mail.gmail.com> <20150128181453.GG31752@e104818-lin.cambridge.arm.com> <54C92804.5090806@codeaurora.org> <20150129151956.GF8951@e104818-lin.cambridge.arm.com> <CAKv+Gu_=si=L5+vvg+8hRgwmTahqdePw5bZxUMFSZ8obk-VXFQ@mail.gmail.com> <20150130111311.GA27542@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150130111311.GA27542@e104818-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Catalin Marinas <catalin.marinas@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Mark Rutland <Mark.Rutland@arm.com>, Rob Herring <robh@kernel.org>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Robert Richter <rric@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, Marc Zyngier <Marc.Zyngier@arm.com>, Will Deacon <Will.Deacon@arm.com>, Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, lkml <linux-kernel@vger.kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "wangyijing@huawei.com" <wangyijing@huawei.com>, Mark Brown <broonie@kernel.org>, "hanjun.guo@linaro.org" <hanjun.guo@linaro.org>, "jcm@redhat.com" <jcm@redhat.com>, Olof Johansson <olof@lixom.net>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jason
List-Id: linux-acpi@vger.kernel.org

Catalin Marinas wrote:
> Anyway, rather than a "I-created-an-empty-dtb" property, I would
> actually say something like "dtb-contains-no-hardware-description".

Why do we need a property for this?  Wouldn't the absence of a hardware 
description be the best way to see if the dtb contains no hardware 
description?  It's like putting a sign on an empty bookshelf that says, 
"there are no books here."

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the
Code Aurora Forum, hosted by The Linux Foundation.
