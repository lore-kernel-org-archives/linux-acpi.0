From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [PATCH 04/20] ARM64 / ACPI: Introduce arm_core.c and its related
 head file
Date: Sat, 18 Jan 2014 12:05:24 +0800
Message-ID: <52D9FD84.9090808@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <1389961514-13562-5-git-send-email-hanjun.guo@linaro.org>
 <20140117141241.GH16003@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20140117141241.GH16003@mudshark.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>, Matthew Garrett <mjg59@srcf.ucam.org>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Al Stone <al.stone@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Olof Johansson <olof@lixom.net>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "patches@linaro.org" <patches@linaro.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, "graeme.gregory@linaro.org" <graeme.gregory@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lis>
List-Id: linux-acpi@vger.kernel.org

On 2014-1-17 22:12, Will Deacon wrote:
> On Fri, Jan 17, 2014 at 12:24:58PM +0000, Hanjun Guo wrote:
>> Introduce arm_core.c and its related head file, after this patch,
>> we can get ACPI tables from firmware on ARM64 now.
>>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> 
> [...]
> 
>> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
>> index bd9bbd0..2210353 100644
>> --- a/arch/arm64/kernel/setup.c
>> +++ b/arch/arm64/kernel/setup.c
>> @@ -41,6 +41,7 @@
>>  #include <linux/memblock.h>
>>  #include <linux/of_fdt.h>
>>  #include <linux/of_platform.h>
>> +#include <linux/acpi.h>
>>  
>>  #include <asm/cputype.h>
>>  #include <asm/elf.h>
>> @@ -225,6 +226,11 @@ void __init setup_arch(char **cmdline_p)
>>  
>>  	arm64_memblock_init();
>>  
>> +	/* Parse the ACPI tables for possible boot-time configuration */
>> +	acpi_boot_table_init();
>> +	early_acpi_boot_init();
>> +	acpi_boot_init();
> 
> Do we really need *three* back-to-back calls for ACPI to initialise?

Sorry, my colleague Graeme had integrate them as one function but I
forgot to merge them in this patch, my bad, will update it in next
version.

Thanks
Hanjun
