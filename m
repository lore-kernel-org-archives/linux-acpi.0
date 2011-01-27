From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI / ACPICA: Collect event statistics in respective event structures
Date: Thu, 27 Jan 2011 17:51:36 +0100
Message-ID: <201101271751.36513.rjw@sisk.pl>
References: <201101270058.05541.rjw@sisk.pl> <4911F71203A09E4D9981D27F9D830858C016A9C9@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:45313 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752104Ab1A0QwD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Jan 2011 11:52:03 -0500
In-Reply-To: <4911F71203A09E4D9981D27F9D830858C016A9C9@orsmsx503.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>

On Thursday, January 27, 2011, Moore, Robert wrote:
> Rafael,

Hi,

> Yes, as we discussed, ACPICA will be implementing the global counters.
> 
> We have a prototype here; we will look at your prototype and hopefully integrate the best of both.

Great, thanks!

> Lin Ming went off and got married and is now on honeymoon

Wow, great!

> -- so I'm handling the emergency stuff and other things. I am trying to get
> to this soon, as well as the global lock changes.

There's no hurry on my side.  I'm going to post a patch fixing the "root
object with _PRW" issue I've told you about recently, but apart from this I
don't know of any urgent issues related to ACPICA.

Thanks,
Rafael


> >-----Original Message-----
> >From: Rafael J. Wysocki [mailto:rjw@sisk.pl]
> >Sent: Wednesday, January 26, 2011 3:58 PM
> >To: ACPI Devel Maling List
> >Cc: Len Brown; Moore, Robert; Lin, Ming M
> >Subject: [PATCH] ACPI / ACPICA: Collect event statistics in respective
> >event structures
> >
> >From: Rafael J. Wysocki <rjw@sisk.pl>
> >
> >Fixed event and GPE statistics are collected with the help of the
> >newly introduced global events handler, which is suboptimal, because
> >the statistics should rather be collected by ACPICA and stored in
> >the objects that represent those GPEs and fixed events.  That will
> >allow every host OS using ACPICA to access the statistics without
> >major modifications.  Moreover, the interfaces used by host OSes to
> >get event status information can be extended in a straightforward way
> >to also return the event statistics provided that those statistics
> >are collected at the ACPICA level.
> >
> >Extend struct acpi_gpe_event_info and struct acpi_fixed_event_info
> >so that event statistics can be stored in these structures.  Modify
> >acpi_ev_gpe_dispatch() and acpi_ev_fixed_event_dispatch() so that
> >they increment GPE and fixed event counters, respectively.  Add
> >functions allowing the host OS to modify the GPE and event counters
> >and functions.  Add total GPE event counter and functions for
> >manipulating it.
> >
> >Modify acpi_get_event_status() and acpi_get_gpe_status() to return
> >current values of the appropriate event counters, if necessary, in
> >addition to the "usual" event status information.
> >
> >Rework the kernel's code reporting GPE and fixed event statistics
> >through sysfs to take the above changes into account.
> >
> >Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> >---
> >
> >Hi,
> >
> >I posted a previous version of this patch before the 2.6.38 merge window,
> >but it didn't get much attention except for comments from Lin Ming.
> >
> >I'm still thinking that we shouldn't use the global event handler
> >introduced
> >during the .38 merge window for collecting event statistics.  I'm fine with
> >using it for other purposes (although quite frankly I don't see what other
> >purposes in particular it may be useful for at the moment), but in my
> >opinion
> >the GPE and fixed events statistics should be collected by ACPICA and
> >exported
> >to the host OSes through a uniform and clean interface.
> >
> >The $subject patch attempts to add the collecting of event and GPE
> >statistics
> >to ACPICA and reworks the Linux kernel code depending on the global handler
> >to
> >use the new interface.
> >
> >This particular version of the patch hasn't been really tested yet,
> >although I
> >made sure that the code would compile.  Still, the modifications since the
> >previous version were pretty minor and mostly related to removing the newly
> >introduced hooks for the global handler, so I expect the patch to work.
> >
> >Please review and let me know what you think.
> >
> >Thanks,
> >Rafael
> >
> >---
> > drivers/acpi/acpica/acglobal.h |    3 -
> > drivers/acpi/acpica/aclocal.h  |    7 ++
> > drivers/acpi/acpica/evevent.c  |    3 -
> > drivers/acpi/acpica/evgpe.c    |   38 ++++++++++++
> > drivers/acpi/acpica/evxfevnt.c |   33 ++++++++++-
> > drivers/acpi/acpica/evxfgpe.c  |   44 ++++++++++++++-
> > drivers/acpi/scan.c            |    2
> > drivers/acpi/sysfs.c           |  120 +++++++++++++-----------------------
> >-----
> > include/acpi/acpiosxf.h        |    3 -
> > include/acpi/acpixf.h          |   14 ++++
> > 10 files changed, 174 insertions(+), 93 deletions(-)
> >
> >Index: linux-2.6/drivers/acpi/acpica/aclocal.h
> >===================================================================
> >--- linux-2.6.orig/drivers/acpi/acpica/aclocal.h
> >+++ linux-2.6/drivers/acpi/acpica/aclocal.h
> >@@ -406,6 +406,11 @@ struct acpi_predefined_data {
> >  *
> >
> >***************************************************************************
> >*/
> >
> >+/* Event statistics. */
> >+struct acpi_event_stats {
> >+      u32 count;
> >+};
> >+
> > /* Dispatch info for each GPE -- either a method or handler, cannot be
> >both */
> >
> > struct acpi_gpe_handler_info {
> >@@ -432,6 +437,7 @@ struct acpi_gpe_event_info {
> >       u8 flags;               /* Misc info about this GPE */
> >       u8 gpe_number;          /* This GPE */
> >       u8 runtime_count;       /* References to a run GPE */
> >+      struct acpi_event_stats stats;  /* GPE event statistics */
> > };
> >
> > /* Information about a GPE register pair, one per each status/enable pair
> >in an array */
> >@@ -501,6 +507,7 @@ struct acpi_fixed_event_info {
> >       u8 enable_register_id;
> >       u16 status_bit_mask;
> >       u16 enable_bit_mask;
> >+      struct acpi_event_stats stats;  /* Fixed event statistics */
> > };
> >
> > /* Information used during field processing */
> >Index: linux-2.6/drivers/acpi/acpica/evgpe.c
> >===================================================================
> >--- linux-2.6.orig/drivers/acpi/acpica/evgpe.c
> >+++ linux-2.6/drivers/acpi/acpica/evgpe.c
> >@@ -640,6 +640,7 @@ acpi_status acpi_ev_finish_gpe(struct ac
> >  *              This function executes at interrupt level.
> >  *
> >
> >***************************************************************************
> >***/
> >+static struct acpi_event_stats acpi_ev_gpe_stats;
> >
> > u32
> > acpi_ev_gpe_dispatch(struct acpi_namespace_node *gpe_device,
> >@@ -650,9 +651,11 @@ acpi_ev_gpe_dispatch(struct acpi_namespa
> >
> >       ACPI_FUNCTION_TRACE(ev_gpe_dispatch);
> >
> >+      gpe_event_info->stats.count++;
> >+      acpi_ev_gpe_stats.count++;
> >+
> >       /* Invoke global event handler if present */
> >
> >-      acpi_gpe_count++;
> >       if (acpi_gbl_global_event_handler) {
> >               acpi_gbl_global_event_handler(ACPI_EVENT_TYPE_GPE, gpe_device,
> >                                             gpe_number,
> >@@ -748,3 +751,36 @@ acpi_ev_gpe_dispatch(struct acpi_namespa
> >
> >       return_UINT32(ACPI_INTERRUPT_HANDLED);
> > }
> >+
> >+
> >+/*************************************************************************
> >******
> >+ *
> >+ * FUNCTION:    acpi_total_gpe_stats_count
> >+ *
> >+ * PARAMETERS:  None
> >+ *
> >+ * RETURN:      Current value of the total GPE events counter.
> >+ *
> >+ * DESCRIPTION: Return the counted number of GPE events.
> >+ *
> >+
> >***************************************************************************
> >***/
> >+u32 acpi_total_gpe_stats_count(void)
> >+{
> >+      return acpi_ev_gpe_stats.count;
> >+}
> >+
> >+/*************************************************************************
> >******
> >+ *
> >+ * FUNCTION:    acpi_total_gpe_stats_count
> >+ *
> >+ * PARAMETERS:  gpe_device      - New value of the total GPE events
> >counter.
> >+ *
> >+ * RETURN:      None
> >+ *
> >+ * DESCRIPTION: Set the total GPE events counter to the given value.
> >+ *
> >+
> >***************************************************************************
> >***/
> >+void acpi_set_total_gpe_stats_count(u32 count)
> >+{
> >+      acpi_ev_gpe_stats.count = count;
> >+}
> >Index: linux-2.6/include/acpi/acpixf.h
> >===================================================================
> >--- linux-2.6.orig/include/acpi/acpixf.h
> >+++ linux-2.6/include/acpi/acpixf.h
> >@@ -287,7 +287,10 @@ acpi_status acpi_disable_event(u32 event
> >
> > acpi_status acpi_clear_event(u32 event);
> >
> >-acpi_status acpi_get_event_status(u32 event, acpi_event_status *
> >event_status);
> >+acpi_status acpi_get_event_status(u32 event,
> >+                                acpi_event_status *event_status, u32 *count);
> >+
> >+acpi_status acpi_set_event_stats_count(u32 event, u32 count);
> >
> > /*
> >  * GPE Interfaces
> >@@ -306,7 +309,10 @@ acpi_status acpi_set_gpe_wake_mask(acpi_
> >
> > acpi_status
> > acpi_get_gpe_status(acpi_handle gpe_device,
> >-                  u32 gpe_number, acpi_event_status *event_status);
> >+                  u32 gpe_number, acpi_event_status *event_status, u32
> >*count);
> >+
> >+acpi_status acpi_set_gpe_stats_count(acpi_handle gpe_device, u32
> >gpe_number,
> >+                                   u32 count);
> >
> > acpi_status acpi_disable_all_gpes(void);
> >
> >@@ -323,6 +329,10 @@ acpi_status acpi_remove_gpe_block(acpi_h
> >
> > acpi_status acpi_update_all_gpes(void);
> >
> >+u32 acpi_total_gpe_stats_count(void);
> >+
> >+void acpi_set_total_gpe_stats_count(u32 count);
> >+
> > /*
> >  * Resource interfaces
> >  */
> >Index: linux-2.6/drivers/acpi/sysfs.c
> >===================================================================
> >--- linux-2.6.orig/drivers/acpi/sysfs.c
> >+++ linux-2.6/drivers/acpi/sysfs.c
> >@@ -406,11 +406,9 @@ struct event_counter {
> >       u32 flags;
> > };
> >
> >-static struct event_counter *all_counters;
> > static u32 num_gpes;
> > static u32 num_counters;
> > static struct attribute **all_attrs;
> >-static u32 acpi_gpe_count;
> >
> > static struct attribute_group interrupt_stats_attr_group = {
> >       .name = "interrupts",
> >@@ -420,11 +418,6 @@ static struct kobj_attribute *counter_at
> >
> > static void delete_gpe_attr_array(void)
> > {
> >-      struct event_counter *tmp = all_counters;
> >-
> >-      all_counters = NULL;
> >-      kfree(tmp);
> >-
> >       if (counter_attrs) {
> >               int i;
> >
> >@@ -438,47 +431,7 @@ static void delete_gpe_attr_array(void)
> >       return;
> > }
> >
> >-static void gpe_count(u32 gpe_number)
> >-{
> >-      acpi_gpe_count++;
> >-
> >-      if (!all_counters)
> >-              return;
> >-
> >-      if (gpe_number < num_gpes)
> >-              all_counters[gpe_number].count++;
> >-      else
> >-              all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS +
> >-                           COUNT_ERROR].count++;
> >-
> >-      return;
> >-}
> >-
> >-static void fixed_event_count(u32 event_number)
> >-{
> >-      if (!all_counters)
> >-              return;
> >-
> >-      if (event_number < ACPI_NUM_FIXED_EVENTS)
> >-              all_counters[num_gpes + event_number].count++;
> >-      else
> >-              all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS +
> >-                           COUNT_ERROR].count++;
> >-
> >-      return;
> >-}
> >-
> >-static void acpi_gbl_event_handler(u32 event_type, acpi_handle device,
> >-      u32 event_number, void *context)
> >-{
> >-      if (event_type == ACPI_EVENT_TYPE_GPE)
> >-              gpe_count(event_number);
> >-
> >-      if (event_type == ACPI_EVENT_TYPE_FIXED)
> >-              fixed_event_count(event_number);
> >-}
> >-
> >-static int get_status(u32 index, acpi_event_status *status,
> >+static int get_status(u32 index, acpi_event_status *status, u32 *count,
> >                     acpi_handle *handle)
> > {
> >       int result = 0;
> >@@ -493,9 +446,9 @@ static int get_status(u32 index, acpi_ev
> >                                       "Invalid GPE 0x%x\n", index));
> >                       goto end;
> >               }
> >-              result = acpi_get_gpe_status(*handle, index, status);
> >+              result = acpi_get_gpe_status(*handle, index, status, count);
> >       } else if (index < (num_gpes + ACPI_NUM_FIXED_EVENTS))
> >-              result = acpi_get_event_status(index - num_gpes, status);
> >+              result = acpi_get_event_status(index - num_gpes, status,
> >count);
> >
> > end:
> >       return result;
> >@@ -505,27 +458,38 @@ static ssize_t counter_show(struct kobje
> >                           struct kobj_attribute *attr, char *buf)
> > {
> >       int index = attr - counter_attrs;
> >-      int size;
> >+      int size = 0;
> >       acpi_handle handle;
> >       acpi_event_status status;
> >+      u32 count;
> >       int result = 0;
> >
> >-      all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_SCI].count =
> >-          acpi_irq_handled;
> >-      all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_SCI_NOT].count
> >=
> >-          acpi_irq_not_handled;
> >-      all_counters[num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_GPE].count =
> >-          acpi_gpe_count;
> >-      size = sprintf(buf, "%8d", all_counters[index].count);
> >-
> >       /* "gpe_all" or "sci" */
> >-      if (index >= num_gpes + ACPI_NUM_FIXED_EVENTS)
> >+      if (index >= num_gpes + ACPI_NUM_FIXED_EVENTS) {
> >+              index -= num_gpes + ACPI_NUM_FIXED_EVENTS;
> >+              switch (index) {
> >+              case COUNT_GPE:
> >+                      count = acpi_total_gpe_stats_count();
> >+                      break;
> >+              case COUNT_SCI:
> >+                      count = acpi_irq_handled;
> >+                      break;
> >+              case COUNT_SCI_NOT:
> >+                      count = acpi_irq_not_handled;
> >+                      break;
> >+              default:
> >+                      goto end;
> >+              }
> >+              size = sprintf(buf, "%8d", count);
> >               goto end;
> >+      }
> >
> >-      result = get_status(index, &status, &handle);
> >+      result = get_status(index, &status, &count, &handle);
> >       if (result)
> >               goto end;
> >
> >+      size = sprintf(buf, "%8d", count);
> >+
> >       if (!(status & ACPI_EVENT_FLAG_HANDLE))
> >               size += sprintf(buf + size, "   invalid");
> >       else if (status & ACPI_EVENT_FLAG_ENABLED)
> >@@ -551,21 +515,26 @@ static ssize_t counter_set(struct kobjec
> > {
> >       int index = attr - counter_attrs;
> >       acpi_event_status status;
> >+      u32 count;
> >       acpi_handle handle;
> >       int result = 0;
> >
> >       if (index == num_gpes + ACPI_NUM_FIXED_EVENTS + COUNT_SCI) {
> >               int i;
> >-              for (i = 0; i < num_counters; ++i)
> >-                      all_counters[i].count = 0;
> >-              acpi_gpe_count = 0;
> >+              for (i = 0; i < num_gpes; ++i) {
> >+                      if (!acpi_get_gpe_device(index, &handle))
> >+                              acpi_set_gpe_stats_count(handle, index, 0);
> >+              }
> >+              for (i = num_gpes; i < num_gpes + ACPI_NUM_FIXED_EVENTS; ++i)
> >+                      acpi_set_event_stats_count(index, 0);
> >+              acpi_set_total_gpe_stats_count(0);
> >               acpi_irq_handled = 0;
> >               acpi_irq_not_handled = 0;
> >               goto end;
> >       }
> >
> >       /* show the event status for both GPEs and Fixed Events */
> >-      result = get_status(index, &status, &handle);
> >+      result = get_status(index, &status, &count, &handle);
> >       if (result)
> >               goto end;
> >
> >@@ -586,7 +555,8 @@ static ssize_t counter_set(struct kobjec
> >                        (status & ACPI_EVENT_FLAG_SET))
> >                       result = acpi_clear_gpe(handle, index);
> >               else
> >-                      all_counters[index].count = strtoul(buf, NULL, 0);
> >+                      acpi_set_gpe_stats_count(handle, index,
> >+                                               strtoul(buf, NULL, 0));
> >       } else if (index < num_gpes + ACPI_NUM_FIXED_EVENTS) {
> >               int event = index - num_gpes;
> >               if (!strcmp(buf, "disable\n") &&
> >@@ -599,9 +569,9 @@ static ssize_t counter_set(struct kobjec
> >                        (status & ACPI_EVENT_FLAG_SET))
> >                       result = acpi_clear_event(event);
> >               else
> >-                      all_counters[index].count = strtoul(buf, NULL, 0);
> >-      } else
> >-              all_counters[index].count = strtoul(buf, NULL, 0);
> >+                      acpi_set_event_stats_count(index,
> >+                                                 strtoul(buf, NULL, 0));
> >+      }
> >
> >       if (ACPI_FAILURE(result))
> >               result = -EINVAL;
> >@@ -611,10 +581,9 @@ end:
> >
> > void acpi_irq_stats_init(void)
> > {
> >-      acpi_status status;
> >       int i;
> >
> >-      if (all_counters)
> >+      if (all_attrs)
> >               return;
> >
> >       num_gpes = acpi_current_gpe_count;
> >@@ -625,15 +594,6 @@ void acpi_irq_stats_init(void)
> >       if (all_attrs == NULL)
> >               return;
> >
> >-      all_counters = kzalloc(sizeof(struct event_counter) * (num_counters),
> >-                             GFP_KERNEL);
> >-      if (all_counters == NULL)
> >-              goto fail;
> >-
> >-      status = acpi_install_global_event_handler(acpi_gbl_event_handler,
> >NULL);
> >-      if (ACPI_FAILURE(status))
> >-              goto fail;
> >-
> >       counter_attrs = kzalloc(sizeof(struct kobj_attribute) *
> >(num_counters),
> >                               GFP_KERNEL);
> >       if (counter_attrs == NULL)
> >Index: linux-2.6/drivers/acpi/acpica/evxfevnt.c
> >===================================================================
> >--- linux-2.6.orig/drivers/acpi/acpica/evxfevnt.c
> >+++ linux-2.6/drivers/acpi/acpica/evxfevnt.c
> >@@ -302,13 +302,15 @@ ACPI_EXPORT_SYMBOL(acpi_clear_event)
> >  * PARAMETERS:  Event           - The fixed event
> >  *              event_status    - Where the current status of the event
> >will
> >  *                                be returned
> >+ *              count           - Where to store the current event counter
> >value
> >  *
> >  * RETURN:      Status
> >  *
> >  * DESCRIPTION: Obtains and returns the current status of the event
> >  *
> >
> >***************************************************************************
> >***/
> >-acpi_status acpi_get_event_status(u32 event, acpi_event_status *
> >event_status)
> >+acpi_status acpi_get_event_status(u32 event,
> >+                                acpi_event_status *event_status, u32 *count)
> > {
> >       acpi_status status = AE_OK;
> >       u32 value;
> >@@ -347,7 +349,36 @@ acpi_status acpi_get_event_status(u32 ev
> >       if (acpi_gbl_fixed_event_handlers[event].handler)
> >               *event_status |= ACPI_EVENT_FLAG_HANDLE;
> >
> >+      if (count)
> >+              *count = acpi_gbl_fixed_event_info[event].stats.count;
> >+
> >       return_ACPI_STATUS(status);
> > }
> >
> > ACPI_EXPORT_SYMBOL(acpi_get_event_status)
> >+
> >+/*************************************************************************
> >******
> >+ *
> >+ * FUNCTION:    acpi_set_event_stats_count
> >+ *
> >+ * PARAMETERS:  Event           - The fixed event
> >+ *              count           - New value of the event counter
> >+ *
> >+ * RETURN:      Status
> >+ *
> >+ * DESCRIPTION: Set the event counter of the given fixed event to a new
> >value.
> >+ *
> >+
> >***************************************************************************
> >***/
> >+acpi_status acpi_set_event_stats_count(u32 event, u32 count)
> >+{
> >+      ACPI_FUNCTION_TRACE(acpi_set_event_stats_count);
> >+
> >+      if (event > ACPI_EVENT_MAX) {
> >+              return_ACPI_STATUS(AE_BAD_PARAMETER);
> >+      }
> >+
> >+      acpi_gbl_fixed_event_info[event].stats.count = count;
> >+
> >+      return_ACPI_STATUS(AE_OK);
> >+}
> >+ACPI_EXPORT_SYMBOL(acpi_set_event_stats_count)
> >Index: linux-2.6/drivers/acpi/acpica/evxfgpe.c
> >===================================================================
> >--- linux-2.6.orig/drivers/acpi/acpica/evxfgpe.c
> >+++ linux-2.6/drivers/acpi/acpica/evxfgpe.c
> >@@ -375,6 +375,7 @@ ACPI_EXPORT_SYMBOL(acpi_clear_gpe)
> >  *              gpe_number      - GPE level within the GPE block
> >  *              event_status    - Where the current status of the event
> >will
> >  *                                be returned
> >+ *              count           - Where to store the current event counter
> >value
> >  *
> >  * RETURN:      Status
> >  *
> >@@ -383,7 +384,7 @@ ACPI_EXPORT_SYMBOL(acpi_clear_gpe)
> >
> >***************************************************************************
> >***/
> > acpi_status
> > acpi_get_gpe_status(acpi_handle gpe_device,
> >-                  u32 gpe_number, acpi_event_status *event_status)
> >+                  u32 gpe_number, acpi_event_status *event_status, u32
> >*count)
> > {
> >       acpi_status status = AE_OK;
> >       struct acpi_gpe_event_info *gpe_event_info;
> >@@ -408,6 +409,9 @@ acpi_get_gpe_status(acpi_handle gpe_devi
> >       if (gpe_event_info->flags & ACPI_GPE_DISPATCH_MASK)
> >               *event_status |= ACPI_EVENT_FLAG_HANDLE;
> >
> >+      if (count)
> >+              *count = gpe_event_info->stats.count;
> >+
> >       unlock_and_exit:
> >       acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
> >       return_ACPI_STATUS(status);
> >@@ -415,6 +419,44 @@ acpi_get_gpe_status(acpi_handle gpe_devi
> >
> > ACPI_EXPORT_SYMBOL(acpi_get_gpe_status)
> >
> >+/*************************************************************************
> >******
> >+ *
> >+ * FUNCTION:    acpi_set_gpe_stats_count
> >+ *
> >+ * PARAMETERS:  gpe_device      - Parent GPE Device. NULL for GPE0/GPE1
> >+ *              gpe_number      - GPE level within the GPE block
> >+ *              count           - New value of the event counter
> >+ *
> >+ * RETURN:      Status
> >+ *
> >+ * DESCRIPTION: Set the event counter of the given GPE to a new value.
> >+ *
> >+
> >***************************************************************************
> >***/
> >+acpi_status acpi_set_gpe_stats_count(acpi_handle gpe_device, u32
> >gpe_number,
> >+                                     u32 count)
> >+{
> >+      struct acpi_gpe_event_info *gpe_event_info;
> >+      acpi_cpu_flags flags;
> >+      acpi_status status = AE_OK;
> >+
> >+      ACPI_FUNCTION_TRACE(acpi_set_gpe_stats_count);
> >+
> >+      flags = acpi_os_acquire_lock(acpi_gbl_gpe_lock);
> >+
> >+      /* Ensure that we have a valid GPE number */
> >+
> >+      gpe_event_info = acpi_ev_get_gpe_event_info(gpe_device, gpe_number);
> >+      if (gpe_event_info) {
> >+              gpe_event_info->stats.count = count;
> >+      } else {
> >+              status = AE_BAD_PARAMETER;
> >+      }
> >+
> >+      acpi_os_release_lock(acpi_gbl_gpe_lock, flags);
> >+      return_ACPI_STATUS(status);
> >+}
> >+ACPI_EXPORT_SYMBOL(acpi_set_gpe_stats_count)
> >+
> >
> >/**************************************************************************
> >****
> >  *
> >  * FUNCTION:    acpi_disable_all_gpes
> >Index: linux-2.6/drivers/acpi/scan.c
> >===================================================================
> >--- linux-2.6.orig/drivers/acpi/scan.c
> >+++ linux-2.6/drivers/acpi/scan.c
> >@@ -809,7 +809,7 @@ static void acpi_bus_set_run_wake_flags(
> >
> >       status = acpi_get_gpe_status(device->wakeup.gpe_device,
> >                                       device->wakeup.gpe_number,
> >-                                              &event_status);
> >+                                              &event_status, NULL);
> >       if (status == AE_OK)
> >               device->wakeup.flags.run_wake =
> >                               !!(event_status & ACPI_EVENT_FLAG_HANDLE);
> >Index: linux-2.6/drivers/acpi/acpica/evevent.c
> >===================================================================
> >--- linux-2.6.orig/drivers/acpi/acpica/evevent.c
> >+++ linux-2.6/drivers/acpi/acpica/evevent.c
> >@@ -221,7 +221,6 @@ u32 acpi_ev_fixed_event_detect(void)
> >                        * Found an active (signalled) event. Invoke global event
> >                        * handler if present.
> >                        */
> >-                      acpi_fixed_event_count[i]++;
> >                       if (acpi_gbl_global_event_handler) {
> >                               acpi_gbl_global_event_handler
> >                                   (ACPI_EVENT_TYPE_FIXED, NULL, i,
> >@@ -253,6 +252,8 @@ static u32 acpi_ev_fixed_event_dispatch(
> >
> >       ACPI_FUNCTION_ENTRY();
> >
> >+      acpi_gbl_fixed_event_info[event].stats.count++;
> >+
> >       /* Clear the status bit */
> >
> >       (void)acpi_write_bit_register(acpi_gbl_fixed_event_info[event].
> >Index: linux-2.6/include/acpi/acpiosxf.h
> >===================================================================
> >--- linux-2.6.orig/include/acpi/acpiosxf.h
> >+++ linux-2.6/include/acpi/acpiosxf.h
> >@@ -177,9 +177,6 @@ acpi_os_install_interrupt_handler(u32 gs
> > acpi_status
> > acpi_os_remove_interrupt_handler(u32 gsi, acpi_osd_handler
> >service_routine);
> >
> >-void acpi_os_gpe_count(u32 gpe_number);
> >-void acpi_os_fixed_event_count(u32 fixed_event_number);
> >-
> > /*
> >  * Threads and Scheduling
> >  */
> >Index: linux-2.6/drivers/acpi/acpica/acglobal.h
> >===================================================================
> >--- linux-2.6.orig/drivers/acpi/acpica/acglobal.h
> >+++ linux-2.6/drivers/acpi/acpica/acglobal.h
> >@@ -146,9 +146,6 @@ u8 acpi_gbl_system_awake_and_running;
> >
> > extern u32 acpi_gbl_nesting_level;
> >
> >-ACPI_EXTERN u32 acpi_gpe_count;
> >-ACPI_EXTERN u32 acpi_fixed_event_count[ACPI_NUM_FIXED_EVENTS];
> >-
> > /* Support for dynamic control method tracing mechanism */
> >
> > ACPI_EXTERN u32 acpi_gbl_original_dbg_level;
> 
> 

