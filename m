From: Matthieu Dubuget <matthieu.dubuget@gmail.com>
Subject: Re: [regression] suspend is flakey, "shutdown -h now" does not power
 off
Date: Sun, 20 Nov 2011 20:59:03 +0100
Message-ID: <4EC95C07.6030706@gmail.com>
References: <4EC27F88.9070209@gmail.com> <20111116044358.GB5889@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:55595 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105Ab1KTT7I (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 20 Nov 2011 14:59:08 -0500
Received: by wwe5 with SMTP id 5so9083667wwe.1
        for <linux-acpi@vger.kernel.org>; Sun, 20 Nov 2011 11:59:07 -0800 (PST)
In-Reply-To: <20111116044358.GB5889@elie.hsd1.il.comcast.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Jonathan Nieder <jrnieder@gmail.com>

Hello,

I'm sending this message again without attachments etc., because I
think (apologies if I'm wrong) that my first try did not succeed. The
original message was also sent to debian bug tracking system. You can
find it there, with the attachments (acpidump outputs, dmesg output)
and with some more (maybe less relevant) tests.

http://bugs.debian.org/648754

I'm experiencing some acpi-related problems with my laptop
([0.000000] DMI: Compal PBL21/PBL21, BIOS 1.71 04/19/2011)

With the most recent kernels I tested:

- "shutdown -h now" or "shutdown -h -P now":
     * produce an apparently normal shutdown log
     * then echoes "System halted"
     * but does never power off the computer

- sometime (rare & randomly), when I re-open the lid after the computer was
    manually turned off, it boots

- But most of the time, pm-suspend (or "suspend" from gnome-shell) is
    working (this fails sometime with a freeze, and fans at full speed),
    as expected

List of kernels I could test:

     - affected:

         * Debian 3.0.0-6 (which is very close to upstream stable v3.0.8)
         * Debian 3.1.0-1~experimental.1 (which is basically linus's v3.1)
         * Debian 2.6.32-39 (close to longterm v2.6.32.43)
         * Ubuntu 3.0.0-12.20-generic (3.0.4 ? started from the Ubuntu 
11.10 live CD)

     - not affected:

         * Ubuntu 2.6.32.41+drm33.18 (started from the Ubuntu 10.04.3 LTS
           live CD)

Attached files:

    - dmesg-not-working.txt: dmesg from an affected kernel
    - acpidump-not-working.txt: acpidump output
    - dmesg-working.txt: dmesg from an unaffected kernel
    - acpidump-working.txt: acpidump output obtain with a working kernel
    - acpidump-ubuntu-11-10.txt: obtained with 11.10 debian CD. Not 
working. Different dump, for the record.

Note:

       $ diff acpidump-not-working.txt acpidump-working.txt
       2805a2806,2813
  > RSDT @ 0xaf7fe0ac
  >   0000: 52 53 44 54 58 00 00 00 01 8a 49 4e 53 59 44 45 
RSDTX.....INSYDE
  >   0010: 48 52 20 43 52 42 20 20 01 00 00 00 20 20 20 20  HR CRB  ....
  >   0020: 13 00 00 01 00 c0 7f af 00 d0 7f af 00 b0 7f af 
................
  >   0030: 00 a0 7f af 00 90 7f af 00 f0 7e af 00 e0 7e af 
..........~...~.
  >   0040: 00 d0 7e af 00 b0 7e af 00 80 7e af 00 70 7e af 
..~...~...~..p~.
  >   0050: 00 60 7e af 00 50 7e af                          .`~..P~.
  >

Reference: some more tests are on debian's BTS: 
http://bugs.debian.org/648754

I would be happy to provide any help you would think necessary.

Salutations

Matthieu Dubuget


