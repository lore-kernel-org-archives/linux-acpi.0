From: giggz <giggzounet@gmail.com>
Subject: Re: Problem with the Fn+F3 key. acpi problem ?
Date: Sat, 08 Mar 2008 11:08:54 +0100
Message-ID: <fqtor7$5mu$1@ger.gmane.org>
References: <fmaaj5$jsl$1@ger.gmane.org>	 <20080112121714.GB15173@srcf.ucam.org> <fmac61$oc8$1@ger.gmane.org>	 <20080112124619.GA15578@srcf.ucam.org>  <fmakts$gqs$1@ger.gmane.org> <1203347919.6019.79.camel@queen.suse.de> <fqtkjq$rod$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:47463 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751708AbYCHKNM (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 8 Mar 2008 05:13:12 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JXw37-0001Li-7u
	for linux-acpi@vger.kernel.org; Sat, 08 Mar 2008 10:13:05 +0000
Received: from cam44-1-82-67-121-239.fbx.proxad.net ([82.67.121.239])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sat, 08 Mar 2008 10:13:05 +0000
Received: from giggzounet by cam44-1-82-67-121-239.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sat, 08 Mar 2008 10:13:05 +0000
In-Reply-To: <fqtkjq$rod$1@ger.gmane.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

giggz a =C3=A9crit :
[snip]

>>>> In that case, try catting /proc/acpi/event and hit the button.
>> On SUSE, instead of stopping acpid, you can use:
>> acpi_listen
>> to log acpi events.
>>

in my case when I increase the level of acpi debug and hit the Fn+F3
button I don't see anything when I cat /proc/acpi/event. And it's the
same if I use acpi_listen. I launch acpi_listen and the hit the button,
but nothing appears. I just get the message I posted in the
/var/log/messages.

Guillaume

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
