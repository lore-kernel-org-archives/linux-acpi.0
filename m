From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI/EC: Add msi quirk for Clevo W350etq
Date: Tue, 02 Sep 2014 23:52:10 +0200
Message-ID: <1789359.lgutrb7SVa@vostro.rjw.lan>
References: <1409280608-19714-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:61517 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755153AbaIBVcw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Sep 2014 17:32:52 -0400
In-Reply-To: <1409280608-19714-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, qbanin@gmail.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Friday, August 29, 2014 10:50:08 AM Lan Tianyu wrote:
> Clevo W350etq's EC will not produce GPE interrupt some time after
> booting. The ACPI notify event won't trigger when the issue takes
> place. After debugging, adding msi quirk for the machine can fix
> the issue. This patch is to add msi quirk for the machine.
> 
> Reference: https://bugzilla.kernel.org/show_bug.cgi?id=77431
> Reported-and-tested-by: qbanin@gmail.com
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>

Queued up for 3.17-rc4, thanks!

> ---
>  drivers/acpi/ec.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index a66ab65..d8535b3 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -1015,6 +1015,10 @@ static struct dmi_system_id ec_dmi_table[] __initdata = {
>  	DMI_MATCH(DMI_SYS_VENDOR, "Quanta"),
>  	DMI_MATCH(DMI_PRODUCT_NAME, "TW9/SW9"),}, NULL},
>  	{
> +	ec_flag_msi, "Clevo W350etq", {
> +	DMI_MATCH(DMI_SYS_VENDOR, "CLEVO CO."),
> +	DMI_MATCH(DMI_PRODUCT_NAME, "W35_37ET"),}, NULL},
> +	{
>  	ec_validate_ecdt, "ASUS hardware", {
>  	DMI_MATCH(DMI_BIOS_VENDOR, "ASUS") }, NULL},
>  	{
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
