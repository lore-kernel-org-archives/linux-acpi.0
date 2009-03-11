From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [RFC PATCH 3/5] ACPI video: support _BCL packages that don't export brightness levels when machine is on AC/Battery
Date: Wed, 11 Mar 2009 01:18:45 +0000
Message-ID: <20090311011845.GA13472@srcf.ucam.org>
References: <1236672209.2820.121.camel@rzhang-dt> <20090310170639.GA2527@srcf.ucam.org> <1236733766.2820.129.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:43076 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753836AbZCKBSv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Mar 2009 21:18:51 -0400
Content-Disposition: inline
In-Reply-To: <1236733766.2820.129.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Thomas Renninger <trenn@suse.de>

On Wed, Mar 11, 2009 at 09:09:26AM +0800, Zhang Rui wrote:

> +		ACPI_ERROR((AE_INFO, "Two many duplicates in _BCL package\n"));
                                      ^^^
Too, not Two :)

-- 
Matthew Garrett | mjg59@srcf.ucam.org
