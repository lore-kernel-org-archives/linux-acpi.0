From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] ACPI maintainer change
Date: Wed, 17 Sep 2003 10:41:41 -0700
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A8470255EF12@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: torvalds-3NddpPZAyC0@public.gmane.org, Marcelo Tosatti <marcelo-KCZ47A4bww4P48s/oLjRZg@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi Linus and Marcelo,

The following patch updates the maintainer entry for ACPI. Len has
already assumed most of this responsibility, as other projects demand my
attention.

My team will continue to maintain the OS-independent ACPI CA release,
but Len will be responsible for pulling ACPI CA updates into the Linux
release, and the rest of Linux-specific code in general.

This should apply cleanly against 2.6-bk-latest and against
2.4-bk-latest with an offset.

Regards -- Andy

--- 1.164/MAINTAINERS	Fri Sep 12 08:44:53 2003
+++ edited/MAINTAINERS	Wed Sep 17 10:20:28 2003
@@ -169,8 +169,8 @@
 S:	Supported
 
 ACPI
-P:	Andy Grover
-M:	andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
+P:	Len Brown
+M:	len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
 L:	acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
 W:	http://sf.net/projects/acpi/
 S:	Maintained

-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
