From: Thomas Renninger <trenn@suse.de>
Subject: Windows defined WMI device (AMW0, _WDG_,...)
Date: Thu, 23 Feb 2006 01:15:50 +0100
Message-ID: <200602230115.50638.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:24499 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751481AbWBWAPx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Feb 2006 19:15:53 -0500
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id B3D811D78E
	for <linux-acpi@vger.kernel.org>; Thu, 23 Feb 2006 01:15:51 +0100 (CET)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I just found out about Windows defined WMI devices:
(See bug: http://bugzilla.kernel.org/show_bug.cgi?id=5670)

Device (AMW0){
    Name (_HID, EisaId ("PNP0C14"))
    ...
    Name (_WDG, Buffer (0x50)
    ...
}
A description what should happen can be found here:
http://www.microsoft.com/whdc/system/pnppwr/wmi/wmi-acpi.mspx

I see this the first time, googling did not reveal much and searching over
this list too, even the site says: Updated: December 4, 2001?
Has it ever been discussed to try to copy the Microsoft WMI
functionality into some kind of a kernel module?
To be honest I haven't yet understand this fully and it seems as working
around is nearly impossible due to the use of this CMI/MOF stuff.
I expect this could be the cause of fan trouble on some machines making
use of this (see bug above).

Thanks,

   Thomas
