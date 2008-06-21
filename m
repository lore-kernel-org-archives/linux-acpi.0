From: "Robert M. Albrecht" <romal@gmx.de>
Subject: Re: Toshiba - Documentation for Linux Developers
Date: Sat, 21 Jun 2008 16:09:14 +0200
Message-ID: <485D0B8A.9090201@gmx.de>
References: <4855971D.90004@diamondcut.com.br> <20080616221443.GA760@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:56112 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750897AbYFUOJR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 21 Jun 2008 10:09:17 -0400
In-Reply-To: <20080616221443.GA760@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <greg@kroah.com>
Cc: "Renato S. Yamane" <yamane@diamondcut.com.br>, linux-acpi@vger.kernel.org

Hi,

yes, there are some things missing (Bluetooth, ...) . Posted some weeks ago 
in driver-devel list, but no response :-(

http://driverdev.linuxdriverproject.org/pipermail/devel/2008-April/000413.html

cu romal

www.romal.de
blog.romal.de

--------------------

Hi,

the builtin Toshiba Bluetooth adapter is in disabled state by default. It
works perfectly well if enabled.

There are two families of Toshiba notebooks, the ones made by Compal
(PhoenixBIOS), and the original Toshiba manufactured.

The Compal-OEMs are supported by the Omnibook kernel module (along with
some others laptops by HP, ...): http://omnibook.sourceforge.net/doku.php

The Toshiba made notebooks need toshiba_acpi. toshiba_acpi is included in
the kernel but is outdated and does not work on newer models and x86_64. 
The newer one works partially an can be downloaded:
http://memebeam.org/toys/ExperimentalToshibaAcpiDriver

Documentation from Toshiba is available from
http://linux.toshiba-dme.co.jp/linux/eng/develop.htm

Both drivers are maintained outside the kernel.

http://bugzilla.kernel.org/show_bug.cgi?id=10173

Any chance they might be included ?

As my last coding is several years old, I would not be of great help. But I
could assist in docs or testing. Our company does buy Toshiba laptops, so I
have access to various models for testing.

cu romal




Greg KH schrieb:
> On Sun, Jun 15, 2008 at 07:26:37PM -0300, Renato S. Yamane wrote:
>> Hi for all,
>>
>> Toshiba have a 'link' between Linux Developers and Head Company, that is:
>> <http://linux.toshiba-dme.co.jp/linux/eng/develop.htm>
>>
>> If someone need documentation to develop Linux drivers, contact
>> linux@toshiba-dme.co.jp
> 
> Are there any known drivers for Toshiba hardware that you need for Linux
> that we should be contacting them about?
> 
> thanks,
> 
> greg k-h
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
