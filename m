From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode of Acer 5050 Aspire 5053NWXMi
Date: Mon, 21 Jan 2008 22:36:08 -0500
Message-ID: <200801212236.09100.lenb@kernel.org>
References: <1197081036.3112.2.camel@localhost.localdomain> <200801190122.17846.lenb@kernel.org> <1200970497.2879.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40844 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751359AbYAVDgY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Jan 2008 22:36:24 -0500
In-Reply-To: <1200970497.2879.3.camel@localhost.localdomain>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: thomas.ramapuram@gmail.com
Cc: linux-acpi@vger.kernel.org

The Acer Aspire 5050 risks less breakage than some other Acer models,
but still has some Windows hooks in the SATA code that
will get disabled by OSI(Linux).  Unless you notice
something related to SATA running better with OSI(Linux) enabled,
I'm going to keep this one blacklisted to disable OSI(Linux).

thanks,
-Len

                    If (\_OSI ("Windows 2006"))
                    {
                        Store (0x40, ^OSTB)
                        Store (0x40, ^TPOS)
                    }

                    If (\_OSI ("Linux"))
                    {
                        Store (0x01, LINX)	# NOP, as usual
                        Store (0x80, ^OSTB)	# NOP on this model
                        Store (0x80, ^TPOS)	# overwrites TPOS above,
						# referenced from SATA
                    }

BIOS Information
        Vendor: Acer
        Version: v1.3309
        Release Date: 04/17/07
        Address: 0xE5230
        Runtime Size: 110032 bytes
        ROM Size: 1024 kB
 ...

Handle 0x0001, DMI type 1, 27 bytes.
System Information
        Manufacturer: Acer, inc.
        Product Name: Aspire 5050
        Version: Not Applicable
        Serial Number: LXAXD0C038722086C42502
        UUID: C0EEA45F-A586-D811-A729-001B24465C81
        Wake-up Type: Power Switch
        SKU Number: Not Specified
        Family: Not Specified

Handle 0x0002, DMI type 2, 8 bytes.
Base Board Information
        Manufacturer: Acer, Inc.
        Product Name: Prespa M
