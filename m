From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: serial port discovery on a motion computing tablet
Date: Thu, 15 Mar 2007 00:09:46 +0000
Message-ID: <20070315000946.GA13068@srcf.ucam.org>
References: <45F7688B.8000101@elevating.com> <20070314134323.GC1467@srcf.ucam.org> <45F806B1.3060807@elevating.com> <20070314143534.GA2655@srcf.ucam.org> <45F80EAA.6010808@elevating.com> <20070314151441.GA3396@srcf.ucam.org> <45F817E2.1020900@elevating.com> <45F84103.8050803@elevating.com> <20070314232550.GA11970@srcf.ucam.org> <45F88BE3.8060702@elevating.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:54371 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422788AbXCOAhk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Mar 2007 20:37:40 -0400
Content-Disposition: inline
In-Reply-To: <45F88BE3.8060702@elevating.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bret Hughes <bhughes@elevating.com>
Cc: linux-acpi@vger.kernel.org

It would be possible to do it in the kernel, but I think that would 
effectively require a new serial driver. It's probably easier to do it 
in userspace, either in an X driver or gpm or whatever's being used to 
accept input. Beyond that, I'm afraid I'm not sure what the problem is 
right now!

-- 
Matthew Garrett | mjg59@srcf.ucam.org
