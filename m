From: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [PATCH] ACPI: Remove useless type argument of driver .remove()
 operation
Date: Tue, 22 Jan 2013 14:24:27 -0700
Message-ID: <1358889867.14145.354.camel@misato.fc.hp.com>
References: <1518653.CUpDmbmCI3@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:5216 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512Ab3AVVe0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 22 Jan 2013 16:34:26 -0500
In-Reply-To: <1518653.CUpDmbmCI3@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>

On Sun, 2013-01-20 at 23:04 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> The second argument of ACPI driver .remove() operation is only used
> by the ACPI processor driver and the value passed to that driver
> through it is always available from the given struct acpi_device
> object's removal_type field.  For this reason, the second ACPI driver
> .remove() argument is in fact useless, so drop it.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks for the clean-up!  It looks good. 

Acked-by: Toshi Kani <toshi.kani@hp.com>

-Toshi


