From: Matthew Garrett <mjg@redhat.com>
Subject: Re: [PATCH] ACPI: make some IO ports off-limits to AML
Date: Wed, 4 Feb 2009 06:15:05 +0000
Message-ID: <20090204061505.GD28321@srcf.ucam.org>
References: <alpine.LFD.2.00.0902032258080.5607@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:42910 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbZBDGPJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 4 Feb 2009 01:15:09 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0902032258080.5607@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Tue, Feb 03, 2009 at 10:59:43PM -0500, Len Brown wrote:

> Start using this interface to prevent AML from accessing
> some well known IO addresses that the OS "owns".

It might be nice to extend this to cover the other ports listed at 
http://www.microsoft.com/whdc/archive/BIOSAML.mspx if (and only if) the 
firmware requested _OSI("Windows 2001") or later.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
