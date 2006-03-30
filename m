From: "Yu, Luming" <luming.yu@intel.com>
Subject: RE: FIXED: no /proc/acpi, trying to dump dsdt to a file
Date: Thu, 30 Mar 2006 11:29:21 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD10F0BE5@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1394 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751295AbWC3DaX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2006 22:30:23 -0500
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: glen martin <lists@locutory.org>, linux-acpi@vger.kernel.org

>Or at least, I'm past my pain, thanks to a lot of help from 
>Robert and Len.
>
>To recap:
>
>The DSDT in my BIOS was very broken, such that ACPI didn't load up 
>properly.  This meant I was having trouble reading the data 
>from my BIOS 
>using /proc/acpi/dsdt.

Does windows works with such broken BIOS ?
