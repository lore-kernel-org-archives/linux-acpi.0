From: Agustin Vega-Frias <agustinv@codeaurora.org>
Subject: Re: [PATCH V10 2/3] ACPI: Add support for ResourceSource/IRQ domain
 mapping
Date: Wed, 18 Jan 2017 14:02:53 -0500
Message-ID: <5bf630b0ab0b818db6e4e63a41020a55@codeaurora.org>
References: <1484757988-23739-1-git-send-email-agustinv@codeaurora.org>
 <1484757988-23739-3-git-send-email-agustinv@codeaurora.org>
 <CAHp75VcLL9zvRXGCy2ynjhYFUgbYwJvLpCiUxjtsKmXjVFHmKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAHp75VcLL9zvRXGCy2ynjhYFUgbYwJvLpCiUxjtsKmXjVFHmKA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: harba@codeaurora.org, guohanjun@huawei.com, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jason Cooper <jason@lakedaemon.net>, Graeme Gregory <graeme.gregory@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, Jon Masters <jcm@redhat.com>, Timur Tabi <timur@codeaurora.org>, msalter@redhat.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, astone@redhat.com, linux-acpi@vger.kernel.org, mlangsdo@redhat.com, Christopher Covington <cov@codeaurora.org>, Andy Gross <agross@codeaurora.org>, Thomas Gleixner <tglx@linutronix.de>, charles.garcia-tobin@arm.com, Al Stone <ahs3@redhat.com>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Hi Andy,

On 2017-01-18 13:00, Andy Shevchenko wrote:
> On Wed, Jan 18, 2017 at 6:46 PM, Agustin Vega-Frias
> <agustinv@codeaurora.org> wrote:
>> ACPI extended IRQ resources may contain a ResourceSource to specify
>> an alternate interrupt controller. Introduce acpi_irq_get and use it
>> to implement ResourceSource/IRQ domain mapping.
>> 
>> The new API is similar to of_irq_get and allows re-initialization
>> of a platform resource from the ACPI extended IRQ resource, and
>> provides proper behavior for probe deferral when the domain is not
>> yet present when called.
>> 
> 
> Care to use -M -C when prepare this patch?
> 

I did use it, but the similarity index was below the default threshold.
I'll send in a new version of this patch with this fixed.

Thanks,
Agustin

>>  drivers/acpi/gsi.c      |  98 -----------------
>>  drivers/acpi/irq.c      | 282 
>> ++++++++++++++++++++++++++++++++++++++++++++++++
> 
> --
> With Best Regards,
> Andy Shevchenko

-- 
Qualcomm Datacenter Technologies, Inc. on behalf of the Qualcomm 
Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a 
Linux Foundation Collaborative Project.
