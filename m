From: Len Brown <lenb@kernel.org>
Subject: Re: 2.6.25 pci=noacpi
Date: Thu, 1 May 2008 01:10:39 -0400
Message-ID: <200805010110.40709.lenb@kernel.org>
References: <20080425183807.366134771@ldl.fc.hp.com> <20080429000411.ce73230f.akpm@linux-foundation.org> <4816FFF6.5060700@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:33741 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752128AbYEAFL0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 1 May 2008 01:11:26 -0400
In-Reply-To: <4816FFF6.5060700@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Richard <tuxbox.guru@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, Adam M Belay <abelay@mit.edu>, Li Shaohua <shaohua.li@intel.com>, Matthieu Castet <castet.matthieu@free.fr>, Thomas Renninger <trenn@suse.de>, Jaroslav Kysela <perex@perex.cz>

On Tuesday 29 April 2008, Richard wrote:
> Hi there,
> 
> Now I am at a loss.. I cant get any logs from netconsole. With ACPI
> enabled it drops dead just after the kernel hands control to Init. When
> I reboot with acpi disabled there is no trace of the previous boot in
> /var/log/message or kernel logs.
> 
> The network card I have is a Tigon3 and its not initialised before the
> system dies... or so it looks (altho I cant seem to get any netconsole
> working - I suspect pebkac)
> 
> I have tried to find an option where the kernel boot is logged
> explicitly to disk, but I cant seem to find the option. There is so much
> chaff I cant seem to get my brain to find the REAL options list thats up
> to date.
> 
> Any pointers are appreciated

go fishing with this bait:

idle=poll
acpi=noirq

-Len
