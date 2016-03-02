From: Lukas Wunner <lukas@wunner.de>
Subject: Re: ACPI SPI slave device
Date: Wed, 2 Mar 2016 12:42:50 +0100
Message-ID: <20160302114250.GA23487@wunner.de>
References: <CAAbRKOvktig4w9RPngCV4PBYZmO+3emCPwjMT1XMSxNesY+M6A@mail.gmail.com>
 <20160223150222.GL1770@lahna.fi.intel.com>
 <20160223153240.GM1770@lahna.fi.intel.com>
 <CAAbRKOu+s=OZw8vw2kfWs=JCQB1YcVg+51N5Yh_dCJOuytR2zA@mail.gmail.com>
 <20160229082114.GC1770@lahna.fi.intel.com>
 <CAAbRKOt=CDOqD1FESZkxv4fdYSDm6qoi4J0wYn=e5mvN-NLpCA@mail.gmail.com>
 <CAAbRKOscDyYaUqBTFVFZ2Fe81a_Kkx9oeNXHrttm3Qs_27fAzQ@mail.gmail.com>
 <20160301160726.GA23371@wunner.de>
 <CAAbRKOuESP+_65cmeCPNtO5HzN1+ct7bDv1stbE+a8u=KEwDKw@mail.gmail.com>
 <CAAbRKOsNxsu4CYq=EByck997RWRO3fQ-+LAAS5AbSL3XNRSh7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailout1.hostsharing.net ([83.223.95.204]:56075 "EHLO
	mailout1.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752144AbcCBLvs (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Mar 2016 06:51:48 -0500
Content-Disposition: inline
In-Reply-To: <CAAbRKOsNxsu4CYq=EByck997RWRO3fQ-+LAAS5AbSL3XNRSh7A@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Leif Liddy <leif.linux@gmail.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, jarkko.nikula@linux.intel.com

Hi,

On Wed, Mar 02, 2016 at 04:13:16AM +0100, Leif Liddy wrote:
> I'll post more tomorrow, need to evaluate the changes I made --but I
> think the change that did it was changing this:
> 
> Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
> {
>     If (!OSDW ())
>     {
>         Return (WBUF) /* \_SB_.PCI0.SPI1.WBUF */
>     }
> 
>     Return (ConcatenateResTemplate (RBUF, DBUF))
> }
> 
> to:
> 
> Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
> {
>       Return (ConcatenateResTemplate (RBUF, DBUF))
> }

If that is true then the fix is to change the OS we're reporting to ACPI:
https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/acpi/osl.c#n141

We had trouble with this before:
https://mjg59.dreamwidth.org/29954.html

I've just grabbed the acpidump you've posted here:
https://bugzilla.kernel.org/attachment.cgi?id=200961&action=edit

I'll take a look at it hopefully this afternoon to see what they've
changed in the OSDW method.

Thanks a lot for your perseverance in tackling this issue.

Lukas
