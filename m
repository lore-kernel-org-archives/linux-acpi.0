From: "Brown, Len" <len.brown@intel.com>
Subject: RE: [PATCH] acpi: Add lock annotations to acpi_os_acquire_lock andacpi_os_release_lock
Date: Thu, 27 Jul 2006 16:59:21 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB601168989@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751168AbWG0VAM@vger.kernel.org>
Content-class: urn:content-classes:message
Sender: linux-kernel-owner@vger.kernel.org
To: Josh Triplett <josht@us.ibm.com>, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Josh,
if __acquires() and __releases() are always handled in a
Linux kernel build, then we don't need the bit in actypes.h.
Linux specific changes for sparse will never be used
in upstream ACPICA -- Linux can just diverge on these bits,
like we do for other annotations, like asmlinkage.

thanks,
-Len
