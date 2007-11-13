From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: [RFC] EC registers - Adding sysfs interface?
Date: Tue, 13 Nov 2007 19:03:02 +0000
Message-ID: <200711131903.03018.carlos@strangeworlds.co.uk>
References: <200711131724.31868.carlos@strangeworlds.co.uk> <200711131849.56964.carlos@strangeworlds.co.uk> <4739F2FB.9080800@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:56982 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762471AbXKMTDd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 13 Nov 2007 14:03:33 -0500
In-Reply-To: <4739F2FB.9080800@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: linux-acpi@vger.kernel.org

Alexey,

> How about character /dev/ec0?

Yes, that would be fine.

On Tuesday 13 November 2007 18:54:51 Alexey Starikovskiy wrote:
> What is the benefit of having acer_acpi in userspace, rather than one more
> *-laptop in /devices/misc?

A debate of "would it be easier for me to maintain an in kernel driver (if/ 
when I can get it upstream) or a userspace application". At the moment, the 
idea of a full blown userspace application is just something I'm toying with 
in my head whilst working on WMI userspace.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
