From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/2] ACPI / AC: recheck adapter status upon battery notifications
Date: Mon, 10 Mar 2014 01:17:33 +0100
Message-ID: <2980199.zRQvODLJKL@vostro.rjw.lan>
References: <1394404652-5873-1-git-send-email-mezin.alexander@gmail.com> <2407349.s5ssuQ6VFm@vostro.rjw.lan> <CADnvcfLsRqpQG8t813ytpV62ViU-i8n=SdhNi3u26C_CpPHx_Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59818 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752305AbaCJACQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 9 Mar 2014 20:02:16 -0400
In-Reply-To: <CADnvcfLsRqpQG8t813ytpV62ViU-i8n=SdhNi3u26C_CpPHx_Q@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexander Mezin <mezin.alexander@gmail.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Lan Tianyu <tianyu.lan@intel.com>

On Monday, March 10, 2014 06:21:50 AM Alexander Mezin wrote:
> 2014-03-10 6:11 GMT+07:00 Rafael J. Wysocki <rjw@rjwysocki.net>:
> > On Monday, March 10, 2014 05:37:32 AM Alexander Mezin wrote:
> >> On HP Pavilion dv6-6179er there are no notifications when AC adapter
> >> is plugged/unplugged.
> >> However, when AC status is read (acpi_ac_get_state), and if AC status
> >> has changed, AML code triggers the notification.
> >>
> >> This patch solves the problem by re-reading AC adapter status upon
> >> battery notifications.
> >>
> >> Signed-off-by: Alexander Mezin <mezin.alexander@gmail.com>
> >> ---
> >>  drivers/acpi/ac.c | 18 ++++++++++++++++++
> >>  1 file changed, 18 insertions(+)
> >>
> >> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
> >> index 6f190bc..1d3903e 100644
> >> --- a/drivers/acpi/ac.c
> >> +++ b/drivers/acpi/ac.c
> >> @@ -44,6 +44,8 @@
> >>  #define ACPI_AC_STATUS_ONLINE                0x01
> >>  #define ACPI_AC_STATUS_UNKNOWN               0xFF
> >>
> >> +#define ACPI_BATTERY_CLASS           "battery"
> >
> > Can you please put that definition into a header file and make all .c files
> > referring to ACPI_BATTERY_CLASS include that header?
> At least this definition is copied in sbs.c too.

Yes, it is.  Is that a good enough reason to add one more copy?

> And ACPI_AC_CLASS is used even in radeon_acpi.c. And ACPI_PROCESSOR_CLASS
> in a lot of places too.
> Maybe it makes sense to move all these class definitions (and maybe
> notification codes) into single (public?) header file? But as a
> separate patch series.

Well, it would be good to do that, but at least no one is trying to add more
copies of those.

> >
> >> +
> >>  #define _COMPONENT           ACPI_AC_COMPONENT
> >>  ACPI_MODULE_NAME("ac");
> >>
> >> @@ -57,6 +59,7 @@ struct acpi_ac {
> >>       struct power_supply charger;
> >>       struct platform_device *pdev;
> >>       unsigned long long state;
> >> +     struct notifier_block battery_nb;
> >>  };
> >>
> >>  #define to_acpi_ac(x) container_of(x, struct acpi_ac, charger)
> >> @@ -152,6 +155,18 @@ static void acpi_ac_notify_handler(acpi_handle handle, u32 event, void *data)
> >>       return;
> >>  }
> >>
> >> +static int acpi_ac_battery_notify(struct notifier_block *nb,
> >> +                               unsigned long action, void *data)
> >> +{
> >> +     struct acpi_ac *ac = container_of(nb, struct acpi_ac, battery_nb);
> >> +     struct acpi_bus_event *event = (struct acpi_bus_event *)data;
> >> +
> >> +     if (strcmp(event->device_class, ACPI_BATTERY_CLASS) == 0)
> >> +             acpi_ac_get_state(ac);
> >> +
> >> +     return NOTIFY_OK;
> >> +}
> >> +
> >>  static int thinkpad_e530_quirk(const struct dmi_system_id *d)
> >>  {
> >>       ac_sleep_before_get_state_ms = 1000;
> >> @@ -215,6 +230,8 @@ static int acpi_ac_probe(struct platform_device *pdev)
> >>              acpi_device_name(adev), acpi_device_bid(adev),
> >>              ac->state ? "on-line" : "off-line");
> >>
> >> +     ac->battery_nb.notifier_call = acpi_ac_battery_notify;
> >> +     register_acpi_notifier(&ac->battery_nb);
> >>  end:
> >>       if (result)
> >>               kfree(ac);
> >> @@ -261,6 +278,7 @@ static int acpi_ac_remove(struct platform_device *pdev)
> >>       ac = platform_get_drvdata(pdev);
> >>       if (ac->charger.dev)
> >>               power_supply_unregister(&ac->charger);
> >> +     unregister_acpi_notifier(&ac->battery_nb);
> >>
> >>       kfree(ac);
> >>
> >>

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
