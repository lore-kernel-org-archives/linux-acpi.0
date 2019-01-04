From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v5 05/11] platform/x86: intel_pmc: Make PCI dependency explicit
Date: Fri, 4 Jan 2019 16:20:00 +0200
Message-ID: <CAHp75VfGe=rdN0JeLoHnPM0XuVunH5RvAmMEqbxFPWA7BmkzEw@mail.gmail.com>
References: <20190102181038.4418-1-okaya@kernel.org> <20190102181038.4418-6-okaya@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190102181038.4418-6-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sinan Kaya <okaya@kernel.org>, Kuppuswamy Sathyanarayanan <sathyanarayanan.kupuswamy@linux.intel.com>, "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Cc: linux-next <linux-next@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, Andy Shevchenko <andy@infradead.org>, Platform Driver <platform-driver-x86@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Jan 2, 2019 at 8:10 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
> CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
> satisfied implicitly through dependencies on CONFIG_ACPI have to be
> specified directly. Code relies on PCI for execution. Specify this
> in the Kconfig.
>

Unfortunately, this is not how it should be fixed.

First of all, we (Heikki, Sathya, me =E2=80=94  all in Cc list) that this
driver should be refactored and unified with intel_scu_ipc.
Then, it has two drivers inside and PCI is just a glue for it which is
optional. Thus, needs to be split accordingly.

> Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PC=
I set")
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/platform/x86/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index b36ea14b41ad..7afb96cb1cd6 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1174,7 +1174,7 @@ config INTEL_SMARTCONNECT
>
>  config INTEL_PMC_IPC
>         tristate "Intel PMC IPC Driver"
> -       depends on ACPI
> +       depends on ACPI && PCI
>         ---help---
>         This driver provides support for PMC control on some Intel platfo=
rms.
>         The PMC is an ARC processor which defines IPC commands for commun=
ication
> --
> 2.19.0
>


--=20
With Best Regards,
Andy Shevchenko
