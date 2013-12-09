From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] ACPI / blacklist: disable Win8 mode for ThinkPad X201
 and Latitude E6230
Date: Mon, 9 Dec 2013 16:58:17 +0000
Message-ID: <20131209165817.GA30717@srcf.ucam.org>
References: <52A15F72.1050408@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:44729 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933930Ab3LIQ60 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 9 Dec 2013 11:58:26 -0500
Content-Disposition: inline
In-Reply-To: <52A15F72.1050408@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Jeffery To <jeffery.to@gmail.com>, Wouter Depypere <wouter.depypere@ugent.be>

On Fri, Dec 06, 2013 at 01:24:02PM +0800, Aaron Lu wrote:
>  	/*
> +	 * The bluetooth functionality is unconditionally enabled
> +	 * after a S3 cycle on Thinkpad X201 under Win8 mode.
> +	 */

Can you describe this in a little more detail? Does the thinkpad-acpi 
rfkill code just not work?

> +	/*
> +	 * The hardware switch for enable/disable wifi on
> +	 * Dell Latitude E6230 is broken under Win8 mode.
> +	 */

Can you define "broken"? Do you see the same behaviour under Windows 8?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
