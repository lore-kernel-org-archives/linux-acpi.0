From: Joel Bretz <jbretz@rsn.hp.com>
Subject: AcpiGetTable( ? )
Date: Tue, 16 May 2006 16:23:27 -0500
Message-ID: <1147814607.20702.17.camel@zion.rsn.hp.com>
Reply-To: joel.bretz@hp.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from palrel11.hp.com ([156.153.255.246]:62086 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S932065AbWEPVX3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 16 May 2006 17:23:29 -0400
Received: from mailb.rsn.hp.com (it4-3.rsn.hp.com [15.99.203.1])
	by palrel11.hp.com (Postfix) with ESMTP id B66BD34D56
	for <linux-acpi@vger.kernel.org>; Tue, 16 May 2006 14:23:28 -0700 (PDT)
Received: from zion.rsn.hp.com (zion.rsn.hp.com [15.99.19.197])
	by mailb.rsn.hp.com (8.11.1/8.9.3 SMKit7.0) with ESMTP id k4GLNRt23309
	for <linux-acpi@vger.kernel.org>; Tue, 16 May 2006 16:23:27 -0500 (CDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,
I need some information that lives in the DBGP and the HPET Tables.. I
don't see a way that I can get either of those tables.

I'm guessing that
   AcpiGetTable(ACPI_TABLE_TYPE,UINT32,ACPI_BUFFER*)
provides the functionality that I need, but I can not find the correct
table types for either of those.

I'm using a slightly older version of acpica (acpica-unix-20060317), but
I didn't see entries for
  ACPI_TABLE_DGBP or ACPI_TABLE_HPET 
in actypes.h in the latest version either...

Is there a way that I can get the information from these 2 tables?

Thanks,
Joel

//--------------------------------
Joel Bretz
Hardware Engineer
Hewlett Packard, Systems VLSI Lab
email: joel.bretz@hp.com
//--------------------------------

