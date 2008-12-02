From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Huge wakeups number from i1915
Date: Tue, 2 Dec 2008 17:11:25 +0000
Message-ID: <20081202171125.GA20405@srcf.ucam.org>
References: <1228236501.3873.2.camel@hidalgo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:51722 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755740AbYLBRL2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 Dec 2008 12:11:28 -0500
Content-Disposition: inline
In-Reply-To: <1228236501.3873.2.camel@hidalgo>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yves-Alexis Perez <corsac@debian.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, Dec 02, 2008 at 05:48:21PM +0100, Yves-Alexis Perez wrote:
> Hi, I have a problem with 2.6.28-rc6-00209-g6a12141. Not sure if I
> should mail to acpi@ or drm.

The interrupt code on i915 has been heavily rewritten. This sounds like 
an interrupt that isn't being acked correctly, so the drm list is 
probably your best bet.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
