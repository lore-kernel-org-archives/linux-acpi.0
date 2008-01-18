From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode (Acer Aspire 5050)
Date: Fri, 18 Jan 2008 17:28:39 -0500
Message-ID: <200801181728.40046.lenb@kernel.org>
References: <1195031290.6446.1.camel@ITmanager>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42669 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755593AbYARW26 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2008 17:28:58 -0500
In-Reply-To: <1195031290.6446.1.camel@ITmanager>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Philippe <pdidier@neptuneconcept.com>
Cc: linux-acpi@vger.kernel.org


> kernel: [    0.652000] ACPI: System BIOS is requesting _OSI(Linux)
> kernel: [    0.652000] ACPI: Please test with "acpi_osi=!Linux"
> kernel: [    0.652000] Please send dmidecode to
> linux-acpi@vger.kernel.org

	Manufacturer: Acer, inc.
	Product Name: Aspire 5050

With 2.6.22, did you notice any functional difference with "acpi_osi=!Linux"?

(or since the default changed at 2.6.23, with 2.6.23 or later
 do you notice any difference with "acpi_osi=Linux"?)

Please send me the output from acpidump.
If you don't have acpidump, you can get it from pmtools here:
http://www.lesswatts.org/projects/acpi/utilities.php

thanks,
-Len
