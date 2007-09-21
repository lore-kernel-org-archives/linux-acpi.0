From: Hernan G Solari <hgsolari@gmail.com>
Subject: ACER 5050-4697 ACPI crashes
Date: Fri, 21 Sep 2007 17:36:13 -0300
Message-ID: <46F42B3D.1050607@gmail.com>
Reply-To: hgsolari@gmail.com, solari@df.uba.ar
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.224]:33581 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756224AbXIUUfc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Sep 2007 16:35:32 -0400
Received: by wx-out-0506.google.com with SMTP id h31so756693wxd
        for <linux-acpi@vger.kernel.org>; Fri, 21 Sep 2007 13:35:32 -0700 (PDT)
Received: from localhost ([127.0.0.1] ident=hernan)
	by localhost.localdomain with esmtp (Exim 4.50)
	id 1IYpEU-0001P7-7u
	for linux-acpi@vger.kernel.org; Fri, 21 Sep 2007 17:36:14 -0300
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hello
    I have a new laptop, an ACER 5050-4697 that sells "South of the
border" (from Mexico to
Argentina) relatively inexpensive...
    It is new not only in the sense that I just got it, but also it is =
a
new model with new chips mostly unsupported under Linux.
    you can see the log of my attempts at making Linux work on this box=
 at
http://www.df.uba.ar/~solari/acer.html
(No shame, Acer can only get the 32bit Visa working on this AMD-64
machine and
the BlueTooth device is not supported, although it is there...)

I started with debian Etch 4.0 with kernel 2.6.18.4 and soon updated th=
e
kernel to the last stable release 2.6.22 (no patch).

With both kernels I have ACPI problems at booting time.
2.6.18.4
    does not find the battery
    hangs when installing the module ac.ko
    removing the module ac-.ko it hangs later when launching the daemon=
 hald
    working under acpi=3Doff on boot line
2.6.22
    hangs at boot time with last words
ACPI Exception (processor_core=3D0781): AE_NOT_FOUND,  Processor Device=
 is not
present [20070126]
    works with acpi=3Doff or acpi=3Dht

you can find dmesg output at the link provided above.
ACPI tables downloaded and recompiled without errors or warnings (did I
miss soemthing?)
You can find them in a tarball at:
http://www.df.uba.ar/~solari/ACER/acpidsl.tgz

I hope you can help me, thanks in any case
                                                                      H=
ernan

PS: using Linux since version 0.99

--=20
Hern=E1n Gustavo Solari, solari@df.uba.ar, http://www.df.uba.ar/~solari

-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
