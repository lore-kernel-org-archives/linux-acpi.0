From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: ACPI crash on lid close - SMP race?
Date: Tue, 11 Nov 2008 09:59:38 +0800
Message-ID: <1226368778.15014.73.camel@rzhang-dt>
References: <20081110161105.GA2041@srcf.ucam.org>
	 <1226366834.15014.60.camel@rzhang-dt>
	 <20081111013359.GA11364@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:5352 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752330AbYKKCCG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 10 Nov 2008 21:02:06 -0500
In-Reply-To: <20081111013359.GA11364@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, 2008-11-11 at 09:33 +0800, Matthew Garrett wrote:
> On Tue, Nov 11, 2008 at 09:27:14AM +0800, Zhang Rui wrote:
> > well, there is a bug report for this problem:
> > http://bugzilla.kernel.org/show_bug.cgi?id=11259
> 
> I'll give the noirqbalance case a go.
> 
> > and there are some bug reports for a similar problem (system crashes on
> > lid close if _DOS=1, but on a UP platform).
> > http://bugzilla.kernel.org/show_bug.cgi?id=6001#c49
> 
> I think the _DOS=1 case is somewhat different. There you'd expect 
> significantly more system BIOS code to be run, and that's going to stand 
> a much higher chance of causing unfortunate interactions with however 
> Linux has set up the graphics.
> 
oops. sorry, I mean system crashes on lid close if _DOS=0 on some UP
platform.

thanks,
rui


