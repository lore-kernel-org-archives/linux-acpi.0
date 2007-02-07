From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [patch 07/13] sony acpi driver
Date: Wed, 7 Feb 2007 23:41:15 +0000
Message-ID: <20070207234115.GA29272@srcf.ucam.org>
References: <200702060010.l160AFkf003738@shell0.pdx.osdl.net> <200702071601.11213.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([217.147.92.49]:37325 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161472AbXBGXlt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 7 Feb 2007 18:41:49 -0500
Content-Disposition: inline
In-Reply-To: <200702071601.11213.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: akpm@linux-foundation.org, linux-acpi@vger.kernel.org, stelian@popies.net, bcollins@ubuntu.com, bjorn.helgaas@hp.com

On Wed, Feb 07, 2007 at 04:01:10PM -0500, Len Brown wrote:
> NAK
> Andrew, please remove this patch from -mm, as it has been included
> in the acpi-test tree in a different file, sony-laptop.c

Yes, the version in the (in this case, somewhat misnamed...) acpi-test 
tree is more sensible. The new code is much better integrated with 
generic interfaces.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
