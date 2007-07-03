From: "Renato S. Yamane" <renatoyamane@mandic.com.br>
Subject: Re: Add INPUT support to toshiba_acpi
Date: Tue, 03 Jul 2007 09:59:42 -0300
Message-ID: <468A483E.6060207@mandic.com.br>
References: <1180614979.2693.26.camel@localhost.localdomain> <200706281327.29962.eike-kernel@sf-tec.de> <4683A80E.4070006@mandic.com.br> <200707030738.39980.eike-kernel@sf-tec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-01b.mandic.com.br ([200.225.81.136]:58804 "EHLO
	smtp-01.mandic.com.br" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752846AbXGCM7r (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 3 Jul 2007 08:59:47 -0400
Received: from unknown (HELO [192.168.1.65]) (48XWxNa3qdTI2cq3yJaVop5Ok6I=@[200.228.134.10])
          (envelope-sender <renatoyamane@mandic.com.br>)
          by smtp-01.mandic.com.br (qmail-ldap-1.03) with AES256-SHA encrypted SMTP
          for <linux-acpi@vger.kernel.org>; 3 Jul 2007 12:59:44 -0000
In-Reply-To: <200707030738.39980.eike-kernel@sf-tec.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi <linux-acpi@vger.kernel.org>
Cc: Rolf Eike Beer <eike-kernel@sf-tec.de>, "Renato S. Yamane" <renatoyamane@mandic.com.br>, Richard Hughes <hughsient@gmail.com>, John Belmonte <john@neggie.net>, linux-kernel <linux-kernel@vger.kernel.org>, Bastien Nocera <hadess@hadess.net>, Mathieu.Berard@crans.org, mjg59@srcf.ucam.org, jaimeff@gmail.com

Rolf Eike Beer wrote:
> Renato S. Yamane wrote:
>> Rolf Eike Beer wrote:
>>> Richard Hughes wrote:
>>>>
>>>> Yes, although this is out of my area or expertise, sorry.
>>>
>>> I've looked a bit but can't find any driver interaction of those
>>> programs. Any further ideas welcome.
>>
>> Do you try omnibook driver?
>> svn export https://svn.sourceforge.net/svnroot/omnibook/omnibook/trunk
>>
>> toshiba_acpi don't work on my Toshiba M45-S355 (Toshiba BIOS) and I try
>> this module above and now I can change brightness writing in
>> /proc/omnibook/lcd and kpowersave can change brightness too.
>
> Oh wow! Even my Multimedia keys get recognized. Thanks very much for your 
> pointer.

I think that is a good idea more support to Toshiba Laptops, so 
omnibook+toshiba_acpi is a perfect couple, because some functions works 
with toshiba_acpi and others works with omnibook.

Jaime (in cc too) do a very useful module that work in some laptop 
models that not work on toshiba_acpi and omnibook driver.

So, I think that is a very good idea all work together to do a more 
powerful (and compatible) module in next kernel releases.

Regards,
Renato S. Yamane
