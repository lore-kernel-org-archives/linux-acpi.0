From: Davidlohr Bueso <davidlohr.bueso@hp.com>
Subject: Re: srat: harsh hot-pluggable memory check?
Date: Fri, 11 Jan 2013 12:13:50 -0800
Message-ID: <1357935230.7523.32.camel@buesod1.americas.hpqcorp.net>
References: <1357846907.7523.17.camel@buesod1.americas.hpqcorp.net>
	 <20130110200223.GH30577@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:15841 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753669Ab3AKUN5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Jan 2013 15:13:57 -0500
In-Reply-To: <20130110200223.GH30577@one.firstfloor.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
Cc: linux-acpi@vger.kernel.org, zeus@gnu.org, linux-kernel@vger.kernel.org

On Thu, 2013-01-10 at 21:02 +0100, Andi Kleen wrote:
> > This only mentions that the system supports hot-plugging, and IMHO if the
> > user decides not to use CONFIG_MEMORY_HOTPLUG, it shouldn't be considered an error.
> > Therefore would it be ok to drop the check? Or am I missing something?
> 
> The very strict checks were originally implemented because various early
> BIOS had largely fictional SRATs, and trusting them blindly caused
> boot failures or a lot of wasted memory for unnecessary hotplug zones. 
> The wasted memory was mainly a problem with the old memory hotplug
> implementation that pre-allocated memmaps, that's not a problem anymore.
> However there may be still some other failure cases.
> 

Would you be willing to take a patch that drops this check then? Or do
you see any other scenario where it would still be valid?

Thanks,
Davidlohr

