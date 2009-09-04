From: "Jan Beulich" <JBeulich@novell.com>
Subject: [PATCH] acpi: fix compiler warning in processor_idle.c
Date: Fri, 04 Sep 2009 08:56:47 +0100
Message-ID: <4AA0E45F02000078000136D5@vpn.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vpn.id2.novell.com ([195.33.99.129]:32318 "EHLO
	vpn.id2.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932279AbZIDH4p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 4 Sep 2009 03:56:45 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: Suresh Siddha <suresh.b.siddha@intel.com>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, linux-acpi@vger.kernel.org

After commit f833bab87fca5c3ce13778421b1365845843b976 a build warning
results when ARCH_APICTIMER_STOPS_ON_C3 is not defined, due to
differing prototypes of the two instances of
lapic_timer_propagate_broadcast(). Rather than fixing the stub's
definition, it seems more reasonable to avoid the IPI altogether, since
it's rather pointless to do an IPI for a function that doesn't do
anything (unless the mere side effect of doing having an interrupt
occur on the remote CPU is needed, which doesn't appear to be the case
here).

Signed-off-by: Jan Beulich <jbeulich@novell.com>
Cc: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

---
 drivers/acpi/processor_idle.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.31-rc8/drivers/acpi/processor_idle.c	2009-08-28 14:54:27.000000000 +0200
+++ 2.6.31-rc8-acpi-lapic-timer-propagate/drivers/acpi/processor_idle.c	2009-09-02 12:46:54.000000000 +0200
@@ -193,7 +193,6 @@ static void lapic_timer_state_broadcast(
 
 static void lapic_timer_check_state(int state, struct acpi_processor *pr,
 				   struct acpi_processor_cx *cstate) { }
-static void lapic_timer_propagate_broadcast(struct acpi_processor *pr) { }
 static void lapic_timer_state_broadcast(struct acpi_processor *pr,
 				       struct acpi_processor_cx *cx,
 				       int broadcast)
@@ -636,8 +635,10 @@ static int acpi_processor_power_verify(s
 		working++;
 	}
 
+#ifdef ARCH_APICTIMER_STOPS_ON_C3
 	smp_call_function_single(pr->id, lapic_timer_propagate_broadcast,
 				 pr, 1);
+#endif
 
 	return (working);
 }



