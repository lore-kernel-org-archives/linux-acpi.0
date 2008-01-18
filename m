From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode from lenovo/ibm r61
Date: Fri, 18 Jan 2008 15:47:47 -0500
Message-ID: <200801181547.47276.lenb@kernel.org>
References: <1199193040.4930.4.camel@k-pax>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58953 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765588AbYARUsB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2008 15:48:01 -0500
In-Reply-To: <1199193040.4930.4.camel@k-pax>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefan Resing <stoffel.010170@gmx.de>
Cc: linux-acpi@vger.kernel.org

System Information
	Manufacturer: LENOVO
	Product Name: 89185QG
	Version: ThinkPad R61
	Serial Number: L3A8343
	UUID: 66286A01-495A-11CB-9BEA-E3DE5381FB5B
	Wake-up Type: Power Switch
	SKU Number: Not Specified
	Family: ThinkPad R61

With 2.6.22, did you notice any functional difference with "acpi_osi=!Linux"?

(or since the default changed at 2.6.23, with 2.6.23 or later
 do you notice any difference with "acpi_osi=Linux"?)

Please send me the output from acpidump.
If you don't have acpidump, you can get it from pmtools here:
http://www.lesswatts.org/projects/acpi/utilities.php

thanks,
-Len
