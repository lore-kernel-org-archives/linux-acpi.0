From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [ACPI] RE: One-line patch for systems with ACPI enabled but incomplete tree
Date: Wed, 31 Aug 2005 15:04:24 -0700
Message-ID: <971FCB6690CD0E4898387DBF7552B90E029620CC@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ia64-owner@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-ia64-owner@vger.kernel.org
To: "Magenheimer, Dan (HP Labs Fort Collins)" <dan.magenheimer@hp.com>, "Brown, Len" <len.brown@intel.com>
Cc: acpi-devel@lists.sourceforge.net, hch@infradead.org, linux-ia64@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

> there is no check in the kernel code.  However, it still seems
> like a bug to me as everything else works if the FADT pointer
> is zero (with the above one line patch).
[Moore, Robert] 

This is some legacy overkill in the code that we should remove or
change.  Once the ACPI tables are loaded, the FADT pointer should be
always valid.  There are some inconsistencies in detecting and handling
the error case where external ACPI CA interfaces are called before the
tables are loaded -- I believe that is the real purpose of the checks
for NULL table pointers scattered throughout.

Bob

