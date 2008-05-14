From: Len Brown <lenb@kernel.org>
Subject: table checksum issues
Date: Wed, 14 May 2008 00:46:10 -0400
Message-ID: <200805140046.10744.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:54044 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751920AbYENEqU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 14 May 2008 00:46:20 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org

Bob,
I thought you mentioned the other day that
we never discard a table due to a checksum error.
But here is an example of us discarding an SSDT
with a bad checksum (and causing cpufreq not to work).

http://bugzilla.kernel.org/show_bug.cgi?id=10513

Did I mis-understand you?
Do you think we should not ignore tables w/ bad checksums
in order to be "bug compatible"?

thanks,
-Len
