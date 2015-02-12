From: Robert Richter <rric@kernel.org>
Subject: Re: [PATCH v8 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
Date: Thu, 12 Feb 2015 11:02:35 +0100
Message-ID: <20150212100235.GA30412@rric.localhost>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>, Grant Likely <grant.likely@linaro.org>, Will Deacon <will.deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Graeme Gregory <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, Jon Masters <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles.Garcia-Tobin@arm.com, phoenix.liyi@huawei.com, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeaurora.org>, suravee.suthikulpanit@amd.com, Mark Langsdorf <mlangsdo@redhat.com>
List-Id: linux-acpi@vger.kernel.org

On 02.02.15 20:45:28, Hanjun Guo wrote:
> This is the v8 of ACPI core patches for ARM64 based on ACPI 5.1, there are
> some updates since v7:
> 
>  - Add two more documantation to explain why we need ACPI in ARM64 servers
>    by Grant, and recommendations and prohibitions on the use of the numerous
>    ACPI tables and objects by Al Stone.
> 
>  - Add two patches which is need to map acpi tables after acpi_gbl_permanent_mmap
>    is set
> 
>  - Add another patch "dt / chosen: Add linux,uefi-stub-generated-dtb property"
>    to address that if firmware providing no dtb, we can try ACPI configuration data
>    even if no "acpi=force" is passed in early parameters. (I think ACPI for XEN and
>    kexec need consider sperately as disscussed, correct me if I'm wrong).
> 
>  - Add CC in the patch to the subsystem maintainers and modify the subject
>    of the patch to explicitly show the subsystem touched by this patch set,
>    please help us to review and ack them if they make sense, thanks.
> 
>  - Add Tested-by from Qualcomm and Redhat;
> 
>  - Make ACPI depends on PCI suggested by Catalin;
> 
>  - Clean up SMP init function as Lorenzo suggested, remove physical
>    CPU hot-plug code in the patch;
> 
>  - Address some comments from Marc and explicitly state that will
>    implment statcked irqdomain and GIC init framework when GICv3 and
>    ITS, GICv2m are implemented;
> 
>  - Rebased on top of 3.19-rc7.

Patches tested on Cavium ThunderX. For the whole series:

 Tested-by: Robert Richter <rrichter@cavium.com>
 Acked-by: Robert Richter <rrichter@cavium.com>

Please apply.

Thanks,

-Robert
