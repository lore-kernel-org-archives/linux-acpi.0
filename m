From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v2 3/3] PCI/ACPI: allow ACPI to be built without PCI support
Date: Sun, 9 Dec 2018 08:20:24 +0200
Message-ID: <CAHp75VeCSPv81Bf2zjgFfD1YW2B6Z0YdhJsGR+Hvrf54mvdOPA@mail.gmail.com>
References: <20181208214644.5374-1-okaya@kernel.org> <20181208214644.5374-3-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181208214644.5374-3-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: okaya@kernel.org
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Robert Moore <robert.moore@intel.com>, "Schmauss, Erik" <erik.schmauss@intel.com>, Jan Kiszka <jan.kiszka@siemens.com>, otavio.pontes@intel.com, Christian Koenig <christian.koenig@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, devel@acpica.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Dec 8, 2018 at 11:46 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> We are compiling PCI code today for systems with ACPI and no PCI
> device present. Remove the useless code and reduce the tight
> dependency.

> +#ifdef CONFIG_PCI
>  struct pci_dev *acpi_get_pci_dev(acpi_handle);
> +#else
> +static inline struct pci_dev *acpi_get_pci_dev(acpi_handle hndl)

Can you spell handle fully?

> +{
> +       return NULL;
> +}
> +#endif

-- 
With Best Regards,
Andy Shevchenko
