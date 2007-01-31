From: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.20-rc6-mm3
Date: Tue, 30 Jan 2007 17:25:25 -0800
Message-ID: <20070130172525.f32fb9ea.akpm@osdl.org>
References: <20070129204528.eb8d695e.akpm@osdl.org>
	<45BFC442.5000903@gmail.com>
	<45BFEDFB.6000500@imap.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:60874 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932169AbXAaBZ3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Jan 2007 20:25:29 -0500
In-Reply-To: <45BFEDFB.6000500@imap.cc>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tilman Schmidt <tilman@imap.cc>
Cc: Maciej Rutecki <maciej.rutecki@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Wed, 31 Jan 2007 02:16:43 +0100
Tilman Schmidt <tilman@imap.cc> wrote:

> Am 30.01.2007 23:18 schrieb Maciej Rutecki:
> > Second problem, power button doesn't work. When I pressed it, I has this
> > error:
> > 
> > ACPI Error (evevent-0305): No installed handler for fixed event
> > [00000002] [20070126]
> 
> Same here, minus the message. (Or perhaps I just don't know where to look.)
> Problem also exists in 2.6.20-rc6-mm2. With 2.6.20-rc6-git1 the power
> button of this machine works fine.
> 

That's significant - in your case at least the 2.6.20-rc6-mm3 ACPI update
isn't the cause.

