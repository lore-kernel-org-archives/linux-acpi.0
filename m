From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: Bad MAINTAINERS pattern in section 'ACPI'
Date: Sat, 29 Sep 2018 15:18:38 +0200
Message-ID: <CAJZ5v0hh899QjTTbzRK7oWqSH6GccV_H0weUUYJdVw8sQgyONQ@mail.gmail.com>
References: <20180928215054.28561-1-joe@perches.com> <20180928230616.GA150287@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180928230616.GA150287@bhelgaas-glaptop.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Joe Perches <joe@perches.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Keith Busch <keith.busch@intel.com>, Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>, Linux PCI <linux-pci@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Sep 29, 2018 at 1:06 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Tony, Borislav (ACPI APEI reviewers), linux-pci]
>
> On Fri, Sep 28, 2018 at 02:50:53PM -0700, Joe Perches wrote:
> > Please fix this defect appropriately.
> >
> > linux-next MAINTAINERS section:
> >
> >       308     ACPI
> >       309     M:      "Rafael J. Wysocki" <rjw@rjwysocki.net>
> >       310     M:      Len Brown <lenb@kernel.org>
> >       311     L:      linux-acpi@vger.kernel.org
> >       312     W:      https://01.org/linux-acpi
> >       313     Q:      https://patchwork.kernel.org/project/linux-acpi/list/
> >       314     T:      git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
> >       315     B:      https://bugzilla.kernel.org
> >       316     S:      Supported
> >       317     F:      drivers/acpi/
> >       318     F:      drivers/pnp/pnpacpi/
> >       319     F:      include/linux/acpi.h
> >       320     F:      include/linux/fwnode.h
> >       321     F:      include/acpi/
> >       322     F:      Documentation/acpi/
> >       323     F:      Documentation/ABI/testing/sysfs-bus-acpi
> >       324     F:      Documentation/ABI/testing/configfs-acpi
> >       325     F:      drivers/pci/*acpi*
> >       326     F:      drivers/pci/*/*acpi*
> > -->   327     F:      drivers/pci/*/*/*acpi*
> >       328     F:      tools/power/acpi/
>
> My proposal to fix this:
>
> commit a99051c0d3c59fd259fd76a8bbd9837b76b509d9
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Fri Sep 28 17:34:21 2018 -0500
>
>     MAINTAINERS: Remove obsolete drivers/pci pattern from ACPI section
>
>     Prior to 256a45937093 ("PCI/AER: Squash aerdrv_acpi.c into aerdrv.c"),
>     drivers/pci/pcie/aer/aerdrv_acpi.c contained code to parse the ACPI HEST
>     table.  That code now lives in drivers/pci/pcie/aer.c.
>
>     Remove the "F: drivers/pci/*/*/*acpi*" pattern because it matches nothing.
>
>     We could add a "F: drivers/pci/pcie/aer.c" pattern to the ACPI APEI
>     section, but that file sees a lot of changes, almost none of which are of
>     interest to the ACPI folks.
>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 700408b7bc53..9babd8a0406b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -324,7 +324,6 @@ F:  Documentation/ABI/testing/sysfs-bus-acpi
>  F:     Documentation/ABI/testing/configfs-acpi
>  F:     drivers/pci/*acpi*
>  F:     drivers/pci/*/*acpi*
> -F:     drivers/pci/*/*/*acpi*
>  F:     tools/power/acpi/

Looks good to me.

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
