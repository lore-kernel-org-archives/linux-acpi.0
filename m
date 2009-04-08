From: Mattia Dongili <malattia@linux.it>
Subject: Re: [PATCH] ACPICA: delete check for AML access to port 0x81-83
Date: Wed, 8 Apr 2009 10:46:15 +0900
Message-ID: <20090408014615.GA28377@kamineko.org>
References: <7a3045780904051727o3780c7d3hebb26028a1b4eba5@mail.gmail.com> <alpine.LFD.2.00.0904071754230.4799@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static-220-247-10-204.b-man.svips.gol.ne.jp ([220.247.10.204]:47352
	"EHLO smtp.kamineko.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752872AbZDHBqQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2009 21:46:16 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0904071754230.4799@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Rodrigo Luiz <rodrigo@gus-mg.org>, linux-acpi@vger.kernel.org

On Tue, Apr 07, 2009 at 05:56:09PM -0400, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> Sony laptops apparently write 4-bytes (rather than 1 byte)
> to debug port 0x80, which spews error messages:
> 
> Denied AML access to port 0x00000080/4 (DMA1 0x0081-0x0083) [20090320]
> 
> http://bugzilla.kernel.org/show_bug.cgi?id=13036
> 
> Signed-off-by: Len Brown <len.brown@intel.com>
Acked-by: Mattia Dongili <malattia@linux.it>

> ---
> 
> Rodrigo,
> Please verify that this makes the warnings go away.
> 
> thanks,
> -Len
> 
>  drivers/acpi/acpica/hwvalid.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/hwvalid.c b/drivers/acpi/acpica/hwvalid.c
> index bd3c937..7737afb 100644
> --- a/drivers/acpi/acpica/hwvalid.c
> +++ b/drivers/acpi/acpica/hwvalid.c
> @@ -90,7 +90,6 @@ static const struct acpi_port_info acpi_protected_ports[] = {
>  	{"PIT2", 0x0048, 0x004B, ACPI_OSI_WIN_XP},
>  	{"RTC", 0x0070, 0x0071, ACPI_OSI_WIN_XP},
>  	{"CMOS", 0x0074, 0x0076, ACPI_OSI_WIN_XP},
> -	{"DMA1", 0x0081, 0x0083, ACPI_OSI_WIN_XP},
>  	{"DMA1L", 0x0087, 0x0087, ACPI_OSI_WIN_XP},
>  	{"DMA2", 0x0089, 0x008B, ACPI_OSI_WIN_XP},
>  	{"DMA2L", 0x008F, 0x008F, ACPI_OSI_WIN_XP},
> -- 
> 1.6.2.2.446.gfbdc
> 
-- 
mattia
:wq!
