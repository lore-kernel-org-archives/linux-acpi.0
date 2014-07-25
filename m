From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 03/19] ARM64 / ACPI: Introduce lowlevel suspend function
Date: Fri, 25 Jul 2014 18:42:15 +0800
Message-ID: <53D23487.6090703@linaro.org>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <1406206825-15590-4-git-send-email-hanjun.guo@linaro.org>
 <20140724153406.GC26190@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140724153406.GC26190@leverpostej>
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
Cc: Mark Brown <broonie@linaro.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Will Deacon <Will.Deacon@arm.com>, Lv Zheng <lv.zheng@intel.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Robert Moore <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, Robert Richter <rric@kernel.org>, Jason Cooper <jason@lakedaemon.net>, Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <Marc.Zyngier@arm.com>, Liviu Dudau <Liviu.Dudau@arm.com>, "linaro-acpi-private@linaro.org" <linaro-acpi-private@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Randy Dunlap <rdunlap@infradea>
List-Id: linux-acpi@vger.kernel.org

On 2014-7-24 23:34, Mark Rutland wrote:
[...]
>>  early_param("acpi", parse_acpi);
>> +
>> +/*
>> + * acpi_suspend_lowlevel() - save kernel state and suspend.
>> + *
>> + * TBD when ARM/ARM64 starts to support suspend...
>> + */
>> +int (*acpi_suspend_lowlevel)(void);
> 
> Shouldn't this should be intialised to NULL explicitly?

Yes, as ARM64 does not support suspend, initialize it
to NULL will be fine, will update in next version.

Thanks
Hanjun
