From: Len Brown <lenb@kernel.org>
Subject: Re: Please send dmidecode - Dell Inspiron 1501
Date: Mon, 21 Jan 2008 22:50:58 -0500
Message-ID: <200801212250.58376.lenb@kernel.org>
References: <49680ac7c7a44b6aebd3565e0565932e@82.83.255.88>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:45030 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752787AbYAVDvS (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 21 Jan 2008 22:51:18 -0500
In-Reply-To: <49680ac7c7a44b6aebd3565e0565932e@82.83.255.88>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Martijn <martijn@monomania.nl>
Cc: linux-acpi@vger.kernel.org


> > On Tuesday 18 September 2007 02:20, Martijn Brugman wrote:
> > &gt; System Information
> > &gt;         Manufacturer: Dell Inc.
> > &gt;         Product Name: Inspiron 1501 
> > &gt;         Version: Not Specified                   
> > &gt;         Serial Number: HWYGR2J
> > &gt;         UUID: 44454C4C-5700-1059-8047-C8C04F52324A
> > &gt;         Wake-up Type: Power Switch
> > &gt;         SKU Number: Not Specified
> > &gt;         Family: Not Specified
> > &gt; 
> > &gt; Handle 0x0003, DMI type 2, 8 bytes
> > &gt; Base Board Information
> > &gt;         Manufacturer: Dell Inc.
> > &gt;         Product Name: 0UW744
> > 

thanks for the acpidump


                    If (\_OSI ("Windows 2006"))
                    {
                        Store (0x40, ^OSTB)
                        Store (0x40, ^TPOS)
                    }

                    If (\_OSI ("Linux"))
                    {
                        Store (0x01, LINX)
                        Store (0x80, ^OSTB)
                        Store (0x80, ^TPOS)
                    }

LINX is written and never read.
OSTB and TPOS are only compard to > 4, where this write has no effect

so OSI(Linux) is a NOP on this box.

thanks,
-Len
