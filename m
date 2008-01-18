From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode output for a Sony Vaio TZ21MN
Date: Fri, 18 Jan 2008 16:26:59 -0500
Message-ID: <200801181627.00108.lenb@kernel.org>
References: <200712270018.25131.theboywho@ruddyperl.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33879 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759668AbYARV1V (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2008 16:27:21 -0500
In-Reply-To: <200712270018.25131.theboywho@ruddyperl.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: theboywho@ruddyperl.com
Cc: linux-acpi@vger.kernel.org

System Information
	Manufacturer: Sony Corporation
	Product Name: VGN-TZ21MN_N
	Version: J002RMWG

     
With 2.6.22, did you notice any functional difference with "acpi_osi=!Linux"?

(or since the default changed at 2.6.23, with 2.6.23 or later
 do you notice any difference with "acpi_osi=Linux"?)

Please send me the output from acpidump.
If you don't have acpidump, you can get it from pmtools here:
http://www.lesswatts.org/projects/acpi/utilities.php

thanks,
-Len

          
         
