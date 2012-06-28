From: Michael Zintakis <michael.zintakis@googlemail.com>
Subject: Re: [lm-sensors] Fintek f71882fg ACPI conflict
Date: Thu, 28 Jun 2012 13:53:49 +0100
Message-ID: <4FEC53DD.8050403@googlemail.com>
References: <4FEA4C10.2060904@googlemail.com>	<20120627171505.GB12712@roeck-us.net>	<4FEB90A8.8050901@googlemail.com>	<20120628014548.GA15994@srcf.ucam.org>	<4FEC3CDF.7050901@googlemail.com> <20120628144035.36ac75a0@endymion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lb0-f174.google.com ([209.85.217.174]:45029 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692Ab2F1MyE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Jun 2012 08:54:04 -0400
Received: by lbbgm6 with SMTP id gm6so3064206lbb.19
        for <linux-acpi@vger.kernel.org>; Thu, 28 Jun 2012 05:54:03 -0700 (PDT)
In-Reply-To: <20120628144035.36ac75a0@endymion.delvare>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jean Delvare <khali@linux-fr.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, lm-sensors@lm-sensors.org


> Don't hold your breath though, it will take years before the problem
> actually gets solved for the end user - if that ever happens.
>   
Pretty grim that!

In the meantime, considering the specifics of my particular case and the 
memory regions involved (again, I think they are 0x290-0x297, a total of 
8 bytes in length according to the driver, though if someone more 
knowledgeable in the f71882fg driver specifics know otherwise, please 
feel free to correct this if that assumption is wrong), would it be 
possible to manually hack into the ACPI code and forcefully prevent it 
from claiming those memory regions and not get involved in "managing" 
that particular device?

I appreciate this could be quite ugly, but I am that desperate - I don't 
want ACPI doing the "managing" and want the f71822fg driver to have a 
free reign (without the risks, as previously noted!), albeit with the 
help of my bash script at times. :-)
