From: Alan Cox <alan-qBU/x9rampVanCEyBjwyrvXRex20P6io@public.gmane.org>
Subject: Re: Fix S3 resume when kernel is big
Date: 20 Nov 2002 16:17:35 +0000
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <1037809055.3702.43.camel@irongate.swansea.linux.org.uk>
References: <20021120151136.GA862@elf.ucw.cz>
	<20021120153833.GA4344@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20021120153833.GA4344-l3A5Bk7waGM@public.gmane.org>
To: Dave Jones <davej-rdkfGonbjUTCLXcRTR1eJlpr/1R2p/CL@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew Grover <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 2002-11-20 at 15:38, Dave Jones wrote:
> On Wed, Nov 20, 2002 at 04:11:37PM +0100, Pavel Machek wrote:
>  > -	acpi_create_identity_pmd();
>  > +	if (!cpu_has_pse) {
>  > +		printk(KERN_ERR "You have S3 capable machine without pse? Wow!");
>  > +		return 1;
>  > +	}
> 
> Mobile K6 family never had PSE iirc, and also VIA Cyrix 3's are being
> dropped into various laptops.

Plenty of desktop machines have S3 
