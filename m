From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.21-rc1: framebuffer/console boot failure
Date: Sat, 24 Feb 2007 03:09:50 -0800
Message-ID: <20070224030950.074f88d4.akpm@linux-foundation.org>
References: <35472.86.7.220.119.1172237750.squirrel@wmbeta.mxes.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:57791 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750971AbXBXLNX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 24 Feb 2007 06:13:23 -0500
In-Reply-To: <35472.86.7.220.119.1172237750.squirrel@wmbeta.mxes.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew <andrew@nelless.net>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

> On Fri, 23 Feb 2007 13:35:50 -0000 (GMT) "Andrew" <andrew@nelless.net> wrote:
> Hi,
> 
> 2.6.21-rc1 fails to boot on my machine. As soon as I switch
> from grub the screen turns and remains black with no sign
> of Tux or any output.
> 
> I've run a git-bisect between 2.6.20 (which works fine) and
> 2.6.21-rc1 and found the first bad commit to be
> #59b8175c771040afcd4ad67022b0cc80c216b866 which seems bizarre
> to me since this is a mostly an ARM commit.
> 
> I haven't tried to revert this commit because frankly I don't
> know where to go from there with a multi-parent commit.
> 
> I'm running on on a Asus A8N-VM CSM motherboard with a single
> core AMD64 processor, with a nVidia GPU in the PCI-ex slot
> using the standard VESA frame buffer driver.
> 
> Relevant config's can be found here:
> http://homepage.ntlworld.com/anelless/linux/2.6.21-rc1/
> 

and, later,

> I have just discovered 2.6.21-rc1 boots with
> pci=noacpi ...

Presumably this regression was caused by the ACPI merge.  Are you able to
capture the dmesg output from the 2.6.20-rc1 boot?  netconsole might be
useful here, thanks.

(You get added to the post-2.6.20 regression list, so you'll be hearing
from us quite a lot for the next month.  Sorry ;))
