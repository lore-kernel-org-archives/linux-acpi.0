From: Len Brown <lenb@kernel.org>
Subject: Re: Requested output of dmidecode (Acer Ferrari 5000)
Date: Fri, 18 Jan 2008 21:24:08 -0500
Message-ID: <200801182124.08287.lenb@kernel.org>
References: <f9d2a5e10708101949o3bee7bd8w24f9fa371db8bd58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33240 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756454AbYASCYY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2008 21:24:24 -0500
In-Reply-To: <f9d2a5e10708101949o3bee7bd8w24f9fa371db8bd58@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Russ Dill <russ.dill@gmail.com>
Cc: linux-acpi@vger.kernel.org

System Information
	Manufacturer: Acer, inc.
	Product Name: Ferrari 5000    
	Version: Not Applicable
	Serial Number: LXFR50U059709101632500
	UUID: 00658684-FD58-D811-856F-001636A654F8
	Wake-up Type: Power Switch
	SKU Number: Not Specified
	Family: Not Specified

Handle 0x0002, DMI type 2, 8 bytes
Base Board Information
	Manufacturer: Acer, Inc.
	Product Name: Ferrari5        

Thanks for the dmidecode output.

Do you notice any functional difference when booting with

"acpi_osi=Linux"        (default for 2.6.22 and earlier)
vs.
"acpi_osi=!Linux"       (default for 2.6.23 and later)

Also, please send me the output from acpidump.

thanks,
-Len

ps
If you don't have acpidump, you can get it from pmtools here:
http://www.lesswatts.org/projects/acpi/utilities.php
