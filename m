From: Rik van Riel <riel-KCZ47A4bww4P48s/oLjRZg@public.gmane.org>
Subject: Re: Code obfuscation in acpi
Date: Sun, 19 Jan 2003 23:44:10 -0200 (BRST)
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <Pine.LNX.4.50L.0301192333100.18171-100000@imladris.surriel.com>
References: <20030118213134.GA8968@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20030118213134.GA8968-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, 18 Jan 2003, Pavel Machek wrote:

> #define acpi_driver_data(d)     ((d)->driver_data)
>
> ... very nice for obfuscating code ...

This is usually called "abstraction" and allows you to change
the data structures (when needed) without breaking all the code.

You can learn from this.  If swsusp used abstractions it wouldn't
need to have to stick its nose into the code and data structures
from other subsystems and it might even stop breaking every other
release.

cheers,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://guru.conectiva.com/
Current spamtrap:  <a href=mailto:"october-ebMLmSuQjDVBDgjK7y7TUQ@public.gmane.org">october@surriel.com</a>
