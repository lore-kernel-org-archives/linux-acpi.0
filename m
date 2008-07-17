From: Sebastian Pohl <sebastianp@uni-koblenz.de>
Subject: Re: ACPI Problems on Sony Vaio SZ61MN, no brightness ctrl, no power
 button
Date: Thu, 17 Jul 2008 14:51:24 +0200
Message-ID: <487F404C.6020805@uni-koblenz.de>
References: <487CA418.6060103@uni-koblenz.de> <1216172299.1617.145.camel@rzhang-dt> <487DC015.6070704@uni-koblenz.de> <20080716112707.GA3777@inferi.kami.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from deliver.uni-koblenz.de ([141.26.64.15]:4044 "EHLO
	deliver.uni-koblenz.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753238AbYGQMwU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 17 Jul 2008 08:52:20 -0400
In-Reply-To: <20080716112707.GA3777@inferi.kami.home>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org

Mattia Dongili wrote:
>
> The SZ series have a stamina/speed switch switch between 2 video cards.
> Usually one is an NVidia (for speed) and one is an Intel (for stamina).
> On the NVidia there is nothing we can do (you can try nvclock or any
> nvidia proprietary tool as documented on my wiki[1]), while for the
> Intel card it's a different story (again documented on my wiki).
> If you have no luck with the sony-laptop provided backlight control you
> can try xbacklight that, as far as I can see[2], should work on your
> Intel chipset.
>
> hope this helps
>
> [1]: http://www.linux.it/~malattia/wiki/index.php/Sony-laptop#Brightness
> [2]: https://bugs.launchpad.net/ubuntu/+source/xbacklight/+bug/173652
>   

Hi,

the backlight now is working with the Intel chipset. But the workaround 
had some sideeffects: Now the lidswitch is unfunctional. :/

I tried to find out if it works by running acpi_listen but the lidswitch 
generates no events...

Any ideas?

regards

       sebastian
