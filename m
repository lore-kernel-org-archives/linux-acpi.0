From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC] Allow notifications on method execution
Date: Fri, 20 Jun 2008 23:13:08 +0100
Message-ID: <20080620221308.GB18980@srcf.ucam.org>
References: <20080620152227.GA11828@srcf.ucam.org> <20080620193941.GC20498@khazad-dum.debian.net> <20080620195840.GA16284@srcf.ucam.org> <20080620220120.GB3417@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:48735 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752073AbYFTWNK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 18:13:10 -0400
Content-Disposition: inline
In-Reply-To: <20080620220120.GB3417@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, ibm-acpi@hmh.eng.br

On Fri, Jun 20, 2008 at 07:01:20PM -0300, Henrique de Moraes Holschuh wrote:

> Sounds like a good idea, but in order to do that, we just need to let
> kernel drivers hook to GPE handlers somehow.  I'd be quite happy to add
> support for it to thinkpad-acpi.

I expected that the method name would probably be more consistent, 
whereas the GPE number might change in a way that was difficult to hook. 
There's only three CMOS update methods in the range of Thinkpad BIOSes, 
IIRC?

> I thought your patch did a lot more than this.  If I am wrong about it,
> I apologise.

No problem :)

-- 
Matthew Garrett | mjg59@srcf.ucam.org
