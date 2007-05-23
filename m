From: "Peter Waller" <peter.waller@gmail.com>
Subject: brightness and fan states where there is no support?
Date: Wed, 23 May 2007 17:56:06 +0100
Message-ID: <d3d284ca0705230956v3f9ff1d5n6e5f888f52da726d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:22471 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756494AbXEWQ4J (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 23 May 2007 12:56:09 -0400
Received: by ug-out-1314.google.com with SMTP id j3so594335ugf
        for <linux-acpi@vger.kernel.org>; Wed, 23 May 2007 09:56:07 -0700 (PDT)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I'm running a little experiment and generally messing around with my laptop.

My computer is a Uniwill M31EI. Intel ICH7 chipset.

The main thing I would like to do is have a way to programatically
find out what the current brightness and fan states are. If I could
have some way of setting them, too, that would be a bonus.

/proc/acpi/video/IGD/LCD/brightness says 'not supported' and the 'fan'
directory lists no files.

out of curiousity, I have tried writing a program that searches the
first half-megabyte or so of /dev/mem and looks for changes (and
no-changes) on demand so I could try and see if the brightness or fan
states are in there somewhere. I may be doing something wrong, but as
best as I can tell they are not.

Is it possible to figure out a way of accessing such information
without the aid of the manufacturer? I'm not afraid to get my hands
dirty, if this requires disassembling things and such. Where should I
be looking, how do developers find such information?

Thanks in advance.

- Pete
