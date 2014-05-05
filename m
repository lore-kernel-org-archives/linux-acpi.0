From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: Re: [PATCH 1/7] apei, mce: Call MCE-specific code only for X86 architecture.
Date: Mon, 05 May 2014 17:32:07 +0200
Message-ID: <5367AEF7.40804@linaro.org>
References: <1397056476-9183-1-git-send-email-tomasz.nowicki@linaro.org> <1397056476-9183-2-git-send-email-tomasz.nowicki@linaro.org> <20140505114445.GB4373@pd.tnic> <5367A181.3060300@linaro.org> <20140505145331.GC4373@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20140505145331.GC4373@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com, bp@suse.de, m.chehab@samsung.com, linux-edac@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org
List-Id: linux-acpi@vger.kernel.org

On 05.05.2014 16:53, Borislav Petkov wrote:
> On Mon, May 05, 2014 at 04:34:41PM +0200, Tomasz Nowicki wrote:
>> acpi_disable_cmcff as global value can switch off/on MC entries
>> analysing via kernel args.
>
> No, it switches off firmware first mode for correctable errors because
> of buggy BIOSes - 9ad95879cd1b2 (what else...)
>
>> This glob value resides in x86 ACPI code and has meaning only for MCE
>> related mechanism,
>
> Of course it doesn't!
>
>> that is why I have moved it under hest_parse_cmc.
>
> See APEI section in the ACPI spec "18.4 Firmware First Error Handling."
>
> Regardless of what your version of APEI does, you actually shouldn't
> need to touch acpi_disable_cmcff at all as it not arch-specific.
>

You are right! I will fix that big misunderstanding from my side in next 
patch version.

Thanks,
Tomasz
