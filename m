From: Stephen Hemminger <shemminger-3NddpPZAyC0@public.gmane.org>
Subject: Re: ACPI patches updated (20021111)
Date: 13 Nov 2002 13:33:03 -0800
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <1037223183.16635.59.camel@dell_ss3.pdx.osdl.net>
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A4F9@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A4F9-OU+JdkIUtvd9zuciVAfUoVDQ4js95KgL@public.gmane.org>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org, Kernel List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Will this fix problems with IRQ routing.
On our SMP test machines, ACPI has to be disabled otherwise the SCSI
disk controllers don't work.

This is a major pain, and ACPI should be default off until it gets
fixed.
