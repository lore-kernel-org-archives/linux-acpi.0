From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] ACPI: Parse entire table as a term_list for Dell XPS 9570
 and Precision M5530
Date: Mon, 29 Jan 2018 14:56:45 +0200
Message-ID: <CAHp75VfQH6ssvp14HSLNGPL=eUVQCnrC-ifoKMuKoCkR1s=3YA@mail.gmail.com>
References: <20180129061011.11214-1-kai.heng.feng@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180129061011.11214-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mario Limonciello <mario.limonciello@dell.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 29, 2018 at 8:10 AM, Kai-Heng Feng
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

> +#ifdef CONFIG_X86

Why do you need separate #ifdef?

> +static const struct dmi_system_id gbl_term_list_dmi_table[] __initconst = {

I think you can just add new items to the existing table, while renaming it like

dsdt_dmi_table -> acpi_quirks_dmi_table

-- 
With Best Regards,
Andy Shevchenko
