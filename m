From: Albert Vilella <avilella@gmail.com>
Subject: Re: new fixes for sony-acpi
Date: Sat, 28 Mar 2009 12:11:51 +0000
Message-ID: <358f4d650903280511r1c7ba88an14226c2f8f1438d8@mail.gmail.com>
References: <20090323163459.GB5463@gamma.logic.tuwien.ac.at>
	 <alpine.LFD.2.00.0903272132400.26419@localhost.localdomain>
	 <20090328013832.GA4778@srcf.ucam.org>
	 <200903280941.12955.matze@welwarsky.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f158.google.com ([209.85.220.158]:42515 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751769AbZC1MLy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 08:11:54 -0400
Received: by fxm2 with SMTP id 2so1344139fxm.37
        for <linux-acpi@vger.kernel.org>; Sat, 28 Mar 2009 05:11:51 -0700 (PDT)
In-Reply-To: <200903280941.12955.matze@welwarsky.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthias Welwarsky <matze@welwarsky.de>, mjg59@srcf.ucam.org
Cc: linux-acpi@vger.kernel.org

>> > What about the speed/stamina stuff -- is anybody testing it?
>> The speed/stamina stuff isn't Sony specific. I'm working on an external
>> module to handle that.
>
> Looking at the somewhat twisted way the Sony DSDT code handles power
> management for the graphics adapters, I have my doubts that there will be a
> generic way. Of course a framework like for the rf kill switch could be
> useful, but the vendor and model specific code would end up in sony-laptop
> anyway.

Hi Matthias and Matthew,

I am right in thinking that reading the DSDT tables for hybrid
graphics laptops is sufficient to infer their workings?
I've been compiling a list of hybrid graphics laptops and been asking
people to provide their DSDT tables
in this bug report:
https://bugs.launchpad.net/bugs/312756

So far, I've identified 12 laptops, and we've got DSDT tables for 4 of them:
http://linux-hybrid-graphics.blogspot.com/2009/03/412-linux-dsdt-tables-for-laptops-with.html

Please let me know if you think we should be asking any other info,

Cheers,

    Albert.
