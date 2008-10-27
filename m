From: Stefan Agner <falstaff@deheime.ch>
Subject: Broken ACPI on HP EliteBook 8530w
Date: Mon, 27 Oct 2008 15:04:37 +0100
Message-ID: <20081027150437.13962ng36q00ttic@mail.deheime.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	DelSp=Yes	format=flowed
Content-Transfer-Encoding: 7BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.deheime.ch ([62.12.167.34]:36200 "EHLO limpopo.deheime.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750790AbYJ0OMl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Oct 2008 10:12:41 -0400
Received: from localhost (localhost [127.0.0.1])
	by limpopo.deheime.ch (Postfix) with ESMTP id 0F72E43125
	for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2008 15:04:38 +0100 (CET)
Received: from limpopo.deheime.ch ([127.0.0.1])
	by localhost (limpopo.deheime.ch [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f9VmfhiYfF7l for <linux-acpi@vger.kernel.org>;
	Mon, 27 Oct 2008 15:04:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by limpopo.deheime.ch (Postfix) with ESMTP id 8BA6343126
	for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2008 15:04:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by limpopo.deheime.ch (Postfix) with ESMTP id 607DE43125
	for <linux-acpi@vger.kernel.org>; Mon, 27 Oct 2008 15:04:37 +0100 (CET)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello,

I've bought a new Laptop, HP EliteBook 8530w. I tried to install  
Ubuntu on it and noticed that ACPI doesnt work (I made a Ubuntu bug  
report here  
https://bugs.launchpad.net/ubuntu/+source/linux-meta/+bug/288385). The  
Laptop hangs on bootup. With the kernel parameter acpi=ht, which  
basically disables acpi except the smp feature, the kernel boots.

Becauce it is very anoying to work with a laptop without acpi I  
decided to try to fix it myself. I dumped the acpi table (sudo  
acpidump -t DSDT -o dsdt.dat -b) and tried to disassemble/compile it  
with iasl (iasl -d dsdt.dat/iasl -sa dsdt.dsl).


The errors I get are maaany of the "Object does not exist":
dsdt.dsl    49:             Store (\_SB.PCI0.RP03.PDSX, IECP)

Error    4062 -                Object does not exist ^  (\_SB.PCI0.RP03.PDSX)



dsdt.dsl    50:             Store (\_SB.PCI0.RP05.PDSX, DECP)

Error    4062 -                Object does not exist ^  (\_SB.PCI0.RP05.PDSX)

Then I have this Errors:
dsdt.dsl   611:                     VBRE (0x87, If (LEqual (Local0, 0x02))

Error    4094 -                                  ^ syntax error,  
unexpected PARSEOP_IF, expecting ',' or ')'



dsdt.dsl   611:                     VBRE (0x87, If (LEqual (Local0, 0x02))

Error    4094 -                             syntax error, unexpected ')' ^



dsdt.dsl   611:                     VBRE (0x87, If (LEqual (Local0, 0x02))

Warning  1104 -       Result is not used, operator has no effect ^



dsdt.dsl   614:                         })

Error    4094 -                          ^ syntax error, unexpected ')'

And this one:
dsdt.dsl   720:     Scope      Name (_HID, EisaId ("PNP0C0B"))

Error    4094 -         ^ syntax error, unexpected PARSEOP_SCOPE,  
expecting $end

My questions: First, can it be that the kernel can boot with acpi with  
a fixed DSDT table loaded? Can somebody help me fixing the table  
(especially Object does not exist, does I have to define all this  
things with External?) ? When I try to fix them and I do it wrong, can  
I break hardware with it?

I thought when I've fixed the table, im going to open a bug report and  
then this can be fixed in acpi, is this the right approach?

The full log can be found here: http://paste.ubuntu.com/63256/
The disassembled DSDT can be found here: http://paste.ubuntu.com/63257/

Any help would be greatly appriciated,
Stefan

