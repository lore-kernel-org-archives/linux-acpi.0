From: Tom Kirkpatrick <stv@kirkconsulting.co.uk>
Subject: USB wakeup
Date: Thu, 24 Aug 2006 20:33:38 +0100
Message-ID: <12E5FB73-D7F1-4AD8-8C0F-71A8830986A5@kirkconsulting.co.uk>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from red.mydnspages.com ([207.150.176.20]:45130 "EHLO
	red.mydnspages.com") by vger.kernel.org with ESMTP id S1751675AbWHXTdq
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 24 Aug 2006 15:33:46 -0400
Received: from 81-179-24-207.dsl.pipex.com ([81.179.24.207] helo=tom-kirkpatricks-powerbook-g4-15.local)
	by red.mydnspages.com with esmtpa (Exim 4.52)
	id 1GGKxN-0005TB-NV
	for linux-acpi@vger.kernel.org; Thu, 24 Aug 2006 15:33:37 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I have ACPI USB wakeup working on an X86 box. I'm running the stock  
2.6.12 kernel. My end goal is to be able to wake the machine up from  
S3 by pressing a button on my remote control (ATI Remote Wonder).  
This device has a usb transiever.  I have enabled USB wakeup:

echo "EUSB" > /proc/acpi/wakeup
echo "USB" > /proc/acpi/wakeup
echo "USB2" > /proc/acpi/wakeup
echo "USB3" > /proc/acpi/wakeup

root@STV:~$ cat /proc/acpi/wakeup
Device  Sleep state     Status
PCI0       4            disabled
UAR1       4            disabled
UAR2       4            disabled
UAR3       4            disabled
UAR4       4            disabled
PS2K       4            disabled
EUSB       4             enabled
USB       4             enabled
USB2       4             enabled
USB3       4             enabled
S139       4            disabled
AC97       4            disabled
MC97       4            disabled
LAN0       4            disabled
PWRB       4            *enabled

and after doing this, I can wake the machine up by either unplugging  
or plugging in a USB device, but pressing the buttons on the remote  
do not seem to wake the machine up. I also tried with a USB mouse,  
and either moving the mouse or clicking any of it's buttons will wake  
the machine up (although unplugging it or plugging it in does). I  
have "Resume from USB" enabled in my BIOS (although I think this is  
actually reffering to APM). The machine is a mini-itx NXS7M mobo with  
an AMIBIOS (from 1999 I think).

I won't go into too much more detail here as my first question is a  
simple one... Is it possible to achieve what I am trying to achieve?  
Do I need a later kernel? or some patches perhaps?

thanks in advance
Tom
