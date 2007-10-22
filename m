From: Luca Capello <luca@pca.it>
Subject: Re: Oops removing thinkpad_acpi and video on git:linux-acpi-2.6
Date: Mon, 22 Oct 2007 08:48:14 +0200
Message-ID: <87prz7myq9.fsf@gismo.pca.it>
References: <87lka1ffwc.fsf@gismo.pca.it>
 <20071018012106.GA24821@khazad-dum.debian.net> <87tzoo2q3x.fsf@gismo.pca.it>
 <20071018230334.GD4483@khazad-dum.debian.net> <871wbr2u1r.fsf@gismo.pca.it>
 <20071020002720.GA21173@khazad-dum.debian.net> <87myuccqen.fsf@gismo.pca.it>
 <20071022013204.GA13019@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_QR6vzVYGYz94liDflNYAJA)"
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mbox.unige.ch ([129.194.9.209]:34287 "EHLO mbox.unige.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751309AbXJVGsX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 22 Oct 2007 02:48:23 -0400
Received: from gismo.pca.it (184-77.62-81.cust.bluewin.ch [81.62.77.184])
 by mbox.unige.ch
 (Sun Java(tm) System Messaging Server 6.3-1.04 (built May  9 2007; 32bit))
 with ESMTPSA id <0JQA00GROW8K2D00@mbox.unige.ch> for
 linux-acpi@vger.kernel.org; Mon, 22 Oct 2007 08:48:21 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: ML Linux-ACPI <linux-acpi@vger.kernel.org>


--Boundary_(ID_QR6vzVYGYz94liDflNYAJA)
Content-type: TEXT/PLAIN; CHARSET=us-ascii
Content-transfer-encoding: 7BIT

Hi Henrique!

On Mon, 22 Oct 2007 03:32:04 +0200, Henrique de Moraes Holschuh wrote:
> On Sun, 21 Oct 2007, Luca Capello wrote:
>> BTW, I needed to play a bit with module loading/unloading, since the
>> first time I removed the thinkpad_acpi module the oops wasn't
>> triggered.
>
> Hmm, am I going crazy, or did the OOPS happen with an instance of
> thinkpad-acpi *not* loaded with debug=0xffff?  Can you try that
> again making sure it always gets the debug=0xfffff parameter?
> Apparently, it was active only the first time you tried to load the
> module,

Sorry, my fault.  It should be OK now.

Thx, bye,
Gismo / Luca


--Boundary_(ID_QR6vzVYGYz94liDflNYAJA)
Content-type: application/octet-stream;
 NAME=dmesg-2.6.23.1_thinkpad-acpi-0.18-debug-oops_gismo-20071022.log.gz
Content-transfer-encoding: base64
Content-disposition: attachment;
 filename=dmesg-2.6.23.1_thinkpad-acpi-0.18-debug-oops_gismo-20071022.log.gz
Content-description: 2.6.23.1 kernel and thinkpad_acpi-0.18-debug oops

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
Js57FsA5PCc/lGsFnwM/Np8Wnf8C9i7M7BgrAAA=

--Boundary_(ID_QR6vzVYGYz94liDflNYAJA)--
