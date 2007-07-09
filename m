From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [2.6 patch] the scheduled ACPI_PROCFS removal
Date: Mon, 9 Jul 2007 16:51:51 +0100
Message-ID: <20070709155151.GA27711@srcf.ucam.org>
References: <20070709145755.GD3492@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757512AbXGIPwZ@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070709145755.GD3492@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: Zhang Rui <rui.zhang@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jul 09, 2007 at 04:57:56PM +0200, Adrian Bunk wrote:
> This patch contains the scheduled removal of the ACPI procfs interface.

This was only flagged deprecated in January. Userspace hasn't really 
caught up, so I think removing it now is premature. Given the quantity 
of software that's been written to use the old /proc interface, I don't 
think we're realistically going to be able to remove it in the 
forseeable future.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
