From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] ACPI: EC: Simplify boot EC checks in acpi_ec_add()
Date: Tue, 22 Jan 2019 13:03:55 +0100
Message-ID: <CAJZ5v0hpR2rVnzKUqzEB=vTWsZ6uGDrKrwsc=w_uPRF65TRQ_Q@mail.gmail.com>
References: <2897234.rJkq6cDEjt@aspire.rjw.lan> <6098592.dL5p0bd45o@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <6098592.dL5p0bd45o@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: Erik Schmauss <erik.schmauss@intel.com>, Zhang Rui <rui.zhang@intel.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jan 22, 2019 at 1:01 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Consolidate boot EC checks in acpi_ec_add(), put the acpi_is_boot_ec()
> checks directly into it and drop the latter.
>
> No intentional functional impact.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

This is the second patch in the series, the numbering in the subject
is incorrect.  Sorry about that.

> ---
>  drivers/acpi/ec.c |   20 +++++---------------
>  1 file changed, 5 insertions(+), 15 deletions(-)
>
> Index: linux-pm/drivers/acpi/ec.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/ec.c
> +++ linux-pm/drivers/acpi/ec.c
> @@ -1558,16 +1558,6 @@ static bool acpi_ec_ecdt_get_handle(acpi
>         return true;
>  }
>
> -static bool acpi_is_boot_ec(struct acpi_ec *ec)
> -{
> -       if (!boot_ec)
> -               return false;
> -       if (ec->command_addr == boot_ec->command_addr &&
> -           ec->data_addr == boot_ec->data_addr)
> -               return true;
> -       return false;
> -}
> -
>  static int acpi_ec_add(struct acpi_device *device)
>  {
>         struct acpi_ec *ec = NULL;
> @@ -1579,22 +1569,22 @@ static int acpi_ec_add(struct acpi_devic
>         strcpy(acpi_device_class(device), ACPI_EC_CLASS);
>
>         if (!strcmp(acpi_device_hid(device), ACPI_ECDT_HID)) {
> -               is_ecdt = true;
>                 ec = boot_ec;
> +               boot_ec_is_ecdt = true;
> +               is_ecdt = true;
>         } else {
>                 ec = acpi_ec_alloc();
>                 if (!ec)
>                         return -ENOMEM;
> +
>                 status = ec_parse_device(device->handle, 0, ec, NULL);
>                 if (status != AE_CTRL_TERMINATE) {
>                         ret = -EINVAL;
>                         goto err_alloc;
>                 }
> -       }
>
> -       if (acpi_is_boot_ec(ec)) {
> -               boot_ec_is_ecdt = is_ecdt;
> -               if (!is_ecdt) {
> +               if (boot_ec && ec->command_addr == boot_ec->command_addr &&
> +                   ec->data_addr == boot_ec->data_addr) {
>                         /*
>                          * Trust PNP0C09 namespace location rather than
>                          * ECDT ID. But trust ECDT GPE rather than _GPE
>
