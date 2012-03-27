From: Peter Stuge <peter@stuge.se>
Subject: Re: [PATCH] ACPI: Implement overriding of arbitrary ACPI tables
	via initrd
Date: Tue, 27 Mar 2012 06:46:43 +0200
Message-ID: <20120327044643.18911.qmail@stuge.se>
References: <1332512984-79664-1-git-send-email-trenn@suse.de> <201203240402.38749.trenn@suse.de> <4F6D50DD.4050306@zytor.com> <201203260245.43177.trenn@suse.de> <4F6FC57D.3050404@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foo.stuge.se ([212.116.89.98]:58309 "HELO foo.stuge.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751621Ab2C0Ex0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 27 Mar 2012 00:53:26 -0400
Content-Disposition: inline
In-Reply-To: <4F6FC57D.3050404@zytor.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas Renninger <trenn@suse.de>, eric.piel@tremplin-utc.net, vojcek@tlen.pl, dsdt@gaugusch.at, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, Lin Ming <ming.m.lin@intel.com>, lenb@kernel.org, robert.moore@intel.com, Al Viro <viro@zeniv.linux.org.uk>

H. Peter Anvin wrote:
> There are a lot of bootloaders, and one of the most commonly used ones
> has a very adversarial relationship with the kernel maintainers.

A couple of less commonly used ones, by or near the coreboot project,
haven't exactly been embraced by kernel maintainers. Dunno if it's
because coreboot doesn't much like ACPI, and thinks that it would
be interesting to explore and innovate firmware on x86.


//Peter
