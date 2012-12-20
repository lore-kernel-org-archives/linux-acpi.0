From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] ACPI: Remove unused struct acpi_pci_root.id member
Date: Thu, 20 Dec 2012 11:37:24 -0700
Message-ID: <CAErSpo5oFEa5RD1_EYLtwvwF0dZFpkUp9XqO_kJZ+c5bL-1TTw@mail.gmail.com>
References: <20121219173044.12424.11336.stgit@bhelgaas.mtv.corp.google.com> <6539457.htZABURDoR@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vb0-f49.google.com ([209.85.212.49]:45132 "EHLO
	mail-vb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751753Ab2LTShq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 20 Dec 2012 13:37:46 -0500
Received: by mail-vb0-f49.google.com with SMTP id r6so4107554vbi.8
        for <linux-acpi@vger.kernel.org>; Thu, 20 Dec 2012 10:37:45 -0800 (PST)
In-Reply-To: <6539457.htZABURDoR@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>

On Wed, Dec 19, 2012 at 6:22 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Wednesday, December 19, 2012 10:30:44 AM Bjorn Helgaas wrote:
>> This member is never initialized and never referenced, so remove it.
>
> Sure. :-)
>
> Do you want me to take this?

I assume you're going to push your namespace scan rework through your
tree, since most of the changes are in drivers/acpi.  That series also
touches acpi_bus.h, so probably makes the most sense for you to take
this as well.  I don't plan any future changes to the file.

There are more PCI-centric pci_root.c changes in the pipe, but we'll
have to sort those out later, I think.

Let me know if you think otherwise.

>> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>> ---
>>  include/acpi/acpi_bus.h |    1 -
>>  1 files changed, 0 insertions(+), 1 deletions(-)
>>
>> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
>> index 7ced5dc..4f42c0e 100644
>> --- a/include/acpi/acpi_bus.h
>> +++ b/include/acpi/acpi_bus.h
>> @@ -397,7 +397,6 @@ int unregister_acpi_bus_type(struct acpi_bus_type *);
>>  struct acpi_pci_root {
>>       struct list_head node;
>>       struct acpi_device * device;
>> -     struct acpi_pci_id id;
>>       struct pci_bus *bus;
>>       u16 segment;
>>       struct resource secondary;      /* downstream bus range */
>>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
