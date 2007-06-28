From: "Renato S. Yamane" <renatoyamane@mandic.com.br>
Subject: Re: Add INPUT support to toshiba_acpi
Date: Thu, 28 Jun 2007 09:22:38 -0300
Message-ID: <4683A80E.4070006@mandic.com.br>
References: <1180614979.2693.26.camel@localhost.localdomain> <200706260703.22994.eike-kernel@sf-tec.de> <1182848195.2335.0.camel@work> <200706281327.29962.eike-kernel@sf-tec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-03.mandic.com.br ([200.225.81.143]:57534 "EHLO
	smtp-03.mandic.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759045AbXF1MdF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Jun 2007 08:33:05 -0400
In-Reply-To: <200706281327.29962.eike-kernel@sf-tec.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Richard Hughes <hughsient@gmail.com>, John Belmonte <john@neggie.net>, linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Bastien Nocera <hadess@hadess.net>, Mathieu.Berard@crans.org

Rolf Eike Beer wrote:
> Richard Hughes wrote:
>> Yes, although this is out of my area or expertise, sorry.
> 
> I've looked a bit but can't find any driver interaction of those programs. Any 
> further ideas welcome.

Do you try omnibook driver?
svn export https://svn.sourceforge.net/svnroot/omnibook/omnibook/trunk

toshiba_acpi don't work on my Toshiba M45-S355 (Toshiba BIOS) and I try 
this module above and now I can change brightness writing in 
/proc/omnibook/lcd and kpowersave can change brightness too.

But, is impossible use multimedia keys (play, pause, browser, etc) and 
couple keys (fn-fx), because Fn key and Multimedia keys don't is recognized.

Regards,
Renato S. Yamane
