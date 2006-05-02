From: matthieu castet <castet.matthieu@free.fr>
Subject: Re: [discuss]  Re: [RFC] make PC Speaker driver work on x86-64
Date: Tue, 02 May 2006 22:33:44 +0200
Message-ID: <4457C228.9050209@free.fr>
References: <200604291830.k3TIUA23009336@harpo.it.uu.se> <200604301050.22984.ak@suse.de> <445798F6.3050102@free.fr> <200605021950.17737.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp5-g19.free.fr ([212.27.42.35]:19362 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751271AbWEBUdq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 2 May 2006 16:33:46 -0400
In-Reply-To: <200605021950.17737.ak@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

Andi Kleen wrote:

> Does it work? 
> 
of course (at least on x86) !

> Also I have no idea if all x86 systems report the PC speaker in ACPI - a small
> survey of that would be probably a good idea. I guess just most of them reporting it would be 
> reasonable.
That's why I keep the platform driver :
the logic is try with ACPI in order to discover if there is a speaker. 
If we failed, let's try the platform driver.

Matthieu

PS : even system without ACPI should report the speaker with pnpbios.
