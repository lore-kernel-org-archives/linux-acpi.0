From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 15/19] ACPI: identify device tree root by null parent
 pointer, not ACPI_BUS_TYPE
Date: Sun, 2 Aug 2009 10:44:45 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908021042440.3293@sony-vgn-z540>
References: <20090731213501.29930.39957.stgit@bob.kio> <20090731213749.29930.48586.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from s-utl02-sjpop.stsn.net ([72.254.0.202]:9401 "HELO
	s-utl02-sjpop.stsn.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752144AbZHBOtt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 2 Aug 2009 10:49:49 -0400
In-Reply-To: <20090731213749.29930.48586.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-acpi@vger.kernel.org

On Fri, 31 Jul 2009, Bjorn Helgaas wrote:

> We can identify the root of the ACPI device tree by the fact that it
> has no parent.  This is simpler than passing around ACPI_BUS_TYPE_SYSTEM
> and will help remove special treatment of the device tree root.
> 
> Currently, we add the root by hand with ACPI_BUS_TYPE_SYSTEM.  If we
> traverse the tree treating the root as just another device and use
> acpi_get_type(), the root shows up as ACPI_TYPE_DEVICE.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> ---
>  drivers/acpi/scan.c     |   18 +++++++++++-------
>  include/acpi/acpi_bus.h |    1 -
>  2 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index b97b2ad..c0736f6 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -950,10 +950,12 @@ static void acpi_device_get_busid(struct acpi_device *device)
>  	 * The device's Bus ID is simply the object name.
>  	 * TBD: Shouldn't this value be unique (within the ACPI namespace)?
>  	 */
> -	switch (device->device_type) {
> -	case ACPI_BUS_TYPE_SYSTEM:
> +	if (!device->parent) {

it is just a style thing, but i probably would
use a macro for this, such as ACPI_IS_ROOT(device)
to make the code read easier to the un-initiated.

thanks,
-Len Brown, Intel Open Source Technology Center


