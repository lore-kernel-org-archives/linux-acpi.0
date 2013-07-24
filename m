From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/30] ACPI / hotplug / PCI: Major rework + Thunderbolt workarounds
Date: Wed, 24 Jul 2013 10:06:01 -0600
Message-ID: <CAErSpo6z9CqCyLFbXpuJMtHHjLRNbo=gx87W_0_7TCHbvwrCRw@mail.gmail.com>
References: <26431283.HJCKsss0rt@vostro.rjw.lan> <3215120.cRBBS5jciE@vostro.rjw.lan>
 <CAE9FiQURY5WFFJekPHV_s0HPi8uhKzSDOLSXHAkyLPf1=i8oAw@mail.gmail.com> <6958813.eThhpoh5QO@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:41332 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752090Ab3GXQGX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Jul 2013 12:06:23 -0400
Received: by mail-ob0-f173.google.com with SMTP id er7so4923330obc.32
        for <linux-acpi@vger.kernel.org>; Wed, 24 Jul 2013 09:06:23 -0700 (PDT)
In-Reply-To: <6958813.eThhpoh5QO@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Yinghai Lu <yinghai@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Jiang Liu <liuj97@gmail.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>

On Wed, Jul 24, 2013 at 6:58 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday, July 23, 2013 07:20:53 PM Yinghai Lu wrote:
>> On Tue, Jul 23, 2013 at 2:39 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>
> [...]
>
>> [  102.631369] pci_host_bridge pci0000:00: freeing pci_host_bridge info
>
> By the way this looks fishy:
>
>> [  102.633091] ACPI: Device does not support D3cold

This and other printks in that function don't give any clue what
device is involved, even though we have an acpi_device pointer.  It'd
be nice to fix that, too.
