From: aris-YqEmrenMroyQb786VAuzj9i2O/JbrIOy@public.gmane.org (aris)
Subject: Re: 2.5.50: echo > /proc/acpi/sleep b0rken
Date: Sat, 30 Nov 2002 20:19:42 -0200
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20021130221942.GA5038@cathedrallabs.org>
References: <20021130194934.GA141@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021130194934.GA141-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> I believe this is needed, otherwise echo > /proc/acpi/sleep does not
> work. I'm not 200% sure this is correct fix, through, and it
> definitely needs to be fixed at *way* more places.
my mistake. i'll fix it and submit asap

-- 
aris
