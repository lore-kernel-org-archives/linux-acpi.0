From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [2.5 patch] remove unused reset_videobios_after_s3
Date: Sun, 8 Jun 2003 20:18:19 +0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030608181819.GB9182@elf.ucw.cz>
References: <20030608104737.GA16164@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030608104737.GA16164-cg1h10c7RbKzQB+pC5nmwQ@public.gmane.org>
To: Adrian Bunk <bunk-cg1h10c7RbKzQB+pC5nmwQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, trivial-8n+1lVoiYb80n/F98K4Iww@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> reset_videobios_after_s3 is used nowhere inside 2.5.70-mm6. Unless there 
> are plans to use it in the near future I suggest the patch below to 
> remove it.
> 
> I've tested the compilation with 2.5.70-mm6.

Please keep it. I know there are machines that need it (I have one at
home, but that does not seem to have valid DMI tables), but I do not
yet have their DMI strings.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
