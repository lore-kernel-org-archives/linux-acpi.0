From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [lm-sensors] Fintek f71882fg ACPI conflict
Date: Thu, 28 Jun 2012 15:27:54 +0200
Message-ID: <20120628152754.2ab6697a@endymion.delvare>
References: <4FEA4C10.2060904@googlemail.com>
	<20120627171505.GB12712@roeck-us.net>
	<4FEB90A8.8050901@googlemail.com>
	<20120628014548.GA15994@srcf.ucam.org>
	<4FEC3CDF.7050901@googlemail.com>
	<20120628144035.36ac75a0@endymion.delvare>
	<4FEC53DD.8050403@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zoneX.GCU-Squad.org ([194.213.125.0]:9547 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751311Ab2F1N2E (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Jun 2012 09:28:04 -0400
In-Reply-To: <4FEC53DD.8050403@googlemail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Michael Zintakis <michael.zintakis@googlemail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, lm-sensors@lm-sensors.org

On Thu, 28 Jun 2012 13:53:49 +0100, Michael Zintakis wrote:
> In the meantime, considering the specifics of my particular case and the 
> memory regions involved (again, I think they are 0x290-0x297, a total of 
> 8 bytes in length according to the driver, though if someone more 
> knowledgeable in the f71882fg driver specifics know otherwise, please 
> feel free to correct this if that assumption is wrong), would it be 
> possible to manually hack into the ACPI code and forcefully prevent it 
> from claiming those memory regions and not get involved in "managing" 
> that particular device?

Not that I know of. That would rather be a question for the ACPI
people, but I'm afraid the answer is that ACPI is supposed to be the
best thing since sliced bread and you should just let it do its stuff
and not ask questions :( I too would love to be able to tell ACPI to
let my hardware monitoring chip (and/or SMBus controller) alone.

-- 
Jean Delvare
