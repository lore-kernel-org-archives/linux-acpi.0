From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Resume failing in get_cmos_time()
Date: Mon, 19 Jul 2004 13:22:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1090239727.7459.10.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S265051AbUGSMWE@vger.kernel.org>
To: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On around 20% of ACPI resume attempts, the resume hangs during
time_resume(). I've traced this down to the get_cmos_time() call - a
printk before that appears, one afterwards doesn't. The rest of the
time, resume works correctly. Interestingly, this only seems to happen
if I use the patch from http://bugzilla.kernel.org/show_bug.cgi?id=2643
or a similar one for the IO-APIC. Does anyone have any idea why this
might result in this sort of failure mode? I'm considering just removing
the call for now and resetting the clock from userspace.
-- 
Matthew Garrett | mjg59@srcf.ucam.org
