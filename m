From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Code obfuscation in acpi
Date: Sat, 18 Jan 2003 23:39:59 +0100
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20030118223958.GC21720@atrey.karlin.mff.cuni.cz>
References: <20030118213134.GA8968@elf.ucw.cz> <20030118223210.GA31860@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030118223210.GA31860-bB7D8CACdjo@public.gmane.org>
To: Jeff Garzik <jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > #define acpi_driver_data(d)     ((d)->driver_data)
> > 
> > ... very nice for obfuscating code ...
> 
> sysfs-based buses use <foo>_{get,set}_drvdata, which looks exactly the
> same as this here.

I think such wrappers are really bad idea, see for example this: I
thought "what kind of cleverness is going on here,", and it was very
simple in fact.

        else {
                entry->proc_fops = &acpi_thermal_state_fops;
                entry->data = acpi_driver_data(device);
        }


-- 
Casualities in World Trade Center: ~3k dead inside the building,
cryptography in U.S.A. and free speech in Czech Republic.
