From: Dave Jones <davej-rdkfGonbjUTCLXcRTR1eJlpr/1R2p/CL@public.gmane.org>
Subject: Re: Fix S3 resume when kernel is big
Date: Wed, 20 Nov 2002 15:38:33 +0000
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <20021120153833.GA4344@suse.de>
References: <20021120151136.GA862@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20021120151136.GA862-I/5MKhXcvmPrBKCeMvbIDA@public.gmane.org>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Nov 20, 2002 at 04:11:37PM +0100, Pavel Machek wrote:
 > -	acpi_create_identity_pmd();
 > +	if (!cpu_has_pse) {
 > +		printk(KERN_ERR "You have S3 capable machine without pse? Wow!");
 > +		return 1;
 > +	}

Mobile K6 family never had PSE iirc, and also VIA Cyrix 3's are being
dropped into various laptops.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
