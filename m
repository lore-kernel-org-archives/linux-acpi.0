From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] toshiba_acpi: Add full hotkey support
Date: Fri, 6 Mar 2009 09:56:23 +0000
Message-ID: <20090306095623.GA6014@srcf.ucam.org>
References: <20090306003941.GA32403@srcf.ucam.org> <20090306005234.GA32539@srcf.ucam.org> <1236330536.12838.2.camel@hughsie-work.lan> <1236332843.19146.4.camel@petitemort>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755220AbZCFJ4q@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1236332843.19146.4.camel@petitemort>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Silverstone <dsilvers@simtec.co.uk>
Cc: Richard Hughes <hughsient@gmail.com>, linux-acpi@vger.kernel.org, toshiba_acpi@memebeam.org, linux-kernel@vger.kernel.org, len.brown@intel.com
List-Id: linux-acpi@vger.kernel.org

On Fri, Mar 06, 2009 at 09:47:23AM +0000, Daniel Silverstone wrote:

> Have you looked at whether or not this method functions on more than the
> one laptop? Toshiba are notoriously good at getting their own interfaces
> wrong from one laptop to another.

It's present on every Toshiba DSDT I have that has a VALD/VALZ method.

> In addition, the fn+whatever keymaps are often different between 
> laptops, especially for things like the WWW or MAIL buttons. 
> Presumably if the hotkeys fail to activate then the normal 
> /proc/acpi/toshiba/keys thing will continue?

Yes, it'll be as functional as it was previously. They can be remapped 
on machines that have a different keymap.
 
> How will it interact with software stacks like HAL when the lock button
> is pressed?

I don't really understand the question?
-- 
Matthew Garrett | mjg59@srcf.ucam.org
