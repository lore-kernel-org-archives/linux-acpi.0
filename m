From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: table checksum issues
Date: Tue, 13 May 2008 22:00:35 -0700
Message-ID: <9D39833986E69849A2A8E74C1078B6B353EDCC@orsmsx415.amr.corp.intel.com>
References: <200805140046.10744.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:17313 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751920AbYENFAh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 May 2008 01:00:37 -0400
Content-class: urn:content-classes:message
In-Reply-To: <200805140046.10744.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

It's a configuration option, at least for the main tables in the
RSDT/XSDT. Perhaps not extended to the loaded tables, I will have to
look.


>-----Original Message-----
>From: Len Brown [mailto:lenb@kernel.org]
>Sent: Tuesday, May 13, 2008 9:46 PM
>To: Moore, Robert
>Cc: linux-acpi@vger.kernel.org
>Subject: table checksum issues
>
>Bob,
>I thought you mentioned the other day that
>we never discard a table due to a checksum error.
>But here is an example of us discarding an SSDT
>with a bad checksum (and causing cpufreq not to work).
>
>http://bugzilla.kernel.org/show_bug.cgi?id=10513
>
>Did I mis-understand you?
>Do you think we should not ignore tables w/ bad checksums
>in order to be "bug compatible"?
>
>thanks,
>-Len
