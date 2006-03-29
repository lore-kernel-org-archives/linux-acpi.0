From: "Brown, Len" <len.brown@intel.com>
Subject: RE: no /proc/acpi, trying to dump dsdt to a file
Date: Wed, 29 Mar 2006 14:04:16 -0500
Message-ID: <CFF307C98FEABE47A452B27C06B85BB60B8154@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:18583 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1750830AbWC2TEd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2006 14:04:33 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: glen martin <lists@locutory.org>, linux-acpi@vger.kernel.org

You can dump your ACPI tables with acpidump, no matter if you
are booted in ACPI mode or not.  Get the latest from pmtools here:

http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

/DSDT.aml not found.
> tbxface-0109 [02] load_tables           : ACPI Tables successfully acquired
>nssearch-0311: *** Error: ns_search_and_enter: Bad character in ACPI
>Name: 43035350
> dswload-0292: *** Error: Looking up [0x43035350] (NON-ASCII)
> in namespace, AE_BAD_CHARACTER
>  psloop-0287 [09] ps_parse_loop         : During name lookup/catalog,
>AE_BAD_CHARACTER
> tbxface-0115: *** Error: acpi_load_tables: Could not load namespace:
>AE_BAD_CHARACTER
> tbxface-0123: *** Error: acpi_load_tables: Could not load tables:
>AE_BAD_CHARACTER
>ACPI: Unable to load the System Description Tables
>
>
>Any suggestions?

Replace the non-ascii character with an ascii one.
There is a patch about to work around this -- let me find it...
