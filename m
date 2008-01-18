From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode 2.6.23.9 + ACER 7720Z
Date: Fri, 18 Jan 2008 16:29:51 -0500
Message-ID: <200801181629.51217.lenb@kernel.org>
References: <476BEAFA.5060007@free.fr>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34057 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755379AbYARVaF (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2008 16:30:05 -0500
In-Reply-To: <476BEAFA.5060007@free.fr>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?utf-8?q?St=C3=A9phane_BAUSSON?= <stephane.bausson@free.fr>
Cc: Linux-acpi@vger.kernel.org

System Information
        Manufacturer: Acer      
        Product Name: Aspire 7720Z    
        Version: V1.18

With 2.6.22, did you notice any functional difference with "acpi_osi=!Linux"?

(or since the default changed at 2.6.23, with 2.6.23 or later
 do you notice any difference with "acpi_osi=Linux"?)

Please send me the output from acpidump.
If you don't have acpidump, you can get it from pmtools here:
http://www.lesswatts.org/projects/acpi/utilities.php

thanks,
-Len
