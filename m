From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH v2] acpi: Fix regression where _PPC is not read at boot even when ignore_ppc=0
Date: Thu, 16 Apr 2009 23:45:07 +0100
Message-ID: <20090416224507.GA31984@srcf.ucam.org>
References: <20090415225348.GW8311@plum> <20090416002712.GX8311@plum> <200904161201.13409.trenn@suse.de> <20090416174217.GY8311@plum>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:59175 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754560AbZDPWpT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Apr 2009 18:45:19 -0400
Content-Disposition: inline
In-Reply-To: <20090416174217.GY8311@plum>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: Thomas Renninger <trenn@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, Apr 16, 2009 at 10:42:18AM -0700, Darrick J. Wong wrote:
> On Thu, Apr 16, 2009 at 12:01:11PM +0200, Thomas Renninger wrote:
> > Hi,
> > 
> > be careful, this could break the T60 again.
> 
> So long as T60 owners boot with ignore_ppc=1, they should still be fine.

That's not really an option. It works with Windows. Please figure out 
how to make it work on everything rather than us just repeatedly 
toggling between different sets of broken machines or being forced to 
have a static table of machines.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
