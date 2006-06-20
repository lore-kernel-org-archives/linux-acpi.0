From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] Clear abnormal poweroff flag on VIA southbridges, fix resume
Date: Tue, 20 Jun 2006 09:54:29 +0100
Message-ID: <20060620085429.GB27362@srcf.ucam.org>
References: <20060618191421.GA15358@srcf.ucam.org> <20060619230144.155bc938.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:58800 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S965068AbWFTIyc (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jun 2006 04:54:32 -0400
Content-Disposition: inline
In-Reply-To: <20060619230144.155bc938.akpm@osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Mon, Jun 19, 2006 at 11:01:44PM -0700, Andrew Morton wrote:

> Is CONFIG_ACPI the right thing to use here?  As opposed to, say, CONFIG_PM?
> Or CONFIG_ACPI_SLEEP??

I've implemented it using the acpi register handling code, so 
CONFIG_ACPI_something makes sense. I believe that the APM bios will 
handle it itself, but the machine I have doesn't support APM so can't 
check that. CONFIG_ACPI_SLEEP might be a better choice than CONFIG_ACPI, 
yes.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
