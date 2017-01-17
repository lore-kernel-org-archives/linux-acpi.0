From: Fu Wei <fu.wei@linaro.org>
Subject: Re: [PATCH v19 00/15] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
Date: Tue, 17 Jan 2017 17:14:31 +0800
Message-ID: <CADyBb7ukKotnhcY=uOsrqhVr_M9UbLU_UdKcKnTcBWfxF5VAyQ@mail.gmail.com>
References: <20161221064603.11830-1-fu.wei@linaro.org>
 <20170116170010.GH5908@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20170116170010.GH5908@leverpostej>
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
Cc: Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, rruigrok@codeaurora.org, Wim Van Sebroeck <wim@iguana.be>, Wei Huang <wei@redhat.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Al Stone <al.stone@linaro.org>, Tomasz Nowicki <tn@semihalf.com>, Timur Tabi <timur@codeaurora.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, Len Brown <lenb@kernel.org>, "Abdulhamid,
 Harb" <harba@codeaurora.org>, Julien Grall <julien.grall@arm.com>, linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Christopher Covington <cov@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, G Gregory <graeme.gre>
List-Id: linux-acpi@vger.kernel.org

Hi Mark,

On 17 January 2017 at 01:00, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> On Wed, Dec 21, 2016 at 02:45:48PM +0800, fu.wei@linaro.org wrote:
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> This patchset:
>>     (1)Preparation for adding GTDT support in arm_arch_timer:
>>         1. Move some enums and marcos to header file;
>>         2. Add a new enum for spi type;
>>         3. Improve printk relevant code;
>>         4. Rename some enums and defines;
>
> Can we please rework these first few patches into a series:
>
> 1. Clean up printk() usage
> 2. Rename the type macros
> 3. Rename the PPI enum & enum values
> 4. Move the type macro and PPI enum into a header
> 5. Add new enum for SPIs
>
> Please leave CNTHCL_* as they originally were. It's not part of the
> interface of the driver, and leaving them as they are will save us an
> interdependency with KVM.
>
> I'm happy to queue that immediately, as it's purely structural and
> shouldn't have a functional impact anywhere. That will also shrink the
> series a bit, and we can rebase the following patches atop of that.

Thanks for your suggestion, I have finished this improvement.
It will be in v20.

https://git.linaro.org/people/fu.wei/linux.git/log/?h=topic-gtdt-wakeup-timer_upstream_v20_devel

>
>>         5. Rework PPI determination;
>>         6. Rework counter frequency detection;
>>         7. Refactor arch_timer_needs_probing, move it into DT init call
>>         8. Introduce some new structs and refactor the MMIO timer init code
>>         for reusing some common code.
>
> I'll review these in separate replies.
>
> Thanks,
> Mark.



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
