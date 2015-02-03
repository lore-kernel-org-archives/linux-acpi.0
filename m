From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v8 00/21] Introduce ACPI for ARM64 based on ACPI 5.1
Date: Tue, 3 Feb 2015 16:47:27 +0000
Message-ID: <20150203164727.GC32750@leverpostej>
References: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1422881149-8177-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Catalin Marinas <Catalin.Marinas@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Will Deacon <Will.Deacon@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Sudeep Holla <Sudeep.Holla@arm.com>, "jcm@redhat.com" <jcm@redhat.com>, Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <Marc.Zyngier@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, Robert Richter <rric@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "phoenix.liyi@huawei.com" <phoenix.liyi@huawei.com>, Timur Tabi <timur@codeaurora.org>, Ashwin Chaugule <ashwinc@codeauro>
List-Id: linux-acpi@vger.kernel.org

On Mon, Feb 02, 2015 at 12:45:28PM +0000, Hanjun Guo wrote:
> Hi,
> 
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
> 
> previous version is here:
> v7: https://lkml.org/lkml/2015/1/14/586
> v6: https://lkml.org/lkml/2015/1/4/40
> 
> Any comments are welcome :)

I note that for ACPI the PMU interrupt information is stored in the GICC
(as "Performance Interrupt" and "Performance Interrupt Mode"), but I
don't see any code for handling that as part of this series.

Is anyone currently looking into that?

For those systems ACPI is being developed on do we know that the GICC
information for the PMU interrupts is sane?

I'm slightly worried about the prospect of adding support later only to
find that the performance interrupt data in contemporary GICC tables is
invalid; it's going to be extremely painful to detect that being the
case in order to perform any kind of workaround.

Thanks,
Mark.
