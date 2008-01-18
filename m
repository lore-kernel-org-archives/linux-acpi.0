From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode_out.txt (Acer Aspire 5610)
Date: Fri, 18 Jan 2008 17:22:34 -0500
Message-ID: <200801181722.35021.lenb@kernel.org>
References: <200711141655.22037.assistinfo22@orange.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:52417 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932525AbYARWWu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2008 17:22:50 -0500
In-Reply-To: <200711141655.22037.assistinfo22@orange.fr>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: assistinfo22@orange.fr
Cc: linux-acpi@vger.kernel.org

On Wednesday 14 November 2007 10:55, assistinfo wrote:
> hi !!
> 
> it's for you =>
> 
> [   21.093044] ACPI: System BIOS is requesting _OSI(Linux)
> [   21.093048] ACPI: Please test with "acpi_osi=!Linux"
> [   21.093051] Please send dmidecode to linux-acpi@vger.kernel.org
> 

System Information
	Manufacturer: Acer            
	Product Name: Aspire 5610     

With 2.6.22, did you notice any functional difference with "acpi_osi=!Linux"?

(or since the default changed at 2.6.23, with 2.6.23 or later
 do you notice any difference with "acpi_osi=Linux"?)

Please send me the output from acpidump.
If you don't have acpidump, you can get it from pmtools here:
http://www.lesswatts.org/projects/acpi/utilities.php

thanks,
-Len
