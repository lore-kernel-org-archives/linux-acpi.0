From: dann frazier <dann.frazier@canonical.com>
Subject: Re: [PATCH v10 0/9] LPC: legacy ISA I/O support
Date: Thu, 9 Nov 2017 09:16:03 -0700
Message-ID: <CALdTtnsCXp9kone=VECSyPOi6kuYML8eU-TKHM+_ekhVoGSTYA@mail.gmail.com>
References: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1509120687-7352-1-git-send-email-gabriele.paoloni@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gabriele Paoloni <gabriele.paoloni@huawei.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, rafael@kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, lorenzo.pieralisi@arm.com, Mark Rutland <mark.rutland@arm.com>, Brian Starkey <brian.starkey@arm.com>, olof@lixom.net, benh@kernel.crashing.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, linuxarm@huawei.com, linux-pci@vger.kernel.org, Corey Minyard <minyard@acm.org>, John Garry <john.garry@huawei.com>, xuwei5@hisilicon.com
List-Id: linux-acpi@vger.kernel.org

On Fri, Oct 27, 2017 at 10:11 AM, Gabriele Paoloni
<gabriele.paoloni@huawei.com> wrote:
> From: gabriele paoloni <gabriele.paoloni@huawei.com>
>
> This patchset supports the IPMI-bt device attached to the Low-Pin-Count
> interface implemented on Hisilicon Hip06/Hip07 SoC.

fwiw, I tested this on one of our D05 boards and verified that the
IPMI SI worked fine.

Tested-by: dann frazier <dann.frazier@canonical.com>
