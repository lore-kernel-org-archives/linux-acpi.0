From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: zap_low_mappings -- why?
Date: Sun, 17 Nov 2002 23:28:08 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20021117222808.GA5228@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

For S3 wakeup I need identity mappning. There's
acpi_create_identity_pmd(), but its broken: it only creates 4MB worth
on mappings, and you get really *nasty to debug* crashes if you enable
enough options in your kernel.

Question is how to fix it nicely.

I thought about killing zap_low_mappings and then reusing
swapper_pg_dir for that purpose. Is there some problem with that?

								Pavel
-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
