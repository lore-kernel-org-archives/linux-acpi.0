From: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.16-rc[34]: resume-from-RAM unreliable
Date: Mon, 20 Feb 2006 21:09:43 -0800
Message-ID: <20060220210943.7f159749.akpm@osdl.org>
References: <43F9D3CA.1010709@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:2768 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161373AbWBUFLX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 21 Feb 2006 00:11:23 -0500
In-Reply-To: <43F9D3CA.1010709@rtr.ca>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Lord <lkml@rtr.ca>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, linux-acpi@vger.kernel.org

Mark Lord <lkml@rtr.ca> wrote:
>
> For the past week, I've been trying to keep with the latest -rc*-git*
> releases of 2.6.16 on my notebook, and something new in those is
> impacting resume-from-RAM.
> 
> It works most of the time, but *rarely* when suspended for more
> than a few hours (like overnight).  Which makes testing somewhat
> challenging, as this is also my main work machine.
> 
> Black screen on resume, no response to alt-sysrq-b,
> and no convenient serial port in the machine.
> 
> Works 100% with 2.6.15 kernels.
> 
> If I can figure out anything more that's useful, I'll do so,
> but that's all I know about it right now.
> 
> Debugging resume on a "legacy free" notebook is not fun.
> 

It's awful, isn't it?  git-bisct is the best bet, but at one bisection
point per day it could get a bit dull.

