From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] ACPI: dock: Don't eval _STA on every show_docked sysfs
 read
Date: Fri, 6 Feb 2009 13:33:54 -0800
Message-ID: <20090206133354.fc1a29f2.akpm@linux-foundation.org>
References: <1232450304.5286.4.camel@homac.suse.de>
	<20090127130455.2c1b0cd4.akpm@linux-foundation.org>
	<1233938876.12590.4.camel@homac.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:39476 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752703AbZBFVeX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 6 Feb 2009 16:34:23 -0500
In-Reply-To: <1233938876.12590.4.camel@homac.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: hmacht@suse.de
Cc: linux-acpi@vger.kernel.org, stable@kernel.org, lenb@kernel.org, Li@suse.de, shaohua.li@intel.com, marvin@mydatex.cz

On Fri, 06 Feb 2009 17:47:56 +0100
Holger Macht <hmacht@suse.de> wrote:

> Hi,
> 
> sorry for the delay...
> 
> On Tue, 2009-01-27 at 13:04 -0800, Andrew Morton wrote:
> > On Tue, 20 Jan 2009 12:18:24 +0100
> > Holger Macht <hmacht@suse.de> wrote:
> > 
> > > Cc: stable@kernel.org
> > 
> > The patch applied OK to 2.6.28 but not to any earlier kernel.  If we
> > decide that it should be backported to 2.6.27 or earlier, a new patch
> > might be needed for that.
> 
> Patch that applies to stable kernel from today is attached.
> 

ok, thanks.

But this won't be going into -stable until the mainline version gets
merged.

Len, where are we up to with that?

Thanks.
