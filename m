From: Dave Jones <davej@redhat.com>
Subject: Re: latest ACPI patch vs 2.6.17-rc4
Date: Fri, 12 May 2006 13:51:47 -0400
Message-ID: <20060512175147.GA20123@redhat.com>
References: <CFF307C98FEABE47A452B27C06B85BB66D5B3C@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:26804 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932166AbWELRvz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 12 May 2006 13:51:55 -0400
Content-Disposition: inline
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB66D5B3C@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: linux-acpi@vger.kernel.org

On Fri, May 12, 2006 at 01:49:14PM -0400, Brown, Len wrote:
 >  
 > > > Note that I removed the acpi_in_resume workaround, so 
 > > > you'll get some oops'
 > > >  during resume, until we replace it with something else.
 > >
 > >Which you intend to do before .17 final I assume?
 > >Seems funny to be ripping something out without a replacement fix.
 > 
 > Hi Dave,
 > the acpi patch flow is that the acpi git tree gets pulled into -mm.
 > 
 > patches that survive -mm get cherry picked  and sent to linus
 > within the 1st two weeks of his release cycle.
 > 
 > (exceptions for critical bug fixes, of course)
 > 
 > So removal of acpi_in_resume is in -mm, but is not in linus,
 > and it will not be pushed to linus until this issue is addressed.
 > I expect this to take place at the start of .18.
 > I don't have any plans to push any significant patches (certainly
 > no clean-up patches) to .17.

Ok, I was just having a panic attack fearing the worst when I pushed
out a .17 update for Fedora users :-)

		Dave

-- 
http://www.codemonkey.org.uk
