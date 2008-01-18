From: Len Brown <lenb@kernel.org>
Subject: Re: Boot message: "kernel: Please send dmidecode to linux-acpi@vger.kernel.org"
Date: Fri, 18 Jan 2008 16:15:49 -0500
Message-ID: <200801181615.49838.lenb@kernel.org>
References: <1198940496.17999.2.camel@pluton>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40055 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760362AbYARVQE (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2008 16:16:04 -0500
In-Reply-To: <1198940496.17999.2.camel@pluton>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?utf-8?q?J=C3=A9r=C3=B4me_UZEL?= <jerome.uzel@wanadoo.fr>
Cc: linux-acpi@vger.kernel.org

System Information
	Manufacturer: FUJITSU SIEMENS
	Product Name: AMILO Xi 1546
	Version: Not Applicable
	Serial Number: 720056C3
	UUID: 8012A1C5-4264-0010-ABDB-D1748A8F1498
	Wake-up Type: Power Switch
	SKU Number: Not Specified
	Family: Not Specified

With 2.6.22, did you notice any functional difference with "acpi_osi=!Linux"?

(or since the default changed at 2.6.23, with 2.6.23 or later
 do you notice any difference with "acpi_osi=Linux"?)

Please send me the output from acpidump.
If you don't have acpidump, you can get it from pmtools here:
http://www.lesswatts.org/projects/acpi/utilities.php

thanks,
-Len

