From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 0/5][RFC] Physical PCI slot objects
Date: Tue, 13 Nov 2007 16:04:00 -0700
Message-ID: <20071113230400.GP17785@parisc-linux.org>
References: <20071113000853.GA13341@ldl.fc.hp.com> <20071113170129.GA20185@kroah.com> <20071113202154.GA22812@ldl.fc.hp.com> <20071113202632.GA3227@kroah.com> <473A2A61.7030303@hp.com> <20071113225605.GA2589@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:60456 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751963AbXKMXEE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Nov 2007 18:04:04 -0500
Content-Disposition: inline
In-Reply-To: <20071113225605.GA2589@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@suse.de>
Cc: Rick Jones <rick.jones2@hp.com>, Greg KH <greg@kroah.com>, Alex Chiang <achiang@hp.com>, kristen.c.accardi@intel.com, lenb@kernel.org, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, pcihpd-discuss@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Tue, Nov 13, 2007 at 02:56:05PM -0800, Greg KH wrote:
> Why not just use the code in the linux firmware kit that does this
> already today from userspace (thanks to Kristen for pointing this out to
> me on irc.)?

So then we have something that works on ACPI-based machines.  Who will
add support for all the other kinds of firmware and non-firmware based
slots?

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
