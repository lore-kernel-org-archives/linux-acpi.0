From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: mem= option for broken bioses
Date: Wed, 26 Feb 2003 23:44:50 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030226224450.GD15455@atrey.karlin.mff.cuni.cz>
References: <F760B14C9561B941B89469F59BA3A8471380D7@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <F760B14C9561B941B89469F59BA3A8471380D7-sBd4vmA9Se4Lll3ZsUKC9FDQ4js95KgL@public.gmane.org>
To: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > From: Pavel Machek [mailto:pavel-+ZI9xUNit7I@public.gmane.org] 
> > I've seen broken bios that did not mark acpi tables in e820
> > tables. This allows user to override it. Please apply,
> 
> OK, looks reasonable. Can you also gen up a patch documenting this in
> kernel-parameters.txt?

You can, assuming you took the patch ;-).

								Pavel

--- clean/Documentation/kernel-parameters.txt	2003-02-11 17:40:28.000000000 +0100
+++ linux/Documentation/kernel-parameters.txt	2003-02-26 23:43:21.000000000 +0100
@@ -516,6 +516,10 @@
 			[KNL,BOOT] Force usage of a specific region of memory
 			Region of memory to be used, from ss to ss+nn.
 
+	mem=nn[KMG]#ss[KMG]
+			[KNL,BOOT,ACPI] Mark specific memory as ACPI data.
+			Region of memory to be used, from ss to ss+nn.
+
 	mem=nopentium	[BUGS=IA-32] Disable usage of 4MB pages for kernel
 			memory.
 
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
