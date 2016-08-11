From: Fu Wei <fu.wei@linaro.org>
Subject: Re: [PATCH v10 0/8] acpi, clocksource: add GTDT driver and GTDT
 support in arm_arch_timer
Date: Thu, 11 Aug 2016 18:22:03 +0800
Message-ID: <CADyBb7tZDT2LMGnsWW_orR37dsfseijLEjzn59rLW9tbbxKVPQ@mail.gmail.com>
References: <1469535565-20924-1-git-send-email-fu.wei@linaro.org>
 <0befd611-91a7-88e9-1686-82929c1745e8@semihalf.com>
 <510fa357-a729-4ce1-7c10-4cef06feb7b7@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <510fa357-a729-4ce1-7c10-4cef06feb7b7@linaro.org>
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
Cc: Linaro ACPI Mailman List <linaro-acpi@lists.linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, rruigrok@codeaurora.org, Wim Van Sebroeck <wim@iguana.be>, wei@redhat.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Al Stone <al.stone@linaro.org>, Tomasz Nowicki <tn@semihalf.com>, Timur Tabi <timur@codeaurora.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Guenter Roeck <linux@roeck-us.net>, Len Brown <lenb@kernel.org>, harba@codeaurora.org, linux-watchdog@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Christopher Covington <cov@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, G Gregory <graeme.gregory@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux
List-Id: linux-acpi@vger.kernel.org

Hi Hanjun, Tomasz,

On 11 August 2016 at 18:15, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> Hi,
>
> On 2016/8/11 17:37, Tomasz Nowicki wrote:
>>
>> Hi Fu,
>>
>> Do you mind if I send IORT series where new drivers/acpi/arm64 directory
>> would be introduced in first place ? This means your GTDT set would
>> depend on IORT.
>
>
> I think it's reasonable as the IORT for ITS is the key device enablement
> for PCI MSI. I talked to Fuwei offline and he is fine with it.

That's no problem at all, will do.

Can I do this:
(1)apply Tomasz's v8 patchset on the master branch of upstream kernel
(2)rebase my v10 on the top of Tomasz's v8
(3)git format-patch as v11, repost it

Is that OK for everyone? :-)

>
> But both the GTDT patchset and IORT are in good shape now, can we
> targeting both of them for 4.9 kernel (since all go via tip tree)?
>
> Thanks
> Hanjun



-- 
Best regards,

Fu Wei
Software Engineer
Red Hat
