From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI: Remove useless type argument of driver .remove() operation
Date: Tue, 22 Jan 2013 23:05:45 +0100
Message-ID: <4985933.byC9yivxkj@vostro.rjw.lan>
References: <1518653.CUpDmbmCI3@vostro.rjw.lan> <1358889867.14145.354.camel@misato.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:50675 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752888Ab3AVV7n (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 22 Jan 2013 16:59:43 -0500
In-Reply-To: <1358889867.14145.354.camel@misato.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Toshi Kani <toshi.kani@hp.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Bjorn Helgaas <bhelgaas@google.com>, Yinghai Lu <yinghai@kernel.org>

On Tuesday, January 22, 2013 02:24:27 PM Toshi Kani wrote:
> On Sun, 2013-01-20 at 23:04 +0100, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > The second argument of ACPI driver .remove() operation is only used
> > by the ACPI processor driver and the value passed to that driver
> > through it is always available from the given struct acpi_device
> > object's removal_type field.  For this reason, the second ACPI driver
> > .remove() argument is in fact useless, so drop it.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Thanks for the clean-up!  It looks good. 
> 
> Acked-by: Toshi Kani <toshi.kani@hp.com>

Thanks!

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
