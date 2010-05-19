From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 3/3] ACPI: Enable Windows ioport access compatibility on Windows-compatible systems
Date: Wed, 19 May 2010 10:25:58 -0600
Message-ID: <201005191025.59005.bjorn.helgaas@hp.com>
References: <1274283791-3380-1-git-send-email-mjg@redhat.com> <1274283791-3380-3-git-send-email-mjg@redhat.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:45702 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241Ab0ESQ0J (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 19 May 2010 12:26:09 -0400
In-Reply-To: <1274283791-3380-3-git-send-email-mjg@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>
Cc: linux-acpi@vger.kernel.org, robert.moore@intel.com, lenb@kernel.org

On Wednesday, May 19, 2010 09:43:11 am Matthew Garrett wrote:
> Windows ignores everything but the lower 16 bits of system io accesses.
> Enable compatibility with it if the firmware indicates Windows compatibility
> by requesting a version of Windows via the _OSI method.
> 
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
> ---
>  drivers/acpi/bus.c |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 743576b..a10144b 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -904,6 +904,14 @@ static int __init acpi_bus_init(void)
>  		goto error1;
>  	}
>  
> +	/*
> +	 * _SB_._INI has been called, so any _OSI requests should now have
> +	 * been completed - enable any OS-specific workarounds
> +	 */
> +
> +	if (acpi_gbl_osi_data >= ACPI_OSI_WIN_2000)
> +		acpi_gbl_ignore_high_ioport_bits = TRUE;

What's the basis for the Win 2000 check?  Is the intent that we
do this for all Windows versions?  Wikipedia claims Windows 98 had
ACPI support, but there's no ACPI_OSI_WIN_98 definition.

Is there a reason why we wouldn't just set ignore_high_ioport_bits = TRUE
always?

I'm sure you're doing this right; I'm just hoping for enough details
that if we ever *do* have a valid IO address that doesn't fit in 16
bits, we'll be able to accomodate that without breaking old boxes
again.

Bjorn
