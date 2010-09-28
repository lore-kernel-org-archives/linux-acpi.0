From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [PATCH 1/1] acpi: clear PCIEXP_WAKE_STS on resume
Date: Tue, 28 Sep 2010 08:31:21 -0700
Message-ID: <20100928083121.f76e8991.rdunlap@xenotime.net>
References: <1285671624-7826-1-git-send-email-colin.king@canonical.com>
	<1285671624-7826-2-git-send-email-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xenotime.net ([72.52.115.56]:36633 "HELO xenotime.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751229Ab0I1PbY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 28 Sep 2010 11:31:24 -0400
Received: from chimera.site ([173.50.240.230]) by xenotime.net for <linux-acpi@vger.kernel.org>; Tue, 28 Sep 2010 08:31:21 -0700
In-Reply-To: <1285671624-7826-2-git-send-email-colin.king@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Tue, 28 Sep 2010 12:00:24 +0100 Colin King wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Section 4.7.3.1.1 (PM1 Status Registers) of version 4.0 of
> the ACPI spec concerning PCIEXP_WAKE_STS points out in
> in the final note field in table 4-11 that if this bit is
> set to 1 and the system is put into a sleeping state then
> the system will not automatically wake.
> 
> This bit gets set by hardware to indicate that the system
> woke up due to a PCI Express wakeup event, so clear it during
> acpi_hw_clear_acpi_status() calls to enable subsequent
> resumes to work.
> 
> BugLink: http://bugs.launchpad.net/bugs/613381
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/acpi/acpica/aclocal.h |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
> index 147a7e6..f26db38 100644
> --- a/drivers/acpi/acpica/aclocal.h
> +++ b/drivers/acpi/acpica/aclocal.h
> @@ -853,6 +853,7 @@ struct acpi_bit_register_info {
>  	ACPI_BITMASK_POWER_BUTTON_STATUS   | \
>  	ACPI_BITMASK_SLEEP_BUTTON_STATUS   | \
>  	ACPI_BITMASK_RT_CLOCK_STATUS       | \
> +        ACPI_BITMASK_PCIEXP_WAKE_DISABLE   | \

(1) Above should be indented with tabs, not spaces.

(2) It should not take 2 emails to send a patch with one line changed.
Patch 0/N is unnecessary and not desirable on short patch series (N = 1 is short).

>  	ACPI_BITMASK_WAKE_STATUS)
>  
>  #define ACPI_BITMASK_TIMER_ENABLE               0x0001
> -- 


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
