From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH] PCI / ACPI: Make acpiphp ignore root bridges using PCIe
 native hotplug
Date: Sat, 22 Oct 2011 14:58:12 -0700
Message-ID: <CAE9FiQUxuajrqka97M_tvbXoMSzPTBGyjiBib_EG4MjRTuNmFQ@mail.gmail.com>
References: <201110220043.38635.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:41537 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752061Ab1JVV6N (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 22 Oct 2011 17:58:13 -0400
In-Reply-To: <201110220043.38635.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PCI <linux-pci@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>

On Fri, Oct 21, 2011 at 3:43 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> If the kernel has requested control of the PCIe native hotplug
> feature for a given root complex, the acpiphp driver should not try
> to handle that root complex and it should leave it to pciehp.
> Failing to do so causes problems to happen if acpiphp is loaded
> before pciehp on such systems.

Should pciehp be built-in kernel instead of as a module?

Yinghai
