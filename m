From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode output, as requested (MacBook1,1)
Date: Fri, 18 Jan 2008 16:48:00 -0500
Message-ID: <200801181648.00291.lenb@kernel.org>
References: <200712071858.03017.H.A.J.Koster@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43388 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755240AbYARVsN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2008 16:48:13 -0500
In-Reply-To: <200712071858.03017.H.A.J.Koster@xs4all.nl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henk Koster <H.A.J.Koster@xs4all.nl>
Cc: linux-acpi@vger.kernel.org

	Manufacturer: Apple Computer, Inc.
	Product Name: MacBook1,1

With 2.6.22, did you notice any functional difference with "acpi_osi=!Linux"?

(or since the default changed at 2.6.23, with 2.6.23 or later
 do you notice any difference with "acpi_osi=Linux"?)

Please send me the output from acpidump.
If you don't have acpidump, you can get it from pmtools here:
http://www.lesswatts.org/projects/acpi/utilities.php

thanks,
-Len
