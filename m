From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode (acpi_osi=!Linux)
Date: Mon, 2 Jul 2007 03:04:58 -0400
Message-ID: <200707020304.58932.lenb@kernel.org>
References: <200707011439.23511.a.biardi@tiscali.it>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:50198 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751127AbXGBHFM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 2 Jul 2007 03:05:12 -0400
In-Reply-To: <200707011439.23511.a.biardi@tiscali.it>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: a.biardi@tiscali.it
Cc: linux-acpi@vger.kernel.org

On Sunday 01 July 2007 10:39, a.biardi@tiscali.it wrote:
> 
> Upon booting 2.6.22-rc6, the kernel says:
> 
> Initializing Device/Processor/Thermal objects by executing _INI 
> methods:<4>ACPI: System BIOS is requesting _OSI(Linux)
> ACPI: Please test with "acpi_osi=!Linux"
> Please send dmidecode to linux-acpi@vger.kernel.org
> 
> so, attached is the dmidecode for my macbook pro (core2 duo)
> 
> let me know if you need further information

Yes, does it run differently with "acpi_osi=!Linux"?
Can you send me the output from acpidump?

thanks,
-Len
