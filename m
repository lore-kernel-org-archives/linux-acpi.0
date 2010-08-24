From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Add intel drm blacklist to intel_opregion_present
	detect
Date: Tue, 24 Aug 2010 15:22:19 +0100
Message-ID: <20100824142219.GB16200@srcf.ucam.org>
References: <4C7426DB020000230001F3A8@novprvlin0050.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4C7426DB020000230001F3A8@novprvlin0050.provo.novell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joey Lee <jlee@novell.com>
Cc: trenn@suse.de, gregkh@suse.de, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Dennis.Jansen@web.de
List-Id: linux-acpi@vger.kernel.org

Erm. Sorry about that - I just realised that there's actually a fairly 
significant problem with it :) Right now you'll perform the register 
call unconditionally on module load. You need to make sure that there's 
actually Poulsbo hardware in the system, either by registering as a 
proper PCI driver and calling acpi_video_register in your probe function 
(and unregister in your remove function) or walking the PCI device list 
looking for a psb device.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
