From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: hardware radio switch ignored ( intel n 6300 ) - kernel 3.6 and higher
Date: Tue, 20 Aug 2013 23:15:56 +0200
Message-ID: <1635280.T7iXqIG7SW@vostro.rjw.lan>
References: <5213CBFE.3010000@ugent.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:52054 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142Ab3HTVFV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Aug 2013 17:05:21 -0400
In-Reply-To: <5213CBFE.3010000@ugent.be>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Wouter Depypere <wouter.depypere@ugent.be>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org

On Tuesday, August 20, 2013 10:05:18 PM Wouter Depypere wrote:
> Hi,
> 
> I recently updated my kernel (from 3.2.0.4 to 3.10) and noticed the
> hardware switch to enable/disable wireless didn't work anymore, it is
> completely ignored, dmesg shows no output. My laptop is a Dell E6230
> with an Intel Corporation Centrino Ultimate-N 6300 (rev 35) wireless
> adapter.
> 
> I bisected with git (bisect log and final output attached to this mail)
> and found the commit after which it stopped working:
> a57f7f9175b8ccbc9df83ac13860488913115de4
> 
> I commented out this line:
> 
> diff --git a/drivers/acpi/acpica/utosi.c b/drivers/acpi/acpica/utosi.c
> index 7e80772..ca06691 100644
> --- a/drivers/acpi/acpica/utosi.c
> +++ b/drivers/acpi/acpica/utosi.c
> @@ -73,7 +73,7 @@ static struct acpi_interface_info
> acpi_default_supported_interfaces[] = {
>         {"Windows 2006 SP1", NULL, 0, ACPI_OSI_WIN_VISTA_SP1},  /*
> Windows Vista SP1 - Added 09/2009 */
>         {"Windows 2006 SP2", NULL, 0, ACPI_OSI_WIN_VISTA_SP2},  /*
> Windows Vista SP2 - Added 09/2010 */
>         {"Windows 2009", NULL, 0, ACPI_OSI_WIN_7},      /* Windows 7 and
> Server 2008 R2 - Added 09/2009 */
> -       {"Windows 2012", NULL, 0, ACPI_OSI_WIN_8},      /* Windows 8 and
> Server 2012 - Added 08/2012 */
> +/*     {"Windows 2012", NULL, 0, ACPI_OSI_WIN_8},      /* Windows 8 and
> Server 2012 - Added 08/2012 */
>  
>         /* Feature Group Strings */
> 
> 
> I recompiled (both 3.10 and 3.11.0-rc6 kernels) and strangely enough my
> switch is working again.
> 
> Can somebody look into this?

If it works with 3.10.y and later, what exactly do you need?

Rafael

