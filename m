From: Len Brown <lenb@kernel.org>
Subject: Re: Boot message: "kernel: Please send dmidecode to linux-acpi@vger.kernel.org" - FSC AMILO Xi 1546
Date: Wed, 23 Jan 2008 00:51:39 -0500
Message-ID: <200801230051.39298.lenb@kernel.org>
References: <1198940496.17999.2.camel@pluton> <200801190112.23196.lenb@kernel.org> <1201038751.14807.5.camel@pluton>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:42855 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753335AbYAWFvv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Jan 2008 00:51:51 -0500
In-Reply-To: <1201038751.14807.5.camel@pluton>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?utf-8?q?J=C3=A9r=C3=B4me_UZEL?= <jerome.uzel@wanadoo.fr>
Cc: linux-acpi@vger.kernel.org


> > > > System Information
> > > > 	Manufacturer: FUJITSU SIEMENS
> > > > 	Product Name: AMILO Xi 1546
> > > > 	Version: Not Applicable
> > > > 	Serial Number: 720056C3
> > > > 	UUID: 8012A1C5-4264-0010-ABDB-D1748A8F1498
> > > > 	Wake-up Type: Power Switch
> > > > 	SKU Number: Not Specified
> > > > 	Family: Not Specified
> > > > 

thanks for the acpidump, it confirms that OSI(Linux) is a NOP on this system.

-Len


            If (CondRefOf (_OSI, Local0))
            {
                If (_OSI ("Linux"))
                {
                    Store (0x03E8, OSYS)
                }

                If (_OSI ("Windows 2001"))
                {
                    Store (0x07D1, OSYS)
                }
