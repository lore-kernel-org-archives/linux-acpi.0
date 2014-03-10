From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/1] ACPI: Fix the incorrect behavior of the disabled
 ASPM on Haswell CPU
Date: Mon, 10 Mar 2014 15:45:30 +0000
Message-ID: <20140310154530.GA27699@srcf.ucam.org>
References: <6366A95FCFBB78419E783DDD020ED2ECB2F134@APMAILMBX03.lenovo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:55585 "EHLO
	cavan.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752277AbaCJPph (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Mar 2014 11:45:37 -0400
Content-Disposition: inline
In-Reply-To: <6366A95FCFBB78419E783DDD020ED2ECB2F134@APMAILMBX03.lenovo.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Adrian Huang12 <ahuang12@lenovo.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, Mar 10, 2014 at 09:56:25AM +0000, Adrian Huang12 wrote:
> +		if (status == AE_NOT_FOUND &&

Why limit it to not found? I suspect that we should never be basing our 
ASPM policy on the behaviour of PCI (rather than PCIe) bridges.

I'd recommend changing the patch subject line, too - there's nothing 
Haswell specific about this.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
