From: Fu Wei <fu.wei@linaro.org>
Subject: Re: [PATCH v20 11/17] clocksource/drivers/arm_arch_timer: Introduce
 some new structs to prepare for GTDT
Date: Thu, 19 Jan 2017 17:47:14 +0800
Message-ID: <CADyBb7uhwU_ACGQRvw8zPg-VCdxyO2L1MEoeZWS1zYdveLK6PA@mail.gmail.com>
References: <20170118132541.8989-1-fu.wei@linaro.org>
 <20170118132541.8989-12-fu.wei@linaro.org>
 <a47f2474-fb29-9217-3de1-6e2a6a36f21f@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <a47f2474-fb29-9217-3de1-6e2a6a36f21f@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, rruigrok@codeaurora.org, Wim Van Sebroeck <wim@iguana.be>, Wei Huang <wei@redhat.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Al Stone <al.stone@linaro.org>, Tomasz Nowicki <tn@semihalf.com>, Timur Tabi <timur@codeaurora.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, Len Brown <lenb@kernel.org>, "Abdulhamid,
 Harb" <harba@codeaurora.org>, Julien Grall <julien.grall@arm.com>, linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Christopher Covington <cov@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists
List-Id: linux-acpi@vger.kernel.org

Hi Hanjun,

On 19 January 2017 at 16:28, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> On 2017/1/18 21:25, fu.wei@linaro.org wrote:
>>
>> From: Fu Wei <fu.wei@linaro.org>
>>
>> The patch introduce two new structs: arch_timer_mem, arch_timer_mem_frame.
>> And also introduce a new define: ARCH_TIMER_MEM_MAX_FRAMES
>>
>> These will be used for refactoring the memory-mapped timer init code to
>> prepare for GTDT
>>
>> Signed-off-by: Fu Wei <fu.wei@linaro.org>
>> ---
>>  include/clocksource/arm_arch_timer.h | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/include/clocksource/arm_arch_timer.h
>> b/include/clocksource/arm_arch_timer.h
>> index 4a98c06..b7dd185 100644
>> --- a/include/clocksource/arm_arch_timer.h
>> +++ b/include/clocksource/arm_arch_timer.h
>> @@ -57,6 +57,8 @@ enum arch_timer_spi_nr {
>>  #define ARCH_TIMER_MEM_PHYS_ACCESS     2
>>  #define ARCH_TIMER_MEM_VIRT_ACCESS     3
>>
>> +#define ARCH_TIMER_MEM_MAX_FRAMES      8
>> +
>>  #define ARCH_TIMER_USR_PCT_ACCESS_EN   (1 << 0) /* physical counter */
>>  #define ARCH_TIMER_USR_VCT_ACCESS_EN   (1 << 1) /* virtual counter */
>>  #define ARCH_TIMER_VIRT_EVT_EN         (1 << 2)
>> @@ -72,6 +74,21 @@ struct arch_timer_kvm_info {
>>         int virtual_irq;
>>  };
>>
>> +struct arch_timer_mem_frame {
>> +       int frame_nr;
>> +       phys_addr_t cntbase;
>> +       size_t size;
>> +       int phys_irq;
>> +       int virt_irq;
>> +};
>> +
>> +struct arch_timer_mem {
>> +       phys_addr_t cntctlbase;
>> +       size_t size;
>> +       int num_frames;
>> +       struct arch_timer_mem_frame frame[ARCH_TIMER_MEM_MAX_FRAMES];
>> +};
>
>
> Since struct is introduced but not used in this patch, how about
> squash it with patch 12/17?

In the previous patchset, I have been suggested that I should split it out.

>
> Thanks
> Hanjun



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
