From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: acpi resource reservation
Date: Wed, 24 Sep 2008 22:46:45 +0100
Message-ID: <20080924214645.GA2593@srcf.ucam.org>
References: <loom.20080924T193444-211@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:59572 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750875AbYIXVqr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 24 Sep 2008 17:46:47 -0400
Content-Disposition: inline
In-Reply-To: <loom.20080924T193444-211@post.gmane.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: matthieu castet <castet.matthieu@free.fr>
Cc: linux-acpi@vger.kernel.org

On Wed, Sep 24, 2008 at 07:36:03PM +0000, matthieu castet wrote:

> I believe by doing that acpi will avoid that other drivers try to use the same r
> esource. And it will avoid the acpi_check_region hack that need to be added in e
> ach driver instead of relying with the standard
> request_region/request_mem_region mecanism.

It was attempted, but you hit a huge number of cases where ACPI has 
reserved resources that are required by other drivers. We could 
whitelist them, but it doesn't seem to buy a great deal.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
