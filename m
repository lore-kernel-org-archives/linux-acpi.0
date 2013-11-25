From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH] acpi, add region addresses to conflict output
Date: Mon, 25 Nov 2013 17:07:33 +0000
Message-ID: <20131125170733.GA6329@srcf.ucam.org>
References: <1385398867-10238-1-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:56267 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755257Ab3KYRHh (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 25 Nov 2013 12:07:37 -0500
Content-Disposition: inline
In-Reply-To: <1385398867-10238-1-git-send-email-prarit@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-acpi@vger.kernel.org, Myron Stowe <mstowe@redhat.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Lin Ming <ming.m.lin@intel.com>

On Mon, Nov 25, 2013 at 12:01:07PM -0500, Prarit Bhargava wrote:

> +		 * Check if the requested Address/Length overlaps this
> +		 * address_range.
>  		 * Four cases to consider:

Can you either merge these lines or add a blank line between them? It 
looks a bit awkward as is. Otherwise, looks good.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
