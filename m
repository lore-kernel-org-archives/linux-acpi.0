From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [PATCH 091/171] ACPI: GPE enabling should happen after EC	installation
Date: Wed, 30 Apr 2008 14:04:13 +0400
Message-ID: <4818441D.2010800@suse.de>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>	 <1209551134.12515.47.camel@yakui_zhao.sh.intel.com>	 <200804300758.54778.carlos@strangeworlds.co.uk>	 <200804300817.53800.carlos@strangeworlds.co.uk> <1209573782.16111.32.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:51070 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753121AbYD3KEK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 30 Apr 2008 06:04:10 -0400
In-Reply-To: <1209573782.16111.32.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>

Zhao Yakui wrote:
> On Wed, 2008-04-30 at 08:17 +0100, Carlos Corbacho wrote:
>> On Wednesday 30 April 2008 07:58:53 Carlos Corbacho wrote:
>>> On Wednesday 30 April 2008 11:25:34 Zhao Yakui wrote:
>>>> On Tue, 2008-04-29 at 04:44 -0400, Len Brown wrote:
>>>>> From: Alexey Starikovskiy <astarikovskiy@suse.de>
>>>>>
>>>>> GPE could try to access EC region, so should not be enabled before
>>>>> EC is installed
>>>> It is caused by broken bios if GPE method tries to access EC region
>>>> before EC is initialized correctly. It is more appropriate to fix this
>>>> issue by upgrading bios rather than by the patch.
>>>> And this patch will cause some potential problems.
>>> 1) Does the BIOS in question work under Windows?
>> ^^^
>> that should be 'not work'
> For the laptop in bug 9916:
> Windows can work on the BIOS in question. In fact only warning message
> is printed for Linux and it won't break anything. (Maybe the warning
> message also exists on windows. But we can't see them.)
This is generally a stupid idea to enable interrupt before you have handler for it ready,
even if you are able to _survive_ unhandled interrupt.

Your other issue about WAKE GPEs, which could be wrongly enabled, could be solved by
moving WAKE GPE init closer to RUNTIME GPE one:

Regards,
Alex.



diff --git a/drivers/acpi/events/evgpeblk.c b/drivers/acpi/events/evgpeblk.c
index 361ebe6..37c68ae 100644
--- a/drivers/acpi/events/evgpeblk.c
+++ b/drivers/acpi/events/evgpeblk.c
@@ -940,6 +940,27 @@ acpi_ev_create_gpe_block(struct acpi_namespace_node *gpe_device,
 					acpi_ev_save_method_info, gpe_block,
 					NULL);
 
+	/*
+	 * Runtime option: Should wake GPEs be enabled at runtime?  The default
+	 * is no, they should only be enabled just as the machine goes to sleep.
+	 */
+	if (acpi_gbl_leave_wake_gpes_disabled) {
+		/*
+		 * Differentiate runtime vs wake GPEs, via the _PRW control methods.
+		 * Each GPE that has one or more _PRWs that reference it is by
+		 * definition a wake GPE and will not be enabled while the machine
+		 * is running.
+		 */
+		gpe_info.gpe_block = gpe_block;
+		gpe_info.gpe_device = gpe_device;
+
+		status =
+		    acpi_ns_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
+					   ACPI_UINT32_MAX, ACPI_NS_WALK_UNLOCK,
+					   acpi_ev_match_prw_and_gpe, &gpe_info,
+					   NULL);
+	}
+
 	/* Return the new block */
 
 	if (return_gpe_block) {
@@ -995,27 +1016,6 @@ acpi_ev_initialize_gpe_block(struct acpi_namespace_node *gpe_device,
 	}
 
 	/*
-	 * Runtime option: Should wake GPEs be enabled at runtime?  The default
-	 * is no, they should only be enabled just as the machine goes to sleep.
-	 */
-	if (acpi_gbl_leave_wake_gpes_disabled) {
-		/*
-		 * Differentiate runtime vs wake GPEs, via the _PRW control methods.
-		 * Each GPE that has one or more _PRWs that reference it is by
-		 * definition a wake GPE and will not be enabled while the machine
-		 * is running.
-		 */
-		gpe_info.gpe_block = gpe_block;
-		gpe_info.gpe_device = gpe_device;
-
-		status =
-		    acpi_ns_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
-					   ACPI_UINT32_MAX, ACPI_NS_WALK_UNLOCK,
-					   acpi_ev_match_prw_and_gpe, &gpe_info,
-					   NULL);
-	}
-
-	/*
 	 * Enable all GPEs in this block that have these attributes:
 	 * 1) are "runtime" or "run/wake" GPEs, and
 	 * 2) have a corresponding _Lxx or _Exx method

