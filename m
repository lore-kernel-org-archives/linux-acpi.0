From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: ACPI patches updated (20030714)
Date: Tue, 15 Jul 2003 09:53:02 -0700
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A8470255EE8E@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: ACPI-Devel mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi all,

The ACPI patches against 2.4 and 2.5 have been updated, and are now
available on http://sf.net/projects/acpi . Thanks to the acceptance of
the ACPI patch in 2.4, they are now both very small.

Regards -- Andy

----------------------------------------
14 July 2003.  Summary of changes for version 20030619:

1) ACPI CA Core Subsystem:

Parse SSDTs in order discovered, as opposed to reverse order
(Hrvoje Habjanic)

Fixes from FreeBSD and NetBSD. (Frank van der Linden, Thomas
Klausner, Nate Lawson)


2) Linux:

Dynamically allocate SDT list (suggested by Andi Kleen)

proc function return value cleanups (Andi Kleen)

Correctly handle NMI watchdog during long stalls (Andrew Morton)

Make it so acpismp=force works (reported by Andrew Morton)

-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
