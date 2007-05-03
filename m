From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: Why don't we use _TTS method?
Date: Thu, 3 May 2007 15:57:18 -0700
Message-ID: <B28E9812BAF6E2498B7EC5C427F293A40267F659@orsmsx415.amr.corp.intel.com>
References: <200705032201.49071.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:65475 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754449AbXECW5T convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 May 2007 18:57:19 -0400
Content-class: urn:content-classes:message
In-Reply-To: <200705032201.49071.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>



> -----Original Message-----
> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> owner@vger.kernel.org] On Behalf Of Rafael J. Wysocki
> Sent: Thursday, May 03, 2007 1:02 PM
> To: ACPI Devel Maling List
> Cc: pm list; Pavel Machek
> Subject: Why don't we use _TTS method?
> 
> Hi,
> 
> I've got two questions regarding the implementation of the ACPI
> poweroff/sleep
> code in drivers/acpi/sleep and drivers/acpi/hardware .
> 
> 1) We don't seem to use the _TTS system-control method, although the
ACPI
> specification (ACPI 3.0b) says that this method should be used for
> intiating
> and finishing power transitions.  Could you please tell me why we
don't
> use it?
> 
[Moore, Robert] 

Probably because it's fairly new and it takes a long time for these
things to appear in real machines. Also, needs to be supported in
Windows before we ever see it in real machines.

> 2) In the functions acpi_enter_sleep_state_prep(),
> acpi_enter_sleep_state(),
> acpi_leave_sleep_state() we manipulate GPEs quite extensively (we
disable
> and enable them for a couple of times during a transition), although
the
> specification doesn't tell anything about that explicitly.  Could you
> please
> explain to me what the purpose of that is?
> 
[Moore, Robert] 

There a wake GPEs and runtime GPEs that need to be managed separately.
We want to make sure that only the "Wake" GPEs are enabled as we goto
sleep.

Bob


> Greetings,
> Rafael
> 
> 
> --
> If you don't have the time to read,
> you don't have the time or the tools to write.
> 		- Stephen King
> -
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
