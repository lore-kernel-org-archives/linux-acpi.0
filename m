From: Cacy Rodney <cacy-rodney-cacy@tlen.pl>
Subject: suspend a device to save energy
Date: Mon, 13 Nov 2006 20:31:52 +0100
Message-ID: <4558C828.8060301@tlen.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx10.go2.pl ([193.17.41.74]:1158 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1755319AbWKMSaF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Nov 2006 13:30:05 -0500
Received: from [192.168.226.86] (imc.pcz.czest.pl [212.87.225.147])
	by poczta.o2.pl (Postfix) with ESMTP id 373815804E
	for <linux-acpi@vger.kernel.org>; Mon, 13 Nov 2006 19:30:04 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,
I tried to suspend a device (ide cdrom) to save energy in my laptop. I 
did it using:

echo -n 2 >/sys/devices/pci0000\:00/0000\:00\:1f.1/power/state

I have got a message in syslog that the device is suspended but no 
decrease of energy consumption. The configuration of the PCI was not 
changed. It seams that the device is off only for system but still 
physically enabled.  The question is: Does the ACPI is responsible for 
turning off the device (and how to do that) or I have to write extension 
for driver?

This is report of lspci for the device:

bash-3.00# lspci -xxx -s 0:1f.1
00:1f.1 IDE interface: Intel Corporation 82801G (ICH7 Family) IDE 
Controller (rev 02)
00: 86 80 df 27 05 00 80 02 02 8a 01 01 00 00 00 00
10: 01 00 00 00 01 00 00 00 01 00 00 00 01 00 00 00
20: 11 18 00 00 00 00 00 00 00 00 00 00 4d 10 e6 81
30: 00 00 00 00 00 00 00 00 00 00 00 00 ff 02 00 00
40: 07 a3 00 00 00 00 00 00 01 00 02 00 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 03 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 86 0f 02 00 00 00 00 00

As I said the suspend does not change anything. Contrary, windows 
operating system is able to shut down the device and it changes the 
state from:
(running)

PCI Bus 0
1f:1  8086:27df.02  Cmd[0005:i.b...]  Sts[0280:.....]  Intel IDE 
Controller  SubID:104d:81e6
      cf8:8000f900  IntPin:2  IntLine:ff  Rom:0  cis:0  cap:0
      IO[0]:1          IO[1]:1          IO[2]:1          
IO[3]:1          IO[4]:1811      
   00:  27df8086 02800005 01018a02 00000000
  10:  00000001 00000001 00000001 00000001
   20:  00001811 00000000 00000000 81e6104d
  30:  00000000 00000000 00000000 000002ff
  40: 0000a347 00000000 00020001 00000000
  50: 00000000 00000000 00000000 00000000
  60: 00000000 00000000 00000000 00000000
  70: 00000000 00000000 00000000 00000000
  80: 00000000 00000000 00000000 00000000
  90: 00000000 00000000 00000000 00000000
  a0: 00000000 00000000 00000000 00000000
  b0: 00000000 00000000 00000000 00000000
  c0: 00000000 00000003 00000000 00000000
  d0: 00000000 00000000 00000000 00000000
  e0: 00000000 00000000 00000000 00000000
  f0: 00000000 00000000 00020f86 00000000

to (disabled)

1f:1  8086:27df.02  Cmd[0000:......]  Sts[0288:.....]  Intel IDE 
Controller  SubID:104d:81e6
      cf8:8000f900  IntPin:2  IntLine:ff  Rom:0  cis:0  cap:0
      IO[0]:1          IO[1]:1          IO[2]:1          
IO[3]:1          IO[4]:1811      
  00:  27df8086 02880000 01018a02 00000000
  10:  00000001 00000001 00000001 00000001
  20:  00001811 00000000 00000000 81e6104d
  30:  00000000 00000000 00000000 000002ff
  40: 0000a345 00000000 00020001 00000000
  50: 00000000 00010000 00000000 00000000
  60: 00000000 00000000 00000000 00000000
  70: 00000000 00000000 00000000 00000000
  80: 00000000 00000000 00000000 00000000
  90: 00000000 00000000 00000000 00000000
  a0: 00000000 00000000 00000000 00000000
  b0: 00000000 00000000 00000000 00000000
  c0: 00000000 00000003 00000000 00000000
  d0: 00000000 00000000 00000000 00000000
  e0: 00000000 00000000 00000000 00000000
  f0: 00000000 00000000 00020f86 00000000

I found a recipt how to off the pci (intel manual for ich7-m) but I have 
no idea where it should be in ACPI (I donot know much about it) or in a 
driver.

Cacy
