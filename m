From: Witold Szczeponik <Witold.Szczeponik@gmx.net>
Subject: Re: [PATCH] ACPI: suspend: don't let device _PS3 failure prevent
 suspend
Date: Sun, 10 May 2009 22:48:18 +0200
Message-ID: <4A073D92.5060904@gmx.net>
References: <bug-13243-10286@http.bugzilla.kernel.org/> <20090505150138.92f3ecd6.akpm@linux-foundation.org> <4A02000D.9030400@gmx.net> <200905061616.36707.bjorn.helgaas@hp.com> <1241660638.3773.90.camel@localhost.localdomain> <4A0330E3.9060909@gmx.net> <alpine.LFD.2.00.0905080037240.20287@localhost.localdomain> <20090508122354.GA30672@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:46104 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751062AbZEJUsZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 10 May 2009 16:48:25 -0400
In-Reply-To: <20090508122354.GA30672@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: Len Brown <lenb@kernel.org>, yakui_zhao <yakui.zhao@intel.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "cedric@belbone.be" <cedric@belbone.be>, linux-acpi@vger.kernel.org

Henrique de Moraes Holschuh schrieb:

> On Fri, 08 May 2009, Len Brown wrote:
>> Or perhaps we should just shrug off the _PS3 failure
>> and carry on with _DIS like we used to -- which is
>> what this patch does.
> 
> Maybe "printk and carry on" would be better?
> 

And there is very similar code just a few lines above: where we turn on 
the device by setting it to D0.  There, too, we may want to skip the 
check whether or not the transition was successful or not.

--- Witold
