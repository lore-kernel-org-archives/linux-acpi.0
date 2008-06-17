From: "Renato S. Yamane" <yamane@diamondcut.com.br>
Subject: Re: Toshiba - Documentation for Linux Developers
Date: Tue, 17 Jun 2008 08:02:14 -0300
Message-ID: <485799B6.2010302@diamondcut.com.br>
References: <4855971D.90004@diamondcut.com.br> <20080616221443.GA760@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp-01.mandic.com.br ([200.225.81.132]:43997 "EHLO
	smtp-01.mandic.com.br" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754072AbYFQLC0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jun 2008 07:02:26 -0400
In-Reply-To: <20080616221443.GA760@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: linux-acpi@vger.kernel.org

Greg KH wrote:
> Renato S. Yamane wrote:
>> Toshiba have a 'link' between Linux Developers and Head Company, that is:
>> <http://linux.toshiba-dme.co.jp/linux/eng/develop.htm>
>>
>> If someone need documentation to develop Linux drivers, contact
>> linux@toshiba-dme.co.jp
> 
> Are there any known drivers for Toshiba hardware that you need for Linux
> that we should be contacting them about?

Greg, in my Toshiba M45-S355, multimedia keys (play, pause, stop, etc)
and Fn+Fx keys don't work.

With no Fn keys, I can't change brightness of monitor (Fn+F6/F7) and
change output video from LCD to VGA (Fn+F5).

I try use "xev" to capture key press, but Fn and Multimedia Keys is not
recognized.

And other problem is with battery charge, as we can see here:
<http://bugzilla.kernel.org/show_bug.cgi?id=10797>

Best regards,
Renato S. Yamane
