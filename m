From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v2 3/3] PCI/ACPI: allow ACPI to be built without PCI
 support
Date: Sun, 9 Dec 2018 11:03:37 -0500
Message-ID: <c5fbd30d-370c-929d-d64b-dbc45f9a3f90@kernel.org>
References: <20181208214644.5374-1-okaya@kernel.org>
 <20181208214644.5374-3-okaya@kernel.org>
 <CAHp75VeCSPv81Bf2zjgFfD1YW2B6Z0YdhJsGR+Hvrf54mvdOPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VeCSPv81Bf2zjgFfD1YW2B6Z0YdhJsGR+Hvrf54mvdOPA@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Robert Moore <robert.moore@intel.com>, "Schmauss, Erik" <erik.schmauss@intel.com>, Jan Kiszka <jan.kiszka@siemens.com>, otavio.pontes@intel.com, Christian Koenig <christian.koenig@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, devel@acpica.org
List-Id: linux-acpi@vger.kernel.org

On 12/9/2018 1:20 AM, Andy Shevchenko wrote:
>> +#ifdef CONFIG_PCI
>>   struct pci_dev *acpi_get_pci_dev(acpi_handle);
>> +#else
>> +static inline struct pci_dev *acpi_get_pci_dev(acpi_handle hndl)
> Can you spell handle fully?
> 

Yeah, I can do that.
