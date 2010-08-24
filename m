From: Greg KH <gregkh@suse.de>
Subject: Re: [PATCH] Add intel drm blacklist to intel_opregion_present
	detect
Date: Tue, 24 Aug 2010 07:51:30 -0700
Message-ID: <20100824145130.GA26232@suse.de>
References: <4C7426DB020000230001F3A8@novprvlin0050.provo.novell.com> <20100824142219.GB16200@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20100824142219.GB16200@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Joey Lee <jlee@novell.com>, trenn@suse.de, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Dennis.Jansen@web.de
List-Id: linux-acpi@vger.kernel.org

On Tue, Aug 24, 2010 at 03:22:19PM +0100, Matthew Garrett wrote:
> Erm. Sorry about that - I just realised that there's actually a fairly 
> significant problem with it :) Right now you'll perform the register 
> call unconditionally on module load. You need to make sure that there's 
> actually Poulsbo hardware in the system, either by registering as a 
> proper PCI driver and calling acpi_video_register in your probe function 
> (and unregister in your remove function) or walking the PCI device list 
> looking for a psb device.

Ick, don't walk the pci device list, just register a "real" pci device
and do it that way, it's much simpler and plays nicer with the driver
model and the rest of the kernel.

thanks,

greg k-h
