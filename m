From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Ask devices to powerdown before S3 sleep
Date: Tue, 21 Jan 2003 11:47:37 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030121104737.GC24349@atrey.karlin.mff.cuni.cz>
References: <20030119214642.GA27885@elf.ucw.cz> <Pine.LNX.4.10.10301201714120.16070-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10301201714120.16070-100000-eTnbHd5RJ1QZiu+GbOt07GD2FQJk+8+b@public.gmane.org>
To: Andre Hedrick <andre-QA/0nRrxPJrNLxjTenLetw@public.gmane.org>
Cc: Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> Could you do me just one tiny favor?
> Please consider attempting an error recovery level path, maybe ...
> 
> Every patch I have glanced at has 'panic("blah blah");'
> 
> If you do not have enough hardware to generate an accurate path for
> recovery, then please do not force the kernel into panic.  Would you
> consider failing the request making it jump back to S1 ?  This at least
> allows it crash like a power failure.

If I make it go S1, auto-reboot will not apply etc, and machine will
crash during ENABLE, anyway...
								Pavel
-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
