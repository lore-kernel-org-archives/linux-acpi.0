From: Thomas Renninger <trenn@suse.de>
Subject: Re: /usr/include/*/acpi.h
Date: Thu, 04 Jan 2007 09:45:35 +0100
Message-ID: <1167900335.14297.23.camel@prodigy.suse.de>
References: <200701031552.37919.lenb@kernel.org>
Reply-To: trenn@suse.de
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39420 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932336AbXADJD3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Jan 2007 04:03:29 -0500
In-Reply-To: <200701031552.37919.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: kukuk@suse.de, linux-acpi@vger.kernel.org, pbaudis@suse.cz

On Wed, 2007-01-03 at 15:52 -0500, Len Brown wrote:
> Thomas,
> Why do the following files appear in OpenSuse 10.2?
> 
> $ find /usr/include -name '*acpi*'
> /usr/include/asm/acpi.h
> /usr/include/asm-x86_64/acpi.h
> /usr/include/asm-i386/acpi.h
> /usr/include/linux/acpi.h
> /usr/include/linux/pci-acpi.h
> 
> They are not present on a Fedora Core 6 system.

No idea. I never used them and I don't know any user space tool using
them.
They were already present in SLES9 or even earlier.
Don't know how to determine whether any of them gets used by any
application, but I doubt they are used.
I had a quick look at the glibc sources, I couldn't find anything
explicitly adding acpi kernel headers, they may get added by accident
through some regex.
What is the reason you ask this for, do you get name clashes with other
programs, should they get reverted for cleanup reasons?

    Thomas

