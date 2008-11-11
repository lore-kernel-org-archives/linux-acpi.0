From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: ACPI crash on lid close - SMP race?
Date: Tue, 11 Nov 2008 01:33:59 +0000
Message-ID: <20081111013359.GA11364@srcf.ucam.org>
References: <20081110161105.GA2041@srcf.ucam.org> <1226366834.15014.60.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([93.93.128.6]:35887 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753504AbYKKBeE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 10 Nov 2008 20:34:04 -0500
Content-Disposition: inline
In-Reply-To: <1226366834.15014.60.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, Nov 11, 2008 at 09:27:14AM +0800, Zhang Rui wrote:
> well, there is a bug report for this problem:
> http://bugzilla.kernel.org/show_bug.cgi?id=11259

I'll give the noirqbalance case a go.

> and there are some bug reports for a similar problem (system crashes on
> lid close if _DOS=1, but on a UP platform).
> http://bugzilla.kernel.org/show_bug.cgi?id=6001#c49

I think the _DOS=1 case is somewhat different. There you'd expect 
significantly more system BIOS code to be run, and that's going to stand 
a much higher chance of causing unfortunate interactions with however 
Linux has set up the graphics.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
