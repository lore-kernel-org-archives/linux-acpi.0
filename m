From: Steven Newbury <steve@snewbury.org.uk>
Subject: Re: [PATCH 1/2] ACPI / scan: Make namespace scanning and trimming
 mutually exclusive
Date: Tue, 29 Jan 2013 13:59:37 +0000
Message-ID: <1359467977.8924.0.camel@infinity>
References: <1581701.fnbebHrKch@vostro.rjw.lan>
	 <3032117.IcK9I7rYQT@vostro.rjw.lan>
	 <CAE9FiQV+DDb0ap=sipQjUWCdz8Qsfs2dYDVrb0FmKL4F1BjhOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from queueout02-winn.ispmail.ntl.com ([81.103.221.56]:47232 "EHLO
	queueout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756600Ab3A2P3V (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Jan 2013 10:29:21 -0500
In-Reply-To: <CAE9FiQV+DDb0ap=sipQjUWCdz8Qsfs2dYDVrb0FmKL4F1BjhOw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Jiang Liu <liuj97@gmail.com>, Toshi Kani <toshi.kani@hp.com>

On Sat, 2013-01-26 at 15:19 -0800, Yinghai Lu wrote:
> On Sat, Jan 26, 2013 at 2:41 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > There is no guarantee that acpi_bus_scan() and acpi_bus_trim() will
> > not be run in parallel for the same scope of the ACPI namespace,
> > which may lead to a great deal of confusion, so introduce a new mutex
> > to prevent that from happening.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Acked-by: Yinghai Lu <yinghai@kernel.org>
> 
> Steven,
> 
> Can you apply this one to for-pci-res-alloc to check if racing with
> docking hotplug/eject
> still happen?
> or wait one or two days after i rebase that branch.
> 
Still get the corrupt acpi_handle.

> Thanks
> 
> Yinghai
> 
> > ---
> >  drivers/acpi/scan.c |   16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > Index: linux-pm/drivers/acpi/scan.c
> > ===================================================================
> > --- linux-pm.orig/drivers/acpi/scan.c
> > +++ linux-pm/drivers/acpi/scan.c
> > @@ -52,6 +52,7 @@ static const struct acpi_device_id acpi_
> >
> >  static LIST_HEAD(acpi_device_list);
> >  static LIST_HEAD(acpi_bus_id_list);
> > +static DEFINE_MUTEX(acpi_scan_lock);
> >  DEFINE_MUTEX(acpi_device_lock);
> >  LIST_HEAD(acpi_wakeup_device_list);
> >
> > @@ -1612,19 +1613,22 @@ static acpi_status acpi_bus_device_attac
> >  int acpi_bus_scan(acpi_handle handle)
> >  {
> >         void *device = NULL;
> > +       int error = 0;
> > +
> > +       mutex_lock(&acpi_scan_lock);
> >
> >         if (ACPI_SUCCESS(acpi_bus_check_add(handle, 0, NULL, &device)))
> >                 acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
> >                                     acpi_bus_check_add, NULL, NULL, &device);
> >
> >         if (!device)
> > -               return -ENODEV;
> > -
> > -       if (ACPI_SUCCESS(acpi_bus_device_attach(handle, 0, NULL, NULL)))
> > +               error = -ENODEV;
> > +       else if (ACPI_SUCCESS(acpi_bus_device_attach(handle, 0, NULL, NULL)))
> >                 acpi_walk_namespace(ACPI_TYPE_ANY, handle, ACPI_UINT32_MAX,
> >                                     acpi_bus_device_attach, NULL, NULL, NULL);
> >
> > -       return 0;
> > +       mutex_unlock(&acpi_scan_lock);
> > +       return error;
> >  }
> >  EXPORT_SYMBOL(acpi_bus_scan);
> >
> > @@ -1653,6 +1657,8 @@ static acpi_status acpi_bus_remove(acpi_
> >
> >  void acpi_bus_trim(struct acpi_device *start)
> >  {
> > +       mutex_lock(&acpi_scan_lock);
> > +
> >         /*
> >          * Execute acpi_bus_device_detach() as a post-order callback to detach
> >          * all ACPI drivers from the device nodes being removed.
> > @@ -1667,6 +1673,8 @@ void acpi_bus_trim(struct acpi_device *s
> >         acpi_walk_namespace(ACPI_TYPE_ANY, start->handle, ACPI_UINT32_MAX, NULL,
> >                             acpi_bus_remove, NULL, NULL);
> >         acpi_bus_remove(start->handle, 0, NULL, NULL);
> > +
> > +       mutex_unlock(&acpi_scan_lock);
> >  }
> >  EXPORT_SYMBOL_GPL(acpi_bus_trim);
> >
> >


