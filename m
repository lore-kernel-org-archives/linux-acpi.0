From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH 4/4] ACPI PCI slot detection driver
Date: Wed, 5 Mar 2008 13:34:42 -0700
Message-ID: <20080305203441.GP24386@parisc-linux.org>
References: <20080229002341.GA21420@ldl.fc.hp.com> <20080301144307.GD24386@parisc-linux.org> <20080304054927.GA15566@suse.de> <200803041018.29035.jbarnes@virtuousgeek.org> <20080304193036.GB5534@suse.de> <20080304230937.GD3694@ldl.fc.hp.com> <47CDF339.3060304@jp.fujitsu.com> <20080305202052.GN3694@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from palinux.external.hp.com ([192.25.206.14]:53443 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753720AbYCEUfD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Mar 2008 15:35:03 -0500
Content-Disposition: inline
In-Reply-To: <20080305202052.GN3694@ldl.fc.hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alex Chiang <achiang@hp.com>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Greg KH <gregkh@suse.de>, Jesse Barnes <jbarnes@virtuousgeek.org>, Gary Hade <garyhade@us.ibm.com>, wa

On Wed, Mar 05, 2008 at 01:20:52PM -0700, Alex Chiang wrote:
> So given that it's two versus one, I modified my
> drivers/acpi/pci_slot module to consider Fujitsu machines to be a
> quirk. :)
> 
> Can you please test patches 1 and 2 that I sent out as v8 of my
> series, but replace patch 3 with this patch?

I like this idea.  Nicely done.

-- 
Intel are signing my paycheques ... these opinions are still mine
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
