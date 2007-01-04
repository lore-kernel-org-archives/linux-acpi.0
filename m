From: Thorsten Kukuk <kukuk@suse.de>
Subject: Re: /usr/include/*/acpi.h
Date: Thu, 4 Jan 2007 11:49:45 +0100
Message-ID: <20070104104945.GA31430@suse.de>
References: <200701031552.37919.lenb@kernel.org> <1167900335.14297.23.camel@prodigy.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45882 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964780AbXADKtv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Jan 2007 05:49:51 -0500
Content-Disposition: inline
In-Reply-To: <1167900335.14297.23.camel@prodigy.suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, pbaudis@suse.cz

On Thu, Jan 04, Thomas Renninger wrote:

> On Wed, 2007-01-03 at 15:52 -0500, Len Brown wrote:
> > Thomas,
> > Why do the following files appear in OpenSuse 10.2?
> > 
> > $ find /usr/include -name '*acpi*'
> > /usr/include/asm/acpi.h
> > /usr/include/asm-x86_64/acpi.h
> > /usr/include/asm-i386/acpi.h
> > /usr/include/linux/acpi.h
> > /usr/include/linux/pci-acpi.h
> > 
> > They are not present on a Fedora Core 6 system.
> 
> No idea. I never used them and I don't know any user space tool using
> them.

This header files are part of the linux kernel, and thus of course
available in /usr/include/{asm,linux}.

  Thorsten

-- 
Thorsten Kukuk         http://www.suse.de/~kukuk/      kukuk@suse.de
SUSE LINUX Products GmbH       Maxfeldstr. 5       D-90409 Nuernberg
--------------------------------------------------------------------    
Key fingerprint = 8C6B FD92 EE0F 42ED F91A  6A73 6D1A 7F05 2E59 24BB
