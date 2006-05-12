From: "Brown, Len" <len.brown@intel.com>
Subject: RE: latest ACPI patch vs 2.6.17-rc4
Date: Fri, 12 May 2006 13:49:14 -0400
Message-ID: <CFF307C98FEABE47A452B27C06B85BB66D5B3C@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:39259 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S932129AbWELRtn convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 May 2006 13:49:43 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: linux-acpi@vger.kernel.org

 
> > Note that I removed the acpi_in_resume workaround, so 
> > you'll get some oops'
> >  during resume, until we replace it with something else.
>
>Which you intend to do before .17 final I assume?
>Seems funny to be ripping something out without a replacement fix.

Hi Dave,
the acpi patch flow is that the acpi git tree gets pulled into -mm.

patches that survive -mm get cherry picked  and sent to linus
within the 1st two weeks of his release cycle.

(exceptions for critical bug fixes, of course)

So removal of acpi_in_resume is in -mm, but is not in linus,
and it will not be pushed to linus until this issue is addressed.
I expect this to take place at the start of .18.
I don't have any plans to push any significant patches (certainly
no clean-up patches) to .17.


-Len
