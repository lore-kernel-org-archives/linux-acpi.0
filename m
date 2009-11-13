From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: 64-bit DMA problems with BCM4312 using b43
Date: Fri, 13 Nov 2009 20:11:12 +0000
Message-ID: <20091113201112.GA5540@srcf.ucam.org>
References: <4AFD958E.1000303@lwfinger.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:44421 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757184AbZKMULQ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Nov 2009 15:11:16 -0500
Content-Disposition: inline
In-Reply-To: <4AFD958E.1000303@lwfinger.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Linux ACPI <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, bcm43xx devel <Bcm43xx-dev@lists.berlios.de>, Michael Buesch <mb@bu3sch.de>, =?iso-8859-1?Q?G=E1bor?= Stefanik <netrolller.3d@gmail.com>

On Fri, Nov 13, 2009 at 11:21:18AM -0600, Larry Finger wrote:

> I do not know enough about either the ACPI or DMA code to begin debugging in
> either of those regions. Any suggestions on debugging strategies, or links to
> similar problems would be appreciated.

Could the hardware be highly sensitive to DMA latencies? Take a look at 
the pm_qos code in ipw2100.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
