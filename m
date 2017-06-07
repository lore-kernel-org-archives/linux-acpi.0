From: "Williams, Dan J" <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 1/5] acpi, nfit: Switch to use new generic UUID API
Date: Wed, 7 Jun 2017 06:25:46 +0000
Message-ID: <1496816744.6978.6.camel@intel.com>
References: <20170605164046.82676-1-andriy.shevchenko@linux.intel.com>
         <20170605164046.82676-2-andriy.shevchenko@linux.intel.com>
         <CAPcyv4h4PY1JBxTB6Powf2y2uiHAZ4QtnZG16bBzdQqsQ2KAYQ@mail.gmail.com>
         <1496682642.22624.23.camel@linux.intel.com> <20170605212250.GA3772@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-7"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:16992 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751435AbdFGGZt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Jun 2017 02:25:49 -0400
In-Reply-To: <20170605212250.GA3772@lst.de>
Content-Language: en-US
Content-ID: <D380A79243714C49A186D7A9199319DD@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "hch@lst.de" <hch@lst.de>, "andriy.shevchenko@linux.intel.com" <andriy.shevchenko@linux.intel.com>
Cc: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "bp@suse.de" <bp@suse.de>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, 2017-06-05 at 23:22 +-0200, Christoph Hellwig wrote:
+AD4- On Mon, Jun 05, 2017 at 08:10:42PM +-0300, Andy Shevchenko wrote:
+AD4- +AD4- 
+AD4- +AD4- I hope Christoph can replace old version of this series with new
+AD4- +AD4- one in
+AD4- +AD4- his uuid branch. URL in cover letter, repeating for your
+AD4- +AD4- convenience:
+AD4- +AD4- 
+AD4- +AD4- +AFs-1+AF0-: git://git.infradead.org/users/hch/uuid.git
+AD4- 
+AD4- Yeah, but I had to drop it again after noticing the guid+AF8-equals bits,
+AD4- and after not fixing up the GUID -+AD4- GUID+AF8-INIT rename.
+AD4- 
+AD4- for-next in the above repo should have the proper base now, and acpi
+AD4- has the ACPI bits for Dan to test.

With one compile fix below the 'acpi' branch works for me. Please feel
free to add:

Tested-by: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-

...to the changes that touch drivers/acpi/nfit/, drivers/nvdimm/, and
tools/testing/nvdimm, but I'm ok if you omit it if the branch is about
to go immutable. Speaking of which, let me know when it does go
immutable because the new libnvdimm enabling for ACPI 6.2 and EFI 2.7
needs some new guid handling code.

Please apply the following or fold it into commit+AKA-c793ed7ccf42 +ACI-ACPI:
Switch to use generic guid+AF8-t in acpi+AF8-evaluate+AF8-dsm()+ACI-

-----+AD4-8-----
>From 18b82755ea839bdc94127aebf0e2f788c19224f3 Mon Sep 17 00:00:00 2001
From: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-
Date: Tue, 6 Jun 2017 22:41:40 -0700
Subject: +AFs-PATCH+AF0- tools/testing/nvdimm: guid+AF8-t compile fix
MIME-Version: 1.0
Content-Type: text/plain+ADs- charset+AD0-UTF-8
Content-Transfer-Encoding: 8bit

Fix up the declaration of the nfit+AF8-test+AF8-evaluate+AF8-dsm+AF8-fn type, to avoid
compile errors of the form:

    tools/testing/nvdimm/test/iomap.c: In function +IBgAXwBf-wrap+AF8-acpi+AF8-evaluate+AF8-dsm+IBk-:
    tools/testing/nvdimm/test/iomap.c:382:35: error: passing argument 2 of
    	+IBg-ops-+AD4-evaluate+AF8-dsm+IBk- from incompatible pointer type

       obj +AD0- ops-+AD4-evaluate+AF8-dsm(handle, guid, rev, func, argv4)+ADs-
                                   +AF4AfgB+AH4-
Signed-off-by: Dan Williams +ADw-dan.j.williams+AEA-intel.com+AD4-
---
 tools/testing/nvdimm/test/nfit+AF8-test.h +AHw- 3 +-+--
 1 file changed, 2 insertions(+-), 1 deletion(-)

diff --git a/tools/testing/nvdimm/test/nfit+AF8-test.h b/tools/testing/nvdimm/test/nfit+AF8-test.h
index f54c0032c6ff..c4e80104165a 100644
--- a/tools/testing/nvdimm/test/nfit+AF8-test.h
+-+-+- b/tools/testing/nvdimm/test/nfit+AF8-test.h
+AEAAQA- -13,6 +-13,7 +AEAAQA-
 +ACM-ifndef +AF8AXw-NFIT+AF8-TEST+AF8-H+AF8AXw-
 +ACM-define +AF8AXw-NFIT+AF8-TEST+AF8-H+AF8AXw-
 +ACM-include +ADw-linux/list.h+AD4-
+-+ACM-include +ADw-linux/uuid.h+AD4-
 +ACM-include +ADw-linux/ioport.h+AD4-
 +ACM-include +ADw-linux/spinlock+AF8-types.h+AD4-
 
+AEAAQA- -36,7 +-37,7 +AEAAQA- typedef void +ACo-acpi+AF8-handle+ADs-
 
 typedef struct nfit+AF8-test+AF8-resource +ACo-(+ACo-nfit+AF8-test+AF8-lookup+AF8-fn)(resource+AF8-size+AF8-t)+ADs-
 typedef union acpi+AF8-object +ACo-(+ACo-nfit+AF8-test+AF8-evaluate+AF8-dsm+AF8-fn)(acpi+AF8-handle handle,
-		const u8 +ACo-uuid, u64 rev, u64 func, union acpi+AF8-object +ACo-argv4)+ADs-
+-		const guid+AF8-t +ACo-guid, u64 rev, u64 func, union acpi+AF8-object +ACo-argv4)+ADs-
 void +AF8AXw-iomem +ACoAXwBf-wrap+AF8-ioremap+AF8-nocache(resource+AF8-size+AF8-t offset,
 		unsigned long size)+ADs-
 void +AF8AXw-wrap+AF8-iounmap(volatile void +AF8AXw-iomem +ACo-addr)+ADs-
-- 
2.9.4