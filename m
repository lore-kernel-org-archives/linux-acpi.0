From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] [-mm] ACPI: use GFP_KERNEL instead of GFP_ATOMIC
Date: Thu, 16 Aug 2007 12:06:18 +0800
Message-ID: <1187237178.5723.16.camel@rzhang-asus.sh.intel.com>
References: <1185922802.3993.4.camel@rzhang-asus.sh.intel.com>
	 <200708152336.39762.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1204 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754849AbXHPEEl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 16 Aug 2007 00:04:41 -0400
In-Reply-To: <200708152336.39762.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, rjw@sisk.pl

On Thu, 2007-08-16 at 11:36 +0800, Len Brown wrote:
> On Tuesday 31 July 2007 19:00, Zhang Rui wrote:
> > Use GFP_KERNEL instead of GFP_ATOMIC.
> >
> > GFP_ATOMIC is still needed by the sonypi and sony-laptop driver.
> 
> Why?
> Sony can't events from user-context like everybody else does?
Mattia has the plan to do this. But it won't be finished recently.

> I don't like adding this extra param to every caller.
> 
> I'm looking forward to acpi_bus_generate_event()
> being renamed acpi_bus_generate_proc_event()
> then it should be #ifdef'd with /proc/acpi/event for eventual removal,
> and the callers should invoke acpi_bus_generate_genetlink_event()
> directly.
acpi_bus_generate_genetlink_event still need to alloc memory with a
proper gfp_t flag.

Rafael said that "if any of these things can happen during a suspend,
GFP_NOFS would be safer (or even GFP_NOIO)."
I'm not sure which is the proper flag. In fact, we are still using
GFP_KERNEL if we want to evaluate some methods in the notify handler.

> The exception is the callers that are covered by the input layer
> already --
> such as button.c.  The can continue to call the legacy interface while
> it exists, but should not be generating a netlink event -- for they
> act like button keys and are covered by the input layer.
That makes sense. But IMO, that's a kind of fussy and need a lot of
#ifdef.As we know what kind of devices/events are sent via input layer,
how about create a blacklist for these devices/events and stop them from
sending genetlink events. Then all we need is to hack in the
acpi_bus_generate_bus(). 

thanks,
Rui
> thanks,
> -Len
> 
> > Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> > ---
> >  drivers/acpi/ac.c                 |    3 ++-
> >  drivers/acpi/asus_acpi.c          |    2 +-
> >  drivers/acpi/battery.c            |    3 ++-
> >  drivers/acpi/bus.c                |    7 ++++---
> >  drivers/acpi/button.c             |    2 +-
> >  drivers/acpi/event.c              |    6 +++---
> >  drivers/acpi/processor_core.c     |    7 ++++---
> >  drivers/acpi/sbs.c                |    2 +-
> >  drivers/acpi/thermal.c            |    8 ++++----
> >  drivers/acpi/video.c              |   10 +++++-----
> >  drivers/char/sonypi.c             |    3 ++-
> >  drivers/misc/asus-laptop.c        |    2 +-
> >  drivers/misc/sony-laptop.c        |    4 ++--
> >  drivers/misc/thinkpad_acpi.c      |   26 +++++++++++++++++---------
> >  drivers/pci/hotplug/acpiphp_ibm.c |    3 ++-
> >  include/acpi/acpi_bus.h           |    5 +++--
> >  16 files changed, 54 insertions(+), 39 deletions(-)
> >
> > Index: linux-2.6.23-rc1/drivers/acpi/bus.c
> > ===================================================================
> > --- linux-2.6.23-rc1.orig/drivers/acpi/bus.c
> > +++ linux-2.6.23-rc1/drivers/acpi/bus.c
> > @@ -284,7 +284,8 @@ DECLARE_WAIT_QUEUE_HEAD(acpi_bus_event_q
> > 
> >  extern int event_is_open;
> > 
> > -int acpi_bus_generate_event(struct acpi_device *device, u8 type,
> int data)
> > +int acpi_bus_generate_event(struct acpi_device *device, u8 type,
> > +                         int data, gfp_t flag)
> >  {
> >       struct acpi_bus_event *event = NULL;
> >       unsigned long flags = 0;
> > @@ -293,7 +294,7 @@ int acpi_bus_generate_event(struct acpi_
> >       if (!device)
> >               return -EINVAL;
> > 
> > -     if (acpi_bus_generate_genetlink_event(device, type, data))
> > +     if (acpi_bus_generate_genetlink_event(device, type, data,
> flag))
> >               printk(KERN_WARNING PREFIX
> >                       "Failed to generate an ACPI event via
> genetlink!\n");
> > 
> > @@ -301,7 +302,7 @@ int acpi_bus_generate_event(struct acpi_
> >       if (!event_is_open)
> >               return 0;
> > 
> > -     event = kmalloc(sizeof(struct acpi_bus_event), GFP_ATOMIC);
> > +     event = kmalloc(sizeof(struct acpi_bus_event), flag);
> >       if (!event)
> >               return -ENOMEM;
> > 
> > Index: linux-2.6.23-rc1/drivers/acpi/event.c
> > ===================================================================
> > --- linux-2.6.23-rc1.orig/drivers/acpi/event.c
> > +++ linux-2.6.23-rc1/drivers/acpi/event.c
> > @@ -148,7 +148,7 @@ static struct genl_multicast_group acpi_
> >  };
> > 
> >  int acpi_bus_generate_genetlink_event(struct acpi_device *device,
> > -                                   u8 type, int data)
> > +                                   u8 type, int data, gfp_t flag)
> >  {
> >       struct sk_buff *skb;
> >       struct nlattr *attr;
> > @@ -161,7 +161,7 @@ int acpi_bus_generate_genetlink_event(st
> >       size = nla_total_size(sizeof(struct acpi_genl_event)) +
> >           nla_total_size(0);
> > 
> > -     skb = genlmsg_new(size, GFP_ATOMIC);
> > +     skb = genlmsg_new(size, flag);
> >       if (!skb)
> >               return -ENOMEM;
> > 
> > @@ -204,7 +204,7 @@ int acpi_bus_generate_genetlink_event(st
> >       }
> > 
> >       result =
> > -         genlmsg_multicast(skb, 0, acpi_event_mcgrp.id,
> GFP_ATOMIC);
> > +         genlmsg_multicast(skb, 0, acpi_event_mcgrp.id, flag);
> >       if (result)
> >               ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> >                                 "Failed to send a Genetlink message!
> \n"));
> > Index: linux-2.6.23-rc1/include/acpi/acpi_bus.h
> > ===================================================================
> > --- linux-2.6.23-rc1.orig/include/acpi/acpi_bus.h
> > +++ linux-2.6.23-rc1/include/acpi/acpi_bus.h
> > @@ -322,7 +322,7 @@ struct acpi_bus_event {
> > 
> >  extern struct kset acpi_subsys;
> >  extern int acpi_bus_generate_genetlink_event(struct acpi_device
> *device,
> > -                                             u8 type, int data);
> > +                                             u8 type, int data,
> gfp_t flag);
> >  /*
> >   * External Functions
> >   */
> > @@ -332,7 +332,8 @@ void acpi_bus_data_handler(acpi_handle h
> >  int acpi_bus_get_status(struct acpi_device *device);
> >  int acpi_bus_get_power(acpi_handle handle, int *state);
> >  int acpi_bus_set_power(acpi_handle handle, int state);
> > -int acpi_bus_generate_event(struct acpi_device *device, u8 type,
> int data);
> > +int acpi_bus_generate_event(struct acpi_device *device, u8 type,
> int data,
> > +                             gfp_t flag);
> >  int acpi_bus_receive_event(struct acpi_bus_event *event);
> >  int acpi_bus_register_driver(struct acpi_driver *driver);
> >  void acpi_bus_unregister_driver(struct acpi_driver *driver);
> > Index: linux-2.6.23-rc1/drivers/acpi/ac.c
> > ===================================================================
> > --- linux-2.6.23-rc1.orig/drivers/acpi/ac.c
> > +++ linux-2.6.23-rc1/drivers/acpi/ac.c
> > @@ -199,7 +199,8 @@ static void acpi_ac_notify(acpi_handle h
> >       case ACPI_NOTIFY_BUS_CHECK:
> >       case ACPI_NOTIFY_DEVICE_CHECK:
> >               acpi_ac_get_state(ac);
> > -             acpi_bus_generate_event(device, event, (u32)
> ac->state);
> > +             acpi_bus_generate_event(device, event, (u32)
> ac->state,
> > +                                     GFP_KERNEL);
> >               break;
> >       default:
> >               ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> > Index: linux-2.6.23-rc1/drivers/acpi/asus_acpi.c
> > ===================================================================
> > --- linux-2.6.23-rc1.orig/drivers/acpi/asus_acpi.c
> > +++ linux-2.6.23-rc1/drivers/acpi/asus_acpi.c
> > @@ -1065,7 +1065,7 @@ static void asus_hotk_notify(acpi_handle
> >       }
> > 
> >       acpi_bus_generate_event(hotk->device, event,
> > -                             hotk->event_count[event % 128]++);
> > +                             hotk->event_count[event % 128]++,
> GFP_KERNEL);
> > 
> >       return;
> >  }
> > Index: linux-2.6.23-rc1/drivers/acpi/battery.c
> > ===================================================================
> > --- linux-2.6.23-rc1.orig/drivers/acpi/battery.c
> > +++ linux-2.6.23-rc1/drivers/acpi/battery.c
> > @@ -868,7 +868,8 @@ static void acpi_battery_notify(acpi_han
> >               device = battery->device;
> >               acpi_battery_notify_update(battery);
> >               acpi_bus_generate_event(device, event,
> > -
> acpi_battery_present(battery));
> > +                                     acpi_battery_present(battery),
> > +                                     GFP_KERNEL);
> >               break;
> >       default:
> >               ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> > Index: linux-2.6.23-rc1/drivers/acpi/button.c
> > ===================================================================
> > --- linux-2.6.23-rc1.orig/drivers/acpi/button.c
> > +++ linux-2.6.23-rc1/drivers/acpi/button.c
> > @@ -275,7 +275,7 @@ static void acpi_button_notify(acpi_hand
> >               input_sync(input);
> > 
> >               acpi_bus_generate_event(button->device, event,
> > -                                     ++button->pushed);
> > +                                     ++button->pushed, GFP_KERNEL);
> >               break;
> >       default:
> >               ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> > Index: linux-2.6.23-rc1/drivers/acpi/processor_core.c
> > ===================================================================
> > --- linux-2.6.23-rc1.orig/drivers/acpi/processor_core.c
> > +++ linux-2.6.23-rc1/drivers/acpi/processor_core.c
> > @@ -693,15 +693,16 @@ static void acpi_processor_notify(acpi_h
> >       case ACPI_PROCESSOR_NOTIFY_PERFORMANCE:
> >               acpi_processor_ppc_has_changed(pr);
> >               acpi_bus_generate_event(device, event,
> > -
> pr->performance_platform_limit);
> > +
> pr->performance_platform_limit,
> > +                                     GFP_KERNEL);
> >               break;
> >       case ACPI_PROCESSOR_NOTIFY_POWER:
> >               acpi_processor_cst_has_changed(pr);
> > -             acpi_bus_generate_event(device, event, 0);
> > +             acpi_bus_generate_event(device, event, 0, GFP_KERNEL);
> >               break;
> >       case ACPI_PROCESSOR_NOTIFY_THROTTLING:
> >               acpi_processor_tstate_has_changed(pr);
> > -             acpi_bus_generate_event(device, event, 0);
> > +             acpi_bus_generate_event(device, event, 0, GFP_KERNEL);
> >       default:
> >               ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> >                                 "Unsupported event [0x%x]\n",
> event));
> > Index: linux-2.6.23-rc1/drivers/acpi/sbs.c
> > ===================================================================
> > --- linux-2.6.23-rc1.orig/drivers/acpi/sbs.c
> > +++ linux-2.6.23-rc1/drivers/acpi/sbs.c
> > @@ -434,7 +434,7 @@ static int acpi_sbs_generate_event(struc
> >       strcpy(acpi_device_bid(device), bid);
> >       strcpy(acpi_device_class(device), class);
> > 
> > -     result = acpi_bus_generate_event(device, event, state);
> > +     result = acpi_bus_generate_event(device, event, state,
> GFP_KERNEL);
> > 
> >       strcpy(acpi_device_bid(device), bid_saved);
> >       strcpy(acpi_device_class(device), class_saved);
> > Index: linux-2.6.23-rc1/drivers/acpi/thermal.c
> > ===================================================================
> > --- linux-2.6.23-rc1.orig/drivers/acpi/thermal.c
> > +++ linux-2.6.23-rc1/drivers/acpi/thermal.c
> > @@ -434,7 +434,7 @@ static int acpi_thermal_critical(struct
> >              "Critical temperature reached (%ld C), shutting
> down.\n",
> >              KELVIN_TO_CELSIUS(tz->temperature));
> >       acpi_bus_generate_event(tz->device,
> ACPI_THERMAL_NOTIFY_CRITICAL,
> > -                             tz->trips.critical.flags.enabled);
> > +                             tz->trips.critical.flags.enabled,
> GFP_KERNEL);
> > 
> >       orderly_poweroff(true);
> > 
> > @@ -453,7 +453,7 @@ static int acpi_thermal_hot(struct acpi_
> >               tz->trips.hot.flags.enabled = 0;
> > 
> >       acpi_bus_generate_event(tz->device, ACPI_THERMAL_NOTIFY_HOT,
> > -                             tz->trips.hot.flags.enabled);
> > +                             tz->trips.hot.flags.enabled,
> GFP_KERNEL);
> > 
> >       /* TBD: Call user-mode "sleep(S4)" function */
> > 
> > @@ -1095,12 +1095,12 @@ static void acpi_thermal_notify(acpi_han
> >       case ACPI_THERMAL_NOTIFY_THRESHOLDS:
> >               acpi_thermal_get_trip_points(tz);
> >               acpi_thermal_check(tz);
> > -             acpi_bus_generate_event(device, event, 0);
> > +             acpi_bus_generate_event(device, event, 0, GFP_KERNEL);
> >               break;
> >       case ACPI_THERMAL_NOTIFY_DEVICES:
> >               if (tz->flags.devices)
> >                       acpi_thermal_get_devices(tz);
> > -             acpi_bus_generate_event(device, event, 0);
> > +             acpi_bus_generate_event(device, event, 0, GFP_KERNEL);
> >               break;
> >       default:
> >               ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> > Index: linux-2.6.23-rc1/drivers/acpi/video.c
> > ===================================================================
> > --- linux-2.6.23-rc1.orig/drivers/acpi/video.c
> > +++ linux-2.6.23-rc1/drivers/acpi/video.c
> > @@ -1769,7 +1769,7 @@ static void acpi_video_bus_notify(acpi_h
> >       switch (event) {
> >       case ACPI_VIDEO_NOTIFY_SWITCH:  /* User requested a switch,
> >                                        * most likely via hotkey. */
> > -             acpi_bus_generate_event(device, event, 0);
> > +             acpi_bus_generate_event(device, event, 0, GFP_KERNEL);
> >               break;
> > 
> >       case ACPI_VIDEO_NOTIFY_PROBE:   /* User plugged in or removed
> a video
> > @@ -1777,14 +1777,14 @@ static void acpi_video_bus_notify(acpi_h
> >               acpi_video_device_enumerate(video);
> >               acpi_video_device_rebind(video);
> >               acpi_video_switch_output(video, event);
> > -             acpi_bus_generate_event(device, event, 0);
> > +             acpi_bus_generate_event(device, event, 0, GFP_KERNEL);
> >               break;
> > 
> >       case ACPI_VIDEO_NOTIFY_CYCLE:   /* Cycle Display output hotkey
> pressed. */
> >       case ACPI_VIDEO_NOTIFY_NEXT_OUTPUT:     /* Next Display output
> hotkey pressed. */
> >       case ACPI_VIDEO_NOTIFY_PREV_OUTPUT:     /* previous Display
> output hotkey pressed. */
> >               acpi_video_switch_output(video, event);
> > -             acpi_bus_generate_event(device, event, 0);
> > +             acpi_bus_generate_event(device, event, 0, GFP_KERNEL);
> >               break;
> > 
> >       default:
> > @@ -1809,7 +1809,7 @@ static void acpi_video_device_notify(acp
> >       switch (event) {
> >       case ACPI_VIDEO_NOTIFY_SWITCH:  /* change in status (cycle
> output device) */
> >       case ACPI_VIDEO_NOTIFY_PROBE:   /* change in status (output
> device status) */
> > -             acpi_bus_generate_event(device, event, 0);
> > +             acpi_bus_generate_event(device, event, 0, GFP_KERNEL);
> >               break;
> >       case ACPI_VIDEO_NOTIFY_CYCLE_BRIGHTNESS:        /* Cycle
> brightness */
> >       case ACPI_VIDEO_NOTIFY_INC_BRIGHTNESS:  /* Increase brightness
> */
> > @@ -1817,7 +1817,7 @@ static void acpi_video_device_notify(acp
> >       case ACPI_VIDEO_NOTIFY_ZERO_BRIGHTNESS: /* zero brightnesss */
> >       case ACPI_VIDEO_NOTIFY_DISPLAY_OFF:     /* display device off
> */
> >               acpi_video_switch_brightness(video_device, event);
> > -             acpi_bus_generate_event(device, event, 0);
> > +             acpi_bus_generate_event(device, event, 0, GFP_KERNEL);
> >               break;
> >       default:
> >               ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> > Index: linux-2.6.23-rc1/drivers/char/sonypi.c
> > ===================================================================
> > --- linux-2.6.23-rc1.orig/drivers/char/sonypi.c
> > +++ linux-2.6.23-rc1/drivers/char/sonypi.c
> > @@ -875,7 +875,8 @@ found:
> > 
> >  #ifdef CONFIG_ACPI
> >       if (sonypi_acpi_device)
> > -             acpi_bus_generate_event(sonypi_acpi_device, 1, event);
> > +             acpi_bus_generate_event(sonypi_acpi_device, 1,
> > +                                     event, GFP_ATOMIC);
> >  #endif
> > 
> >       kfifo_put(sonypi_device.fifo, (unsigned char *)&event,
> sizeof(event));
> > Index: linux-2.6.23-rc1/drivers/misc/sony-laptop.c
> > ===================================================================
> > --- linux-2.6.23-rc1.orig/drivers/misc/sony-laptop.c
> > +++ linux-2.6.23-rc1/drivers/misc/sony-laptop.c
> > @@ -904,7 +904,7 @@ static void sony_acpi_notify(acpi_handle
> > 
> >       dprintk("sony_acpi_notify, event: 0x%.2x\n", ev);
> >       sony_laptop_report_input_event(ev);
> > -     acpi_bus_generate_event(sony_nc_acpi_device, 1, ev);
> > +     acpi_bus_generate_event(sony_nc_acpi_device, 1, ev,
> GFP_KERNEL);
> >  }
> > 
> >  static acpi_status sony_walk_callback(acpi_handle handle, u32
> level,
> > @@ -2275,7 +2275,7 @@ static irqreturn_t sony_pic_irq(int irq,
> > 
> >  found:
> >       sony_laptop_report_input_event(device_event);
> > -     acpi_bus_generate_event(spic_dev.acpi_dev, 1, device_event);
> > +     acpi_bus_generate_event(spic_dev.acpi_dev, 1, device_event,
> GFP_ATOMIC);
> >       sonypi_compat_report_event(device_event);
> > 
> >       return IRQ_HANDLED;
> > Index: linux-2.6.23-rc1/drivers/misc/thinkpad_acpi.c
> > ===================================================================
> > --- linux-2.6.23-rc1.orig/drivers/misc/thinkpad_acpi.c
> > +++ linux-2.6.23-rc1/drivers/misc/thinkpad_acpi.c
> > @@ -1189,10 +1189,12 @@ static void hotkey_notify(struct ibm_str
> >               }
> > 
> >               if (sendacpi)
> > -                     acpi_bus_generate_event(ibm->acpi->device,
> event, hkey);
> > +                     acpi_bus_generate_event(ibm->acpi->device,
> event, hkey,
> > +                                             GFP_KERNEL);
> >       } else {
> >               printk(IBM_ERR "unknown hotkey notification event %d
> \n", event);
> > -             acpi_bus_generate_event(ibm->acpi->device, event, 0);
> > +             acpi_bus_generate_event(ibm->acpi->device, event, 0,
> > +                                     GFP_KERNEL);
> >       }
> >  }
> > 
> > @@ -2152,19 +2154,25 @@ static void dock_notify(struct ibm_struc
> >       int pci = ibm->acpi->hid && strstr(ibm->acpi->hid,
> PCI_ROOT_HID_STRING);
> > 
> >       if (event == 1 && !pci) /* 570 */
> > -             acpi_bus_generate_event(ibm->acpi->device, event,
> 1);   /* button */
> > +             acpi_bus_generate_event(ibm->acpi->device, event,
> > +                                     1, GFP_KERNEL); /* button */
> >       else if (event == 1 && pci)     /* 570 */
> > -             acpi_bus_generate_event(ibm->acpi->device, event,
> 3);   /* dock */
> > +             acpi_bus_generate_event(ibm->acpi->device, event,
> > +                                     3, GFP_KERNEL); /* dock */
> >       else if (event == 3 && docked)
> > -             acpi_bus_generate_event(ibm->acpi->device, event,
> 1);   /* button */
> > +             acpi_bus_generate_event(ibm->acpi->device, event,
> > +                                     1, GFP_KERNEL); /* button */
> >       else if (event == 3 && !docked)
> > -             acpi_bus_generate_event(ibm->acpi->device, event,
> 2);   /* undock */
> > +             acpi_bus_generate_event(ibm->acpi->device, event,
> > +                                     2, GFP_KERNEL); /* undock */
> >       else if (event == 0 && docked)
> > -             acpi_bus_generate_event(ibm->acpi->device, event,
> 3);   /* dock */
> > +             acpi_bus_generate_event(ibm->acpi->device, event,
> > +                                     3, GFP_KERNEL); /* dock */
> >       else {
> >               printk(IBM_ERR "unknown dock event %d, status %d\n",
> >                      event, _sta(dock_handle));
> > -             acpi_bus_generate_event(ibm->acpi->device, event,
> 0);   /* unknown */
> > +             acpi_bus_generate_event(ibm->acpi->device, event,
> > +                                     0, GFP_KERNEL); /* unknown */
> >       }
> >  }
> > 
> > @@ -2263,7 +2271,7 @@ static int __init bay_init(struct ibm_in
> > 
> >  static void bay_notify(struct ibm_struct *ibm, u32 event)
> >  {
> > -     acpi_bus_generate_event(ibm->acpi->device, event, 0);
> > +     acpi_bus_generate_event(ibm->acpi->device, event, 0,
> GFP_KERNEL);
> >  }
> > 
> >  #define bay_occupied(b) (_sta(b##_handle) & 1)
> > Index: linux-2.6.23-rc1/drivers/pci/hotplug/acpiphp_ibm.c
> > ===================================================================
> > --- linux-2.6.23-rc1.orig/drivers/pci/hotplug/acpiphp_ibm.c
> > +++ linux-2.6.23-rc1/drivers/pci/hotplug/acpiphp_ibm.c
> > @@ -267,7 +267,8 @@ static void ibm_handle_events(acpi_handl
> > 
> >       if (subevent == 0x80) {
> >               dbg("%s: generationg bus event\n", __FUNCTION__);
> > -             acpi_bus_generate_event(note->device, note->event,
> detail);
> > +             acpi_bus_generate_event(note->device, note->event,
> > +                                     detail, GFP_KERNEL);
> >       } else
> >               note->event = event;
> >  }
> > Index: linux-2.6.23-rc1/drivers/misc/asus-laptop.c
> > ===================================================================
> > --- linux-2.6.23-rc1.orig/drivers/misc/asus-laptop.c
> > +++ linux-2.6.23-rc1/drivers/misc/asus-laptop.c
> > @@ -728,7 +728,7 @@ static void asus_hotk_notify(acpi_handle
> >       }
> > 
> >       acpi_bus_generate_event(hotk->device, event,
> > -                             hotk->event_count[event % 128]++);
> > +                             hotk->event_count[event % 128]++,
> GFP_KERNEL);
> > 
> >       return;
> >  }
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> linux-acpi" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >
> 
> 
