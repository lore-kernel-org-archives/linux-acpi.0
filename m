From: Jordan Crouse <jordan.crouse@amd.com>
Subject: Re: WDRT based watchdog timer
Date: Thu, 16 Oct 2008 16:40:57 -0600
Message-ID: <20081016224057.GC21476@cosmic.amd.com>
References: <20080926232752.GA6061@cosmic.amd.com> <alpine.LFD.1.10.0810081552220.3041@localhost.localdomain> <20081008204422.GA2932@cosmic.amd.com> <20081014204034.GF30246@infomag.infomag.iguana.be> <20081015133350.GA6822@infomag.infomag.iguana.be> <alpine.LFD.1.10.0810161821050.3026@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outbound-wa4.frontbridge.com ([216.32.181.16]:32758 "EHLO
	WA4EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930AbYJPWjf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 16 Oct 2008 18:39:35 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0810161821050.3026@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Wim Van Sebroeck <wim@iguana.be>, linux-acpi@vger.kernel.org, Marc Brooker <mbrooker@rrsg.ee.uct.ac.za>

On 16/10/08 18:23 -0400, Len Brown wrote:
> Jordan,
> just to clarify, Wim is in charge of the watchdog drivers,
> and so this one would go upstream via Wim.

Of course. 

> Re: ACPI-ness, I'm find with Wim's edited version,
> except for this remaining bit:
> 
> +L:     linux-acpi@vger.kernel.org
> +W:     http://www.lesswatts.org/projects/acpi/
> 
> otherwise...
> Acked-by: Len Brown <len.brown@intel.com>

Yes, I'm happy with the final version.  Thank you very much Wim and
Len for your comments.  Now, we just need to find some testers :)

Jordan

-- 
Jordan Crouse
Systems Software Development Engineer 
Advanced Micro Devices, Inc.

