From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: PaceBlade broken acpi/memory map
Date: Thu, 20 Feb 2003 18:21:45 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030220172144.GA15016@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

I have PaceBlade here, and its memory map is wrong, which leads to
ACPI refusing to load. [It does not mention "ACPI data" in the memory
map at all!]

And when I work around that, it crashes in processing _STA/_INI
methods. [Anyone from PaceBlade listening?]

								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
