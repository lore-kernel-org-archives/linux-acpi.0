From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v6 5/5] ACPICA: Remove PCI bits from ACPICA when
 CONFIG_PCI is unset
Date: Wed, 12 Dec 2018 22:06:58 +0100
Message-ID: <CAJZ5v0iN+OkN0+wy=jGA33Uz+wQT7=zxF-TX3e-TrHDnr4=YRA@mail.gmail.com>
References: <20181212171941.7437-1-okaya@kernel.org> <20181212171941.7437-6-okaya@kernel.org>
 <CF6A88132359CE47947DB4C6E1709ED53C556B2C@ORSMSX122.amr.corp.intel.com> <39dc076f-1b3d-ad0c-c4bb-056ac589f361@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <39dc076f-1b3d-ad0c-c4bb-056ac589f361@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: okaya@kernel.org, "Schmauss, Erik" <erik.schmauss@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Robert Moore <robert.moore@intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, devel@acpica.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Dec 12, 2018 at 8:34 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> On 12/12/2018 2:02 PM, Schmauss, Erik wrote:
> >> ++ b/drivers/acpi/acpica/achware.h
> >> @@ -109,8 +109,17 @@ acpi_hw_enable_runtime_gpe_block(struct
> >> acpi_gpe_xrupt_info *gpe_xrupt_info,
> > CONFIG_PCI is a Linux-ism. We should stay with the OS-independent nature of
> > ACPICA. Please use ACPI_PCI_CONFIGURED and put it above the comment like so:
> >
> > #ifdef ACPI_PCI_CONFIGURED
>
> Thanks for the feedback. My search for ACPI_PCI_CONFIGURED returned nothing.
>
> git grep ACPI_PCI_CONFIGURED
>
> @Rafael,
>
> How do you want to handle this?

I think what Eric suggested is effectively to introduce a new ACPICA
symbol.  Erik?
