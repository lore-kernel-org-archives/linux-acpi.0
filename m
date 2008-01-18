From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode (MacBookPro1,1)
Date: Fri, 18 Jan 2008 15:45:17 -0500
Message-ID: <200801181545.17901.lenb@kernel.org>
References: <20080106021641.4yvxl28rw40s40kg@webmail.netz00.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57825 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758103AbYARUpe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2008 15:45:34 -0500
In-Reply-To: <20080106021641.4yvxl28rw40s40kg@webmail.netz00.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: meister@netz00.com
Cc: linux-acpi@vger.kernel.org


System Information
	Manufacturer: Apple Computer, Inc.
	Product Name: MacBookPro1,1
	Version: 1.0
	Serial Number: W86151LUVJ3
	UUID: 9CFE245E-D0C8-BD45-A79F-54EA5FBD3D97
	Wake-up Type: Power Switch
	SKU Number: System SKUNumber
	Family: Napa Mac

With 2.6.22, did you notice any functional difference with "acpi_osi=!Linux"?

(or since the default changed at 2.6.23, with 2.6.23 or later
 do you notice any difference with "acpi_osi=Linux"?)

Please send me the output from acpidump.
If you don't have acpidump, you can get it from pmtools here:
http://www.lesswatts.org/projects/acpi/utilities.php

thanks,
-Len

