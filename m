From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: ACPI releases updated (20021212)
Date: Fri, 13 Dec 2002 15:11:02 -0800
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A59C@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org
Cc: kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi all,

New versions of the ACPI patches are available from
http://sf.net/projects/acpi . Non-Linux source drops will not be available
until Dec 20, due to web publishing issues. (I can email it on request, if
you can't wait.)

(If you already downloaded the patch against 2.5.51, you may want to re-get
it. A small fix for writes to the /proc interface has been slipstreamed.)

Regards -- Andy

----------------------------------------
12 December 2002.  Summary of changes for version 20021212.

1) ACPI CA Core Subsystem:

Fixed a problem where the creation of a zero-length AML Buffer
would cause a fault.

Fixed a problem where a Buffer object that pointed to a static
AML buffer (in an ACPI table) could inadvertently be deleted,
causing memory corruption.

Fixed a problem where a user buffer (passed in to the external
ACPI CA interfaces) could be overwritten if the buffer was too
small to complete the operation, causing memory corruption.

Fixed a problem in the Buffer-to-String conversion code where
a string of length one was always returned, regardless of the
size of the input Buffer object.

Removed the NATIVE_CHAR data type across the entire source due
to lack of need and lack of consistent use.

-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
