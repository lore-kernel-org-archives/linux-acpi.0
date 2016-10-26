From: Fu Wei <fu.wei@linaro.org>
Subject: Re: [PATCH v14 5/9] clocksource/drivers/arm_arch_timer: Simplify ACPI
 support code.
Date: Wed, 26 Oct 2016 16:54:48 +0800
Message-ID: <CADyBb7ukv4boB7iSt3cxr6SQK_KNsSirAWuP4J+zU-=E2QaEQA@mail.gmail.com>
References: <1475086637-1914-1-git-send-email-fu.wei@linaro.org>
 <1475086637-1914-6-git-send-email-fu.wei@linaro.org>
 <20161020165747.GD27598@leverpostej>
 <20161021111352.GA16630@leverpostej> <20161021112120.GC16630@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20161021112120.GC16630@leverpostej>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, rruigrok@codeaurora.org, Julien Grall <julien.grall@arm.com>, Wim Van Sebroeck <wim@iguana.be>, Wei Huang <wei@redhat.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Al Stone <al.stone@linaro.org>, Tomasz Nowicki <tn@semihalf.com>, Timur Tabi <timur@codeaurora.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, Len Brown <lenb@kernel.org>, "Abdulhamid,
 Harb" <harba@codeaurora.org>, linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Christopher Covington <cov@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, G Gregory <graeme.gre>
List-Id: linux-acpi@vger.kernel.org

Hi Mark,

On 21 October 2016 at 19:21, Mark Rutland <mark.rutland@arm.com> wrote:
> On Fri, Oct 21, 2016 at 12:14:01PM +0100, Mark Rutland wrote:
>> On Thu, Oct 20, 2016 at 05:58:17PM +0100, Mark Rutland wrote:
>> > On Thu, Sep 29, 2016 at 02:17:13AM +0800, fu.wei@linaro.org wrote:
>> > > + arch_timer_ppi[PHYS_NONSECURE_PPI] = acpi_gtdt_map_ppi(PHYS_NONSECURE_PPI);
>> > > + arch_timer_ppi[VIRT_PPI] = acpi_gtdt_map_ppi(VIRT_PPI);
>> > > + arch_timer_ppi[HYP_PPI] = acpi_gtdt_map_ppi(HYP_PPI);
>> > > + /* Always-on capability */
>> > > + arch_timer_c3stop = acpi_gtdt_c3stop();
>> >
>> > ... I think we should check the flag on the relevant interrupt, though
>> > that's worth clarifying.
>>
>> I see I misread the spec; this is part of the common flags.
>>
>> Please ignore this point; sorry for the noise.
>
> Actually, I misread the spec this time around; the flag *can* differ per
> interrupt for the sysreg/cp15 timer, but not for the MMIO timers where
> the flag is in a common field.
>
> So please *do* consider the above.

yes , you are right , will do
Thanks :-)

>
> Thanks,
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
