From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi/sleep: Use the FADT to prefer Suspend-to-Idle instead of S3
Date: Thu, 17 Nov 2016 16:25:50 +0100
Message-ID: <1870300.pUnYT5AraT@vostro.rjw.lan>
References: <1478813718-12521-1-git-send-email-mario.limonciello@dell.com> <CAJZ5v0hLf+N7YakJrzfrWAgKF=Ywyx2v70hGes0+52brWMYnSA@mail.gmail.com> <7dafc2f8e66f4aeb9c242640af2e4988@ausx13mpc120.AMER.DELL.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:44592 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754426AbcKQREx (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 17 Nov 2016 12:04:53 -0500
In-Reply-To: <7dafc2f8e66f4aeb9c242640af2e4988@ausx13mpc120.AMER.DELL.COM>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mario.Limonciello@dell.com
Cc: rafael@kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org, luto@kernel.org

On Wednesday, November 16, 2016 08:18:13 PM Mario.Limonciello@dell.com wrote:
> > -----Original Message-----
> > From: rjwysocki@gmail.com [mailto:rjwysocki@gmail.com] On Behalf Of
> > Rafael J. Wysocki
> > Sent: Thursday, November 10, 2016 5:54 PM
> > To: Limonciello, Mario <Mario_Limonciello@Dell.com>
> > Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>; Len Brown
> > <lenb@kernel.org>; Rafael J . Wysocki <rjw@rjwysocki.net>; Andy
> > Lutomirski <luto@kernel.org>
> > Subject: Re: [PATCH] acpi/sleep: Use the FADT to prefer Suspend-to-Idle
> > instead of S3
> > 
> > On Thu, Nov 10, 2016 at 10:35 PM, Mario Limonciello
> > <mario.limonciello@dell.com> wrote:
> > > If the ACPI_FADT_LOW_POWER_S0 bit is set, this indicates the platform
> > > should get identical or better performance using Suspend-To-Idle.
> > >
> > > By removing S3 and S1 userspace will prefer suspend-to-idle in
> > > these situations too.
> > >
> > > Signed-off-by: Mario Limonciello <mario.limonciello@dell.com>
> > > ---
> > >  drivers/acpi/sleep.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > >
> > > diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> > > index deb0ff7..ff1d8f1 100644
> > > --- a/drivers/acpi/sleep.c
> > > +++ b/drivers/acpi/sleep.c
> > > @@ -171,6 +171,12 @@ static int __init init_nvs_nosave(const struct
> > dmi_system_id *d)
> > >         return 0;
> > >  }
> > >
> > > +static bool suspend_to_idle_preferred(void)
> > > +{
> > > +       return (acpi_gbl_FADT.flags & ACPI_FADT_LOW_POWER_S0);
> > > +}
> > > +
> > > +
> > >  static struct dmi_system_id acpisleep_dmi_table[] __initdata = {
> > >         {
> > >         .callback = init_old_suspend_ordering,
> > > @@ -908,6 +914,11 @@ int __init acpi_sleep_init(void)
> > >                 acpi_no_s5 = true;
> > >         }
> > >
> > > +       if (suspend_to_idle_preferred()) {
> > > +               sleep_states[ACPI_STATE_S3] = 0;
> > > +               sleep_states[ACPI_STATE_S1] = 0;
> > > +       }
> > > +
> > >         supported[0] = 0;
> > >         for (i = 0; i < ACPI_S_STATE_COUNT; i++) {
> > >                 if (sleep_states[i])
> > > --
> > 
> > I'd do that in a different way.
> > 
> > Let me cut a patch for that (I haven't had the time to do that yet)
> > and we'll see.
> > 
> > Thanks,
> > Rafael
> 
> OK, look forward to seeing the approach you want to go with this
> instead.

Please have a look at

https://patchwork.kernel.org/patch/9433421/
https://patchwork.kernel.org/patch/9433429/

Thanks,
Rafael

