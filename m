From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Missing ACPI interrupts/events after S3 suspend
Date: Sun, 26 Oct 2003 13:35:10 +0000
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20031026133510.GA19227@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Using 2.6.0-test9 if I do an S3 suspend, then when the machine comes 
back pressing the power button generates no ACPI events or interrupts. 
Other events (sleep button, lid switch, plugging/unplugging AC adapter) 
still work.
-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org
