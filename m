From: Len Brown <lenb@kernel.org>
Subject: Re: [GIT PATCH] ACPI patches for 2.6.23-rc1
Date: Wed, 25 Jul 2007 15:44:35 -0400
Message-ID: <200707251544.35811.lenb@kernel.org>
References: <200707251238.50218.lenb@kernel.org> <20070725164928.GA15918@dose.home.local>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:59729 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751101AbXGYTol (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2007 15:44:41 -0400
In-Reply-To: <20070725164928.GA15918@dose.home.local>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tino Keitel <tino.keitel@tikei.de>
Cc: linux-acpi@vger.kernel.org

On Wednesday 25 July 2007 12:49, Tino Keitel wrote:
> On Wed, Jul 25, 2007 at 12:38:50 -0400, Len Brown wrote:
> > Len Brown (5):
> >       ACPI: Kconfig: CONFIG_ACPI_PROCFS now defaults to N
> 
> Hi,
> 
> where can I find the information in /proc/acpi/battery and
> /proc/acpi/processor without procfs?

CONFIG_ACPI_PROCFS applies only to the deprecated /proc files
listed in the Kconfig help -- it doesn't apply (yet)
to /proc/acpi/battery and /proc/acpi/processor

see the patch here:

http://marc.info/?l=linux-acpi&m=118534272010912&w=2

cheers,
-Len
