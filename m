From: Dave Jones <davej@redhat.com>
Subject: Re: Options depending on STANDALONE
Date: Thu, 3 Aug 2006 17:01:30 -0400
Message-ID: <20060803210130.GJ16927@redhat.com>
References: <CFF307C98FEABE47A452B27C06B85BB601260CC7@hdsmsx411.amr.corp.intel.com> <20060803205127.GC10935@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:44493 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751388AbWHCVDv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Aug 2006 17:03:51 -0400
Content-Disposition: inline
In-Reply-To: <20060803205127.GC10935@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "Brown, Len" <len.brown@intel.com>, Adrian Bunk <bunk@stusta.de>, Zachary Amsden <zach@vmware.com>, Arjan van de Ven <arjan@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>, Rusty Russell <rusty@rustcorp.com.au>, Jack Lo <jlo@vmware.com>, v4l-dvb-maintainer@linuxtv.org, linux-acpi@vger.kernel.org

On Thu, Aug 03, 2006 at 01:51:27PM -0700, Greg Kroah-Hartman wrote:
 > On Thu, Aug 03, 2006 at 04:49:08PM -0400, Brown, Len wrote:
 > > I've advised SuSE many times that they should not be shipping it,
 > > as it means that their supported OS is running on modified firmware --
 > > which, by definition, they can not support.  Indeed, one could view
 > > this method as couter-productive to the evolution of Linux --
 > > since it is our stated goal to run on the same machines that Windows
 > > runs on -- without requiring customers to modify those machines
 > > to run Linux.
 > 
 > Ok, if it's your position that we should not support this, I'll see what
 > I can do to remove it from our kernel tree...
 > 
 > If there are any other patches that we are carrying that you (or anyone
 > else) feel we should not be, please let me know.

It's somewhat hard to tell when the source rpm's don't match the binaries.
See ftp://ftp.suse.com/pub/projects/kernel/kotd/x86_64/HEAD for example,
and notice the lack of 2.6.18rc3 source, just 2.6.16.  Or am I looking
in the wrong place ? (The other arch's all seem to suffer this curious problem).

		Dave




-- 
http://www.codemonkey.org.uk
