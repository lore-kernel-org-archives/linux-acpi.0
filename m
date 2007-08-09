From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: inconsistency in /proc/acpi directory structure?
Date: Thu, 9 Aug 2007 09:54:31 -0300
Message-ID: <20070809125431.GC3113@khazad-dum.debian.net>
References: <20070809123943.GD3939@ngolde.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:43280 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965317AbXHIMyg (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 9 Aug 2007 08:54:36 -0400
Content-Disposition: inline
In-Reply-To: <20070809123943.GD3939@ngolde.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Nico Golde <nion@gmx.net>
Cc: linux-acpi@vger.kernel.org

On Thu, 09 Aug 2007, Nico Golde wrote:
> But even checking for an empty directory is not enough since 
> there comes ibm-acpi (maybe others).

As far as ibm-acpi goes, you can do me a BIG favour, and pretend it has
nothing in procfs.

> With working fan and usage of ibm-acpi you also get an empty 
> /proc/acpi/fan dir because you have /proc/acpi/ibm/fan where 
> you can then find the relevant files.
> This sucks, I mean I can implement a workaround for this, 
> but if asus-acpi would do the same and maybe others would 
> exists I have to check alot of directories. So why not using 
> the existing directory structure?

[...]

> Why is ibm-acpi not using the existing directory structure 
> (also wrote to the ibm-acpi guys but with no answer so far, 
> so I try to get answers here)? Do I miss anything?

I did reply to you. Hmm... I will resend the reply just in case, I have no
idea why it didn't reach you.

I didn't expand a lot on this email because I replied in detail to you on
the email you didn't receive.  I will resend it to this thread as well.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
