From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Kernel 2.6.38-1-amd64 can not reboot my iMac
Date: Wed, 6 Apr 2011 15:53:19 +0100
Message-ID: <20110406145319.GA8718@srcf.ucam.org>
References: <201104061255.00189.vitalie@webng.md>
 <20110406141426.GA7416@srcf.ucam.org>
 <201104061741.19380.vitalie@webng.md>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:50146 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756124Ab1DFOxX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 6 Apr 2011 10:53:23 -0400
Content-Disposition: inline
In-Reply-To: <201104061741.19380.vitalie@webng.md>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vitalie Lazu <vitalie@webng.md>
Cc: linux-acpi@vger.kernel.org

On Wed, Apr 06, 2011 at 05:41:19PM +0300, Vitalie Lazu wrote:
> Hello Matthew,
> 
> On Miercuri 06 Aprilie 2011, Matthew Garrett wrote:
> > Ought to be fixed in 2.6.40.
> 
> As I see on http://kernel.org/ that version is not released yet. Do you know a 
> patch that can be applied to 2.6.38(Debian Sid) or 2.6.32 (Debian Squeeze)?

Take 6734fe57a07b2dd23ef1ef2ac1f790747e53eefc 
f17d9cbf20c4734c4199caa6dee87047f2f8278f and 
95cf3e12e7f659e536215b37c67d46f3e2ce95cc from upstream, and then apply 
https://patchwork.kernel.org/patch/685182/ on top.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
