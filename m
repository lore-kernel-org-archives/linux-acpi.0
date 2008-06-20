From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] Allow notifications on method execution
Date: Fri, 20 Jun 2008 20:58:40 +0100
Message-ID: <20080620195840.GA16284@srcf.ucam.org>
References: <20080620152227.GA11828@srcf.ucam.org> <20080620193941.GC20498@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:43848 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751576AbYFTT6m (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 15:58:42 -0400
Content-Disposition: inline
In-Reply-To: <20080620193941.GC20498@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, ibm-acpi@hmh.eng.br

On Fri, Jun 20, 2008 at 04:39:41PM -0300, Henrique de Moraes Holschuh wrote:

> With such ACPI notifies, you could have HAL do some of the stuff kernel
> drivers are doing.  So far so good (well, sort of).

That's not what I was thinking. Right now, older Thinkpads need polling 
if you want to get some keyboard events. However, the BIOS seems to 
impleemnt this by calling the ACPI CMOS update methods. Rather than 
polling, we can therefore make it event driven. The events won't go out 
to userspace, they'll just call a callback in the driver which then 
generates input events or uevents or whatever.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
