From: Rich Coe <Richard.Coe@med.ge.com>
Subject: Re: acpi_button: random oops on boot
Date: Mon, 24 Jan 2011 12:48:13 -0600
Message-ID: <20110124124813.bb03c6fe.Richard.Coe@med.ge.com>
References: <1291477752.5096.27.camel@Tobias-Karnat>
	<1291679699.6246.11.camel@Tobias-Karnat>
	<20101207051521.GA16804@helgaas.com>
	<201101241403.21707.trenn@suse.de>
	<1295892786.3265.48.camel@Tobias-Karnat>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from exprod5og110.obsmtp.com ([64.18.0.20]:36196 "EHLO
	exprod5og110.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753562Ab1AXSqA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Jan 2011 13:46:00 -0500
In-Reply-To: <1295892786.3265.48.camel@Tobias-Karnat>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tobias Karnat <tobias.karnat@googlemail.com>
Cc: Thomas Renninger <trenn@suse.de>, richard.coe@med.ge.com, jslaby@novell.com, linux-acpi@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, 24 Jan 2011 19:13:06 +0100
Tobias Karnat <tobias.karnat@googlemail.com> wrote:
> Am Montag, den 24.01.2011, 14:03 +0100 schrieb Thomas Renninger:
> I hope Rich is still interested in a solution as I am. The bad thing is
> that the latest working version I had been running on that machine was
> ancient 2.6.23. So this problem is a regression, which I would have
> noticed earlier, if I had updated that machine more often.
> 
> It is not an hardware problem [...]

I don't think it's a hardware problem either.  

I reproduced this on later kernels, 2.6.36 (I think). 
I've been working on a project that's almost finished, then I plan on going
back to tracking down this issue.

Rich
-- 
