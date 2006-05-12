From: "Brown, Len" <len.brown@intel.com>
Subject: RE: git-acpi breakage, sym2
Date: Fri, 12 May 2006 03:26:07 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB66D5565@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-scsi-owner@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-scsi-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org, linux-scsi@vger.kernel.org, Matthew Wilcox <willy@debian.org>
List-Id: linux-acpi@vger.kernel.org

>The latest
>git+ssh://master.kernel.org/pub/scm/linux/kernel/git/lenb/linux
>-acpi-2.6.git#test
>kills my very vanilla P4 box.

hmmm, killed my p4 box too in a similar way.

booting with "acpi=off" made it work,
so I expect the failures after ACPI refuses to start
are due to ACPI and not do to something outside ACPI.

-Len
