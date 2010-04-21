From: Florian Echtler <floe@butterbrot.org>
Subject: Re: Looking for some pointers on WMI/EC access
Date: Wed, 21 Apr 2010 16:30:06 +0200
Message-ID: <1271860206.1537.1914.camel@pancake>
References: <1271518653.4549.186.camel@flunder>
	 <q2s71cd59b01004181221kce7c1e5cn7742b1063827ac3b@mail.gmail.com>
	 <1271687130.26267.147.camel@pancake>
	 <p2r71cd59b01004190846m29f82672w93966b499aa917cf@mail.gmail.com>
	 <1271746353.16585.9.camel@flunder>
	 <i2r71cd59b01004200021p9a45af39y94c007edecb47884@mail.gmail.com>
	 <s2o71cd59b01004200030jfaa10a4bs81e937d2e50b15b0@mail.gmail.com>
	 <1271762498.1537.215.camel@pancake>
	 <m2i71cd59b01004200509ye8fa593xc7bd5b201d484046@mail.gmail.com>
	 <1271853961.1537.1781.camel@pancake> <20100421133305.GA28710@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from static.88-198-47-201.clients.your-server.de ([88.198.47.201]:49281
	"EHLO butterbrot.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755276Ab0DUOaN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 21 Apr 2010 10:30:13 -0400
In-Reply-To: <20100421133305.GA28710@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Corentin Chary <corentin.chary@gmail.com>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org

> Yes, _Q indicates that it's an embedded controller event (_L and _E are 
> level or edge triggered events from GPEs). Unless either DSGO or DSSV 
> trigger a notification I'd hope that the EC fires some other event after 
> the hotkey has been stored.
Thanks - now let me try to sum this up in order to get it straight (I've been
reading the ACPI spec and had to fight sleep really hard :-).

1. EC detects an event (hotkey), raises an SCI.

2. Linux ec.c driver services the SCI, queries the EC for event code.

3. If available, ec.c calls ACPI _Qxx method for received event code.

4. _Qxx method changes some internal state and MAY again call
   Notify(...) to pass the event to some other ACPI device.

5. If Notify() was called, second-level ACPI driver (e.g. battery.c,
   thermal.c, ...) gets event and handles it accordingly.

If that's correct so far, couldn't I just print the EC event code in
acpi_ec_sync_query and see what it's spitting out on hotkey press?

Florian
-- 
0666 - Filemode of the Beast

