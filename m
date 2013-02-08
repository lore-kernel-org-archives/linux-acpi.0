From: Yinghai Lu <yinghai@kernel.org>
Subject: Re: [PATCH 2/2] ACPI / scan: Make container driver use struct acpi_scan_handler
Date: Thu, 7 Feb 2013 19:32:22 -0800
Message-ID: <CAE9FiQW6BDpSjNjbinHEkpud2QqQOqskkXca6z+Fq0fo+=pKyQ@mail.gmail.com>
References: <1873429.MS5RQDxTye@vostro.rjw.lan>
	<5090866.2BHgpRnuEZ@vostro.rjw.lan>
	<1468930.acVuhKfKYv@vostro.rjw.lan>
	<6697533.ch61jtPBiZ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175]:46308 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755392Ab3BHDcX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2013 22:32:23 -0500
In-Reply-To: <6697533.ch61jtPBiZ@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas <bhelgaas@google.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Matthew Garrett <matthew.garrett@nebula.com>, Jiang Liu <liuj97@gmail.com>, Toshi Kani <toshi.kani@hp.com>, LKML <linux-kernel@vger.kernel.org>, Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>

On Thu, Feb 7, 2013 at 4:27 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Make the ACPI container driver use struct acpi_scan_handler for
> representing the object used to initialize ACPI containers and remove
> the ACPI driver structure used previously and the data structures
> created by it, since in fact they were not used for any purpose.
>
> This simplifies the code and reduces the kernel's memory footprint by
> avoiding the registration of a struct device_driver object with the
> driver core and creation of its sysfs directory which is unnecessary.
>
> In addition to that, make the namespace walk callback used for
> installing the notify handlers for ACPI containers more
> straightforward.
>
> This change includes fixes from Toshi Kani.
>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Yes, container support should be built-in by nature.

Acked-by: Yinghai Lu <yinghai@kernel.org>

What is the next?

dock?

Hope someone with access of dock that have pcie devices could help
sorting it out...

Thanks

Yinghai
