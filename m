From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v3] ACPI: Parse entire table as a term_list for Dell XPS
 9570 and Precision M5530
Date: Sun, 4 Feb 2018 09:26:49 +0100
Message-ID: <CAJZ5v0ha9xZVSvUjUPO5ebM+JhPH7jk6W=M8AheirqOrhf8Ezg@mail.gmail.com>
References: <20180131045634.13328-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ot0-f195.google.com ([74.125.82.195]:41559 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750776AbeBDI0u (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Sun, 4 Feb 2018 03:26:50 -0500
In-Reply-To: <20180131045634.13328-1-kai.heng.feng@canonical.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, "Schmauss, Erik" <erik.schmauss@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mario Limonciello <mario.limonciello@dell.com>

On Wed, Jan 31, 2018 at 5:56 AM, Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
> The i2c touchpad on Dell XPS 9570 and Precision M5530 doesn't work out
> of box.
>
> The touchpad relies on its _INI method to update its _HID value from
> XXXX0000 to SYNA2393.
> Also, the _STA relies on value of I2CN to report correct status.
>
> Set acpi_gbl_parse_table_as_term_list so the value of I2CN can be
> correctly set up, and _INI can get run. The ACPI table in this machine
> is designed to get parsed this way.
>
> Also, change the quirk table to a more generic name.
>
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=198515
> Cc: Mario Limonciello <mario.limonciello@dell.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
> v3: Put the function under right #ifdef, comment adjustment
>
> v2: Andy's suggestion, merge to a single quirk table.
>
>  drivers/acpi/bus.c | 40 +++++++++++++++++++++++++++++++++-------
>  1 file changed, 33 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 4d0979e02a28..7cb18bc2b59a 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -66,10 +66,39 @@ static int set_copy_dsdt(const struct dmi_system_id *id)
>         return 0;
>  }
>  #endif
> +static int set_gbl_term_list(const struct dmi_system_id *id)
> +{
> +       pr_notice("%s detected - parse the entire table as a term_list\n",
> +                 id->ident);

This is not a useful message for a user (who may not know what
trem_list is).  Care to change it to something more useful, or even
drop it?
