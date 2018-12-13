From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v7 2/5] ACPI / OSL: Stub out acpi_os_read_pci_configuration
 when CONFIG_PCI is unset
Date: Thu, 13 Dec 2018 17:20:03 +0100
Message-ID: <CAJZ5v0jHMa=7+L0MhGtD4f0At=CystTb2kEbedQuzzB4WWaDGw@mail.gmail.com>
References: <20181213044833.23952-1-okaya@kernel.org> <20181213044833.23952-3-okaya@kernel.org>
 <CAJZ5v0iZa_m8zL+BKrpMNRhPF=6k__jCtiKSk6ZBFDc3pXMi1g@mail.gmail.com> <a24b13db-049d-5027-4c49-81cdc0782c2a@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a24b13db-049d-5027-4c49-81cdc0782c2a@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: okaya@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Dec 13, 2018 at 5:04 PM Sinan Kaya <okaya@kernel.org> wrote:
>
> On 12/13/2018 6:15 AM, Rafael J. Wysocki wrote:
> > On Thu, Dec 13, 2018 at 5:49 AM Sinan Kaya <okaya@kernel.org> wrote:
> >>
> >> Getting ready to allow CONFIG_PCI to be disabled with ACPI enabled. Stub
> >> out acpi_os_read_pci_configuration function that depend on PCI.
> >
> > Why don't you merge this with the next patch?  Is there any particular
> > reason why they should be separate?
> >
>
> I could. I thought it would be easier to review small pieces.
>
> Let me know your preference.

IMO it would be better to merge them.
