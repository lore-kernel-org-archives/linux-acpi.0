From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] acpi/sleep: Use the FADT to prefer Suspend-to-Idle
 instead of S3
Date: Fri, 11 Nov 2016 00:53:55 +0100
Message-ID: <CAJZ5v0hLf+N7YakJrzfrWAgKF=Ywyx2v70hGes0+52brWMYnSA@mail.gmail.com>
References: <1478813718-12521-1-git-send-email-mario.limonciello@dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qk0-f194.google.com ([209.85.220.194]:35844 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932739AbcKJXyL (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Nov 2016 18:54:11 -0500
Received: by mail-qk0-f194.google.com with SMTP id h201so112561qke.3
        for <linux-acpi@vger.kernel.org>; Thu, 10 Nov 2016 15:54:10 -0800 (PST)
In-Reply-To: <1478813718-12521-1-git-send-email-mario.limonciello@dell.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario Limonciello <mario.limonciello@dell.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@kernel.org>

On Thu, Nov 10, 2016 at 10:35 PM, Mario Limonciello
<mario.limonciello@dell.com> wrote:
> If the ACPI_FADT_LOW_POWER_S0 bit is set, this indicates the platform
> should get identical or better performance using Suspend-To-Idle.
>
> By removing S3 and S1 userspace will prefer suspend-to-idle in
> these situations too.
>
> Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> ---
>  drivers/acpi/sleep.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index deb0ff7..ff1d8f1 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -171,6 +171,12 @@ static int __init init_nvs_nosave(const struct dmi_system_id *d)
>         return 0;
>  }
>
> +static bool suspend_to_idle_preferred(void)
> +{
> +       return (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0);
> +}
> +
> +
>  static struct dmi_system_id acpisleep_dmi_table[] __initdata = {
>         {
>         .callback = init_old_suspend_ordering,
> @@ -908,6 +914,11 @@ int __init acpi_sleep_init(void)
>                 acpi_no_s5 = true;
>         }
>
> +       if (suspend_to_idle_preferred()) {
> +               sleep_states[ACPI_STATE_S3] = 0;
> +               sleep_states[ACPI_STATE_S1] = 0;
> +       }
> +
>         supported[0] = 0;
>         for (i = 0; i < ACPI_S_STATE_COUNT; i++) {
>                 if (sleep_states[i])
> --

I'd do that in a different way.

Let me cut a patch for that (I haven't had the time to do that yet)
and we'll see.

Thanks,
Rafael
