From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: new pmtools available for testing
Date: Tue, 21 Nov 2006 21:24:25 +0300
Message-ID: <45634459.8040404@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:17297 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S1031247AbWKUSYh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Nov 2006 13:24:37 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

Hi,

acpixtract perl-script is being replaced by C xtract utility. Please test.
Advances are:
    - Perl not required :)
    - no 64k output limit of perl-script
    - --list option shows all tables in the file
    - unified interface with acpidump
    - faster(?)

Thanks in advance,
    Alex.
