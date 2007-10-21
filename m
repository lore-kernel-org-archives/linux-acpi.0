From: Luca Capello <luca@pca.it>
Subject: Re: Oops removing thinkpad_acpi and video on git:linux-acpi-2.6
Date: Sun, 21 Oct 2007 19:45:52 +0200
Message-ID: <87myuccqen.fsf@gismo.pca.it>
References: <87lka1ffwc.fsf@gismo.pca.it>
 <20071018012106.GA24821@khazad-dum.debian.net> <87tzoo2q3x.fsf@gismo.pca.it>
 <20071018230334.GD4483@khazad-dum.debian.net> <871wbr2u1r.fsf@gismo.pca.it>
 <20071020002720.GA21173@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_gjCpAhmOb1X+jgGTG8FDIg)"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mbox.unige.ch ([129.194.9.209]:49954 "EHLO mbox.unige.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751534AbXJURp6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 21 Oct 2007 13:45:58 -0400
Received: from gismo.pca.it (233-71.203-62.cust.bluewin.ch [62.203.71.233])
 by mbox.unige.ch
 (Sun Java(tm) System Messaging Server 6.3-1.04 (built May  9 2007; 32bit))
 with ESMTPSA id <0JQ900G9DW0J2D00@mbox.unige.ch> for
 linux-acpi@vger.kernel.org; Sun, 21 Oct 2007 19:45:56 +0200 (CEST)
In-reply-to: <20071020002720.GA21173@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ML Linux-ACPI <linux-acpi@vger.kernel.org>


--Boundary_(ID_gjCpAhmOb1X+jgGTG8FDIg)
Content-type: TEXT/PLAIN; CHARSET=us-ascii
Content-transfer-encoding: 7BIT

Hi Henrique!

On Sat, 20 Oct 2007 02:27:20 +0200, Henrique de Moraes Holschuh wrote:
> On Fri, 19 Oct 2007, Luca Capello wrote:
>> On Fri, 19 Oct 2007 01:03:34 +0200, Henrique de Moraes Holschuh wrote:
>>> Hmm, I will see if I can reproduce it.
>> 
>> Thank you.
>
> Unfortunately, I can't reproduce it.
[...]
> Please compile thinkpad-acpi and ACPI with the debug modes enabled,
> and load thinkpad-acpi with the debug=0xffff parameter.  Then
> reproduce the oops, and send me the entire kernel output since
> driver load until the oops.

Done (and dmesg attached). Disabling CONFIG_THINKPAD_ACPI_HOTKEY_POLL
doesn't change anything (and the dmesg attached is with that option
enabled).

BTW, I needed to play a bit with module loading/unloading, since the
first time I removed the thinkpad_acpi module the oops wasn't
triggered.

Please let me know if you want my .config as well.

> You could also try turning on some of the ACPI debug bits, one of
> them (sorry, I don't know which) will tell you exactly which
> device's notify handler it is calling.

Well, I think I've all the ACPI debug options already on, since
CONFIG_ACPI_DEBUG=y and CONFIG_ACPI_DEBUG_FUNC_TRACE=y, as well as
CONFIG_PM_DEBUG=y (and CONFIG_THINKPAD_ACPI_DEBUG=y, obviously).

Thx, bye,
Gismo / Luca


--Boundary_(ID_gjCpAhmOb1X+jgGTG8FDIg)
Content-type: application/octet-stream;
 NAME=dmesg-2.6.23.1_thinkpad-acpi-0.18-oops_gismo-20071021.log.gz
Content-transfer-encoding: base64
Content-disposition: attachment;
 filename=dmesg-2.6.23.1_thinkpad-acpi-0.18-oops_gismo-20071021.log.gz
Content-description: 2.6.23.1 kernel and thinkpad_acpi-0.18 oops

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
BZNrNsggMAAA

--Boundary_(ID_gjCpAhmOb1X+jgGTG8FDIg)--
