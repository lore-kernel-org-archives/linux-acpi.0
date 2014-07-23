From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: Re: [PATCH v5 0/3] APEI: Make APEI architecture independent.
Date: Wed, 23 Jul 2014 09:40:44 +0200
Message-ID: <53CF66FC.1040604@linaro.org>
References: <1406020813-9176-1-git-send-email-tomasz.nowicki@linaro.org> <CA+8MBb+KuKaeXr5p97xWZKJB7T-NAooi-kXQTaPx0QnO53-oCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+8MBb+KuKaeXr5p97xWZKJB7T-NAooi-kXQTaPx0QnO53-oCQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tony Luck <tony.luck@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Borislav Petkov <bp@alien8.de>, "m.chehab@samsung.com" <m.chehab@samsung.com>, Borislav Petkov <bp@suse.de>, rric@kernel.org, Linux Edac Mailing List <linux-edac@vger.kernel.org>, X86-ML <x86@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linaro-acpi@lists.linaro.org
List-Id: linux-acpi@vger.kernel.org

Many thanks Tony! And thanks goes to Borislav and Robert too.

Regards,
Tomasz

On 22.07.2014 23:08, Tony Luck wrote:
> On Tue, Jul 22, 2014 at 2:20 AM, Tomasz Nowicki
> <tomasz.nowicki@linaro.org> wrote:
>> APEI is currently implemented so that it depends on x86 hardware.
>> The primary dependency is that GHES uses the x86 NMI for hardware
>> error notification and MCE for memory error handling. These patches
>> remove that dependency.
>>
>> Other APEI features such as error reporting via external IRQ, error
>> serialization, or error injection, do not require changes to use them
>> on non-x86 architectures.
>>
>> The following patch set eliminates the APEI Kconfig x86 dependency
>> by making these changes:
>> - treat NMI notification as GHES architecture - HAVE_ACPI_APEI_NMI
>> - group and wrap around #ifdef CONFIG_HAVE_ACPI_APEI_NMI code which
>>    is used only for NMI path
>> - identify architectural boxes and abstract it accordingly (tlb flush and MCE)
>> - rework ioremap for both IRQ and NMI context
>>
>> NMI code is kept in ghes.c file since NMI and IRQ context are tightly coupled.
>>
>> Note, these patches introduce no functional changes for x86. The NMI notification
>> feature is hard selected for x86. Architectures that want to use this
>> feature should also provide NMI code infrastructure.
>
> Looks OK to me. I've thrown this series into a topic branch of the ras
> git tree named "apei".  When I push it to kernel.org in a few minutes
> the build test robots will pounce and try all sorts of randconfig builds.
> They'll send you (and me) e-mails if they find any corner cases.
>
> -Tony
>
