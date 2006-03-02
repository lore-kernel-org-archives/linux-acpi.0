From: Andi Kleen <ak@suse.de>
Subject: Re: 2.6.16rc5 'found' an extra CPU.
Date: Thu, 2 Mar 2006 04:24:41 +0100
Message-ID: <200603020424.42500.ak@suse.de>
References: <20060301224647.GD1440@redhat.com> <200603020238.31639.ak@suse.de> <20060302031348.GE19755@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns1.suse.de ([195.135.220.2]:25760 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751965AbWCBD06 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Mar 2006 22:26:58 -0500
In-Reply-To: <20060302031348.GE19755@redhat.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>

On Thursday 02 March 2006 04:13, Dave Jones wrote:

> *boggle*, there really are only two single-core CPUs in there,
> with no empty sockets. It's an early stepping of the motherboard
> too that supposedly doesn't support dual-core.  So why these are present
> at all, let alone 'disabled' is a mystery to me.

It's probably for the second cores. Instead of rewriting the tables
dynamically they just change the enable/disable bit.  That's pretty
common actually, often seen on laptops too.

With Quadcores it will get interesting I guess.

If you had to write in 16bit x86 asm you would likely use such
tricks too ;-)
 
> logrotate ate the old logs, so I don't have any old bootlogs
> to grep through, but I'll take your word for it :)
> 
> Why ACPI decides to create 3 processor entries is still odd though.

It should be four.

-Andi
