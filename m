From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: experimental patch for toshiba_acpi
Date: Wed, 25 Feb 2009 15:24:09 +0000
Message-ID: <20090225152409.GA4015@srcf.ucam.org>
References: <E1LcL9o-0003qC-4s@tan.cit.nih.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:45907 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932226AbZBYPYR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Feb 2009 10:24:17 -0500
Content-Disposition: inline
In-Reply-To: <E1LcL9o-0003qC-4s@tan.cit.nih.gov>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Charles@schwieters.org
Cc: linux-acpi@vger.kernel.org, jonathan@buzzard.me.uk, john@neggie.net

On Wed, Feb 25, 2009 at 09:54:43AM -0500, Charles@schwieters.org wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> Hello--
> 
>   Please apply the following patch to toshiba_acpi.c. This patch has
> existed for about five years and is necessary for proper operation of
> some tools on toshiba laptops with toshiba BIOSes (such as toshset
> http://www.schwieters.org/toshset/). 

Why are the toshset features not being added to the toshiba_acpi driver?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
