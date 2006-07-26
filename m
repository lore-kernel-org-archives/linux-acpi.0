From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [gpm] Untangling the sleep hotkey mess
Date: Wed, 26 Jul 2006 19:41:26 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB601125524@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:52060 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751818AbWGZXos convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 26 Jul 2006 19:44:48 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard Hughes <hughsient@gmail.com>, Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, gnome-power-manager-list@gnome.org, hal@lists.freedesktop.org, desktop_portables@lists.osdl.org

 
>> But input layer will be a hub of sorts and I am arguing for ACPI
>> to be converted to use input layer directly.
>
>What does lkml think of ACPI using the input layer directly? 

I think it is a good idea.

The only question I have is how to transition.
If I replace the acpi_bus_generate_event() calls for
power/sleep/lid/hotkeys
and replace them with input_report_key(), will there be something up
there
listening for these events when acpid does not get them?

thanks,
-Len

ps. the long term goal is to delete /proc/acpi, including
/proc/acpi/event.
Getting rid of the events that are like keys is a step in that
direction,
but there are a bunch of other steps for non key-like events too.
