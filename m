From: Nick Andrew <nick@nick-andrew.net>
Subject: Re: pnpacpi: reduce printk severity for "pnpacpi: exceeded the max	number of ..."
Date: Fri, 18 Apr 2008 01:24:05 +1000
Message-ID: <20080417152405.GB14206@tull.net>
References: <20080417010122.148289106@sous-sol.org> <20080417010359.629397865@sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from yoi5.greathalifaxhome.com ([66.180.172.116]:57304 "HELO
	vps1.tull.net" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with SMTP
	id S1761310AbYDQPbM (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Thu, 17 Apr 2008 11:31:12 -0400
Content-Disposition: inline
In-Reply-To: <20080417010359.629397865@sous-sol.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org, Linux-acpi@vger.kernel.org, Justin Forbes <jmforbes@linuxtx.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, Theodore Ts'o <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>, Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>, Chris Wedgwood <reviews@ml.cw.f00f.org>, Michael Krufky <mkrufky@linuxtv.org>, Chuck Ebbert <cebbert@redhat.com>, Domenico Andreoli <cavokz@gmail.com>, torvalds@linux-foundation.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, Len Brown <lenb@kernel.org>, Len Brown <len.brown@intel.com>

On Wed, Apr 16, 2008 at 06:02:20PM -0700, Chris Wright wrote:
> -		printk(KERN_ERR "pnpacpi: exceeded the max number of IRQ "
> +		printk(KERN_WARNING "pnpacpi: exceeded the max number of IRQ "
>  				"resources: %d \n", PNP_MAX_IRQ);

This is a good time to delete that whitespace before the newline
in this hunk plus the two following. Unless you're going to go to
dynamic memory allocation for these arrays in a month and wipe
out all this code.

Nick.
