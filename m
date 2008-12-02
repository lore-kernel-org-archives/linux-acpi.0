From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: ACPI bug with Lenovo Thinkpad
Date: Mon, 1 Dec 2008 22:28:44 -0200
Message-ID: <20081202002844.GB17452@khazad-dum.debian.net>
References: <49303128.5090708@sikkerhed.org> <4933B315.8070700@iversen-net.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:34451 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751568AbYLBA2t (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 1 Dec 2008 19:28:49 -0500
Content-Disposition: inline
In-Reply-To: <4933B315.8070700@iversen-net.dk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christian Iversen <chrivers@iversen-net.dk>
Cc: linux-acpi@vger.kernel.org

On Mon, 01 Dec 2008, Christian Iversen wrote:
> Christian Iversen wrote:
>> On my ubuntu hardy (8.04) with 2.6.24-22-generic (from ubuntu), I have 
>> a  reproducible problem with my lenovo thinkpad T61p 6460
>>
>> I have an advanced minidock for the thinkpad. Normal docking and  
>> undocking work great. However, if the dock loses power while the  
>> thinkpad is docked, the computer freezes.
> >
> > [...]
>
> Bump. Anyone? Is this the wrong place to report such a problem?

Sort of.  It would be the correct place, however...

You use a thinkpad with an nVidia GPU and a old Ubuntu kernel, with is not
something we have resources to support.  It is probably best to report it to
Ubuntu if you want help with that specific kernel combination.

If you don't mind trying the latest stable Linux kernel, without ANY
proprietary drivers, we can try to help you here.

Another place where you might find help is the linux-thinkpad ML.  You will
find Ubuntu users with T61p there that are likely to have working
sleep/hibernate configurations (even using nVidia drivers).

The linux-thinkpad mailing list addresses and lots of useful information can
be found on http://thinkwiki.org.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
