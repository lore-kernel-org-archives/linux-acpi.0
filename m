From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Why don't we use _TTS method?
Date: Thu, 3 May 2007 22:01:48 +0200
Message-ID: <200705032201.49071.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:54409 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751892AbXECT5a (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 May 2007 15:57:30 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>

Hi,

I've got two questions regarding the implementation of the ACPI poweroff/sleep
code in drivers/acpi/sleep and drivers/acpi/hardware .

1) We don't seem to use the _TTS system-control method, although the ACPI
specification (ACPI 3.0b) says that this method should be used for intiating
and finishing power transitions.  Could you please tell me why we don't use it?

2) In the functions acpi_enter_sleep_state_prep(), acpi_enter_sleep_state(),
acpi_leave_sleep_state() we manipulate GPEs quite extensively (we disable
and enable them for a couple of times during a transition), although the
specification doesn't tell anything about that explicitly.  Could you please
explain to me what the purpose of that is?

Greetings,
Rafael


-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
