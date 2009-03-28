From: Len Brown <lenb@kernel.org>
Subject: Re: [RESEND PATCH 0/6] ACPI video: cleanups and fixes for the recent
 buggy _BQC/_BCL/_BCM BIOSes
Date: Fri, 27 Mar 2009 22:02:19 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903272157490.26419@localhost.localdomain>
References: <1237364826.3826.56.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_HtWyjGGppwHIE8REkvwseA)"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173019pub.verizon.net ([206.46.173.19]:59373 "EHLO
	vms173019pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756880AbZC1CC0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Mar 2009 22:02:26 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173019.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH70055T1NYEXEZ@vms173019.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 21:02:23 -0500 (CDT)
In-reply-to: <1237364826.3826.56.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Thomas Renninger <trenn@suse.de>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_HtWyjGGppwHIE8REkvwseA)
Content-type: TEXT/PLAIN; charset=UTF-8
Content-transfer-encoding: 8BIT

On Wed, 18 Mar 2009, Zhang Rui wrote:

> ﻿Hi, all,
> 
> here is the patch set I made recently, including some cleanups and fixes
> for the Thinkpad/Asus laptops with buggy _BQC/_BCL/_BCM implementation.
> 
> The first two patches checks if ACPI video driver fails to set/get the
> current brightness level, which is not done before.
> 
> patch 3/4/5/6 are used to fix four different problems.
> 
> 1. the brightness levels when machine is on AC/Battery are not exported
>    by _BCL.
> 2. The supported brightness levels are reversed in the _BCL method.
> 3. Index values are used in _BQC/_BCL/_BCM method.
> 4. _BCQ method is implemented instead of _BQC
> 
> Any comments are welcome.

I've replaced the previous version of this series in the test tree
with this batch, and it builds.  I'll assume this is the version
you want for 2.6.30, unless I hear otherwise.

For future reference...
Please do not send patches with a "Subject:" at the start
of the body of the  message unless you really want to override
that in the e-mail Subject line...

Also, whatever you did to send 2/6, please don't do that again,
because it was the entire patch series, not just 2/6.

git format-patch; git send-email
generally get this right.
I think there are some scripts to send a quilt if you use quilt.
In general, avoid sending a patch series by hand.

thanks,
Len Brown, Intel Open Source Technology Center


--Boundary_(ID_HtWyjGGppwHIE8REkvwseA)--
