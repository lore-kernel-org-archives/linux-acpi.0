From: Stefan Seyfried <seife@suse.de>
Subject: Re: [Suspend-devel] VBETool 1.0
Date: Mon, 5 Mar 2007 08:46:07 +0100
Message-ID: <20070305074607.GD16551@suse.de>
References: <20070303030810.GA14967@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.suse.de ([195.135.220.2]:56176 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752718AbXCEHv2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 Mar 2007 02:51:28 -0500
Content-Disposition: inline
In-Reply-To: <20070303030810.GA14967@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: suspend-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

On Sat, Mar 03, 2007 at 03:08:10AM +0000, Matthew Garrett wrote:
> I've just released version 1.0 of vbetool. The only real difference 
> between this and older versions is that I've moved over to using libx86 
> rather than carrying around an extra copy of lrmi and x86emu. In the 
> process I've fixed a pile of bugs in the x86emu code, so it should work 
> much better on amd64 now.
> 
> Download is at http://www.codon.org.uk/~mjg59/vbetool

Thanks Matthew, this is really appreciated. I will look into integrating
the latest version into s2ram ASAP.
-- 
Stefan Seyfried

"Any ideas, John?"
"Well, surrounding them's out." 
