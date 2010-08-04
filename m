From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Question regarding linux acpi
Date: Wed, 4 Aug 2010 18:02:36 +0100
Message-ID: <20100804170236.GA32073@srcf.ucam.org>
References: <BLU102-W12E18E47E6FFF8C10A7796EBAF0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:58641 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815Ab0HDRCk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Aug 2010 13:02:40 -0400
Content-Disposition: inline
In-Reply-To: <BLU102-W12E18E47E6FFF8C10A7796EBAF0@phx.gbl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Raj Kumar <rajkumar278@hotmail.com>
Cc: linux-acpi@vger.kernel.org

On Wed, Aug 04, 2010 at 09:21:02PM +0530, Raj Kumar wrote:
> 
> 
> Hi,
>  
> I am working on device drivers development. Like normal suspend/resumes, drivers has to implement that.
> The question is what drivers have to implement for getting notifications from ACPI driver for low power modes?

Nothing. The only interaction between most device drivers and ACPI will 
be handled by the bus-level code.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
