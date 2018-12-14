From: Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v8 3/4] PCI/ACPI: Allow ACPI to be built without
 CONFIG_PCI set
Date: Fri, 14 Dec 2018 11:29:42 -0500
Message-ID: <578bb84f-ab1d-7e44-a6e1-7b0ff51c743a@kernel.org>
References: <20181214031252.28707-1-okaya@kernel.org>
 <20181214031252.28707-4-okaya@kernel.org>
 <CAJZ5v0j6u=E5xY-a=_D8wO5u=GOX9of3sG572pMSW+eB_e58Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0j6u=E5xY-a=_D8wO5u=GOX9of3sG572pMSW+eB_e58Ow@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, "Schmauss, Erik" <erik.schmauss@intel.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Jan Kiszka <jan.kiszka@siemens.com>, otavio.pontes@intel.com, ckoenig.leichtzumerken@gmail.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, devel@acpica.org
List-Id: linux-acpi@vger.kernel.org

On 12/14/2018 4:19 AM, Rafael J. Wysocki wrote:
> On Fri, Dec 14, 2018 at 4:13 AM Sinan Kaya<okaya@kernel.org>  wrote:
>> We are compiling PCI code today for systems with ACPI and no PCI
>> device present. Remove the useless code and reduce the tight
>> dependency.
>>
>> Signed-off-by: Sinan Kaya<okaya@kernel.org>
> Bjorn, any objections here?
> 

Found a breakage in arm64 build without CONFIG_PCI. I'll post a new version
soon.
