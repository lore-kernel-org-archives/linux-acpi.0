From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: ACPI source releases updated (20030619)
Date: Fri, 20 Jun 2003 11:30:49 -0700
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A84725A2FE@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi all,

New Linux 2.4 and 2.5 patches are now available from
http://sf.net/projects/acpi. Big thanks to the asus-acpi team, as well
as all the other people who have been tracking down bugs and submitting
fixes lately.

Regards -- Andy

----------------------------------------
19 June 2003.  Summary of changes for version 20030619:

1) Linux:

acpiphp update (Takayoshi Kochi)

Export acpi_disabled for sonypi (Stelian Pop)

Mention acpismp=force in config help

Re-add acpitable.c and acpismp=force. This improves backwards
compatibility and also cleans up the code to a significant
degree.

Add ASUS Value-add driver (Karol Kozimor and Julien Lerouge)

2) ACPI CA Core Subsystem:

Fix To/FromBCD, eliminating the need for an arch-specific
#define.

Do not acquire a semaphore in the S5 shutdown path.

Fix ex_digits_needed for 0. (Takayoshi Kochi)

Fix sleep/stall code reversal. (Andi Kleen)

Revert a change having to do with control method calling
semantics.


-----------------------------
Andrew Grover
Intel Labs / Mobile Architecture
andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
