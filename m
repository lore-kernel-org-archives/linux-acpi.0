From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode - Toshiba Satellite P205
Date: Fri, 18 Jan 2008 17:14:48 -0500
Message-ID: <200801181714.48587.lenb@kernel.org>
References: <BAY131-F32A663C888BB99B0395CB5E17E0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34359 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754138AbYARWPC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2008 17:15:02 -0500
In-Reply-To: <BAY131-F32A663C888BB99B0395CB5E17E0@phx.gbl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ricardo Rivera <rivera151@hotmail.com>
Cc: linux-acpi@vger.kernel.org

	Manufacturer: TOSHIBA
	Product Name: Satellite P205

With 2.6.22, did you notice any functional difference with "acpi_osi=!Linux"?

(or since the default changed at 2.6.23, with 2.6.23 or later
 do you notice any difference with "acpi_osi=Linux"?)

Please send me the output from acpidump.
If you don't have acpidump, you can get it from pmtools here:
http://www.lesswatts.org/projects/acpi/utilities.php

thanks,
-Len
