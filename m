From: Brad Campbell <lists2009@fnarfbargle.com>
Subject: sony-laptop on VAIO TT help request
Date: Thu, 30 Jun 2011 18:07:30 +0800
Message-ID: <4E0C4AE2.2050706@fnarfbargle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fnarfbargle.com ([93.93.131.224]:49797 "EHLO fnarfbargle.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753062Ab1F3KHf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 30 Jun 2011 06:07:35 -0400
Received: from srv.homea
	([10.8.0.1] helo=localhost ident=heh11028)
	by fnarfbargle.com with esmtp (Exim 4.69)
	(envelope-from <lists2009@fnarfbargle.com>)
	id 1QcE9k-0007bD-Sy
	for linux-acpi@vger.kernel.org; Thu, 30 Jun 2011 11:07:33 +0100
Received: from bkmac.home ([192.168.2.87])
	by localhost with esmtp (Exim 4.72)
	(envelope-from <lists2009@fnarfbargle.com>)
	id 1QcE9i-0002rn-3K
	for linux-acpi@vger.kernel.org; Thu, 30 Jun 2011 18:07:30 +0800
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

G'day all,

I have a sony Vaio TT notebook. It works reasonably well with the 
sony-laptop kernel module excepting the following items

- No control over the optical drive power state
- No control over the "battery care" function in the embedded controller
- No control over the "quick charge" function

All three of these functions are sub-functions of the SNY6001 method 
call, just the same as the rfkill functions.

I've reverse engineered all three of them with the assistance of some 
damaged windows drivers and software. I'd like to add these functions 
into the sony-laptop module, but I've absolutely no idea where to start.

I can use the rfkill code as a working example to get me started on 
getting access to the required bits in ACPI, so I suppose I need some 
targeted questions to get any usable response.

1) The optical power functions are completely different from the current 
implementation (where specific method calls are made). I can't really 
figure out the best way to make the function I need have the same 
interface as the legacy functions "cd-power" sysfs file. Advice or ideas 
would be welcome.

2) Is there any precedent for how I might attempt to implement an 
interface to the battery care and quick charging functions?

Quick charge is easy, it's just a boolean, but the battery care is a bit 
more curly. On my machine it's relatively easy. It has 4 settings (off, 
50%, 80%, 100%) and various combinations of bits make it behave the same 
way. On off is just the LSB of the control byte, however the user space 
application leads me to believe there may be the possibility of 
individually setting these bits on batteries in machines that have more 
than one. I don't really want to paint myself into a corner, but then I 
don't really know what I'm doing anyway.

It would help _heaps_ if someone with a vaio that has (A) The battery 
care function, and (B) more than one place a battery can plug in, could 
send me a DSDT to examine.

Help, ideas or advice more than welcome.

Regards,
Brad
