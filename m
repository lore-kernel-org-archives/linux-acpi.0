From: "Moore, Robert" <robert.moore@intel.com>
Subject: Recent GPE patches - some questions.
Date: Fri, 29 Jan 2010 12:30:25 -0800
Message-ID: <4911F71203A09E4D9981D27F9D83085855AF782E@orsmsx503.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:58107 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752485Ab0A2Ua1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 29 Jan 2010 15:30:27 -0500
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "rjw@sisk.pl" <rjw@sisk.pl>


Matthew,

I've looked at the new GPE code and I have some comments and questions. I'm still looking at Patch 3/3, "Remove old GPE API and transition code entirely to new one", but here are the questions I have so far.

Thanks,
Bob




[PATCH 0/3] acpica: Rewrite GPE handling

Overall, can we say that this change to the GPE code is primarily intended to add better support for shared GPEs?

I see that the execution of _PRW methods is no longer removed. This was a big question I had about the original patch.



[PATCH 1/3] ACPI: Add infrastructure for refcounting GPE consumers:

>Add an API to allow devices to indicate whether or not
>they want their device's GPE to be enabled for both runtime
>and wakeup events.

I'm not sure which interface you are referring to, please explain



[PATCH 2/3] ACPI: Add support for new refcounted GPE API to drivers:

Reference count mechanism is meant to:
    1) Enable GPE only on the first added reference
    2) Disable GPE only on the last removed reference

Then I don't understand why the code below needs to call acpi_enable_gpe:

		acpi_enable_gpe(dev->wakeup.gpe_device,
 				dev->wakeup.gpe_number);
+		acpi_ref_wakeup_gpe(dev->wakeup.gpe_device,
+				    dev->wakeup.gpe_number);

Because the GPE will be "enabled" (mask bit set for wakeup GPE) by acpi_ref_wakeup_gpe. There are several examples of this type of code. If it is true that the call to acpi_enable_gpe is unnecessary, then is acpi_enable_gpe interface needed at all? (same with disable_gpe).



[PATCH 2/3] acpica: Add support for unregistering ACPI GPE methods:

acpi_remove_gpe_method: Ok, this makes sense. Sad, but makes sense.



[PATCH 1/3] acpi: Provide default GPE handler if the firmware doesn't

>Firmware may support using GPEs for system wakeup without
>providing any runtime GPE handlers.

Do you mean by "runtime GPE handlers" to mean the _Lxx/_Exx GPE methods? If so, this should be clarified in the comments.



