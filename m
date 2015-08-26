From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>
Subject: Re: [PATCH V2 0/4] PCI: ACPI: Setting up DMA coherency for PCI device
 from _CCA attribute
Date: Wed, 26 Aug 2015 09:36:28 +0700
Message-ID: <55DD262C.3010008@amd.com>
References: <1440524009-5359-1-git-send-email-Suravee.Suthikulpanit@amd.com>
 <240091906.Gl2z931jjW@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <240091906.Gl2z931jjW@wuerfel>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, will.deacon@arm.com, linux-acpi@vger.kernel.org, hanjun.guo@linaro.org, linux-pci@vger.kernel.org, bhelgaas@google.com, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Arnd,

On 8/26/15 01:48, Arnd Bergmann wrote:
> On Wednesday 26 August 2015 00:33:25 Suravee Suthikulpanit wrote:
>> This patch adds support to setup DMA coherency for PCI device using
>> the ACPI _CCA attribute. According to the ACPI spec, the _CCA attribute
>> is required for ARM64. Therefore, this patch is a pre-req for ACPI PCI
>> support for ARM64 which is currently in development.
>>
>> Also, this should not affect other architectures that does not define
>> CONFIG_ACPI_CCA_REQUIRED, since the default value is coherent.
>>
>
> We only support ACPI on SBSA compliant platforms, and SBSA mandates
> cache-coherent PCI, so I don't think this is actually needed,
> just use coherent all the time and do WARN_ON(!CCA) to catch people
> that try to incorrectly use ACPI on a non-SBSA platform.
>
> 	Arnd

Thanks for pointing out. The CONFIG_ACPI_CCA_REQUIRED is already existed 
and selected in arch/arm64/Kconfig, and used for both PCI and non-PCI 
devices. I am not adding anything specific for the PCI case.

Although, I think WARN_ON(!CCA) when it is required is a good idea. I'll 
find a proper place for it.

Thanks,
Suravee.

> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
