From: "Lincoln Baxter, III" <lincolnbaxter@gmail.com>
Subject: Re: HP nc6400 v.03 or v.05 laptop ACPI fails after reboot, works
 again after booting windows
Date: Fri, 15 Dec 2006 17:35:37 -0500
Message-ID: <45832339.3050307@gmail.com>
References: <457F37C0.3090003@gmail.com>	 <1165966936.29844.37.camel@pcjc2lap>  <457FB1A1.2030602@gmail.com>	 <1166012707.22903.4.camel@pcjc2lap>  <4582A607.8040302@gmail.com> <1166191807.7459.16.camel@pcjc2lap>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.239]:36936 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750896AbWLOWfk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Dec 2006 17:35:40 -0500
Received: by wx-out-0506.google.com with SMTP id h27so795799wxd
        for <linux-acpi@vger.kernel.org>; Fri, 15 Dec 2006 14:35:39 -0800 (PST)
In-Reply-To: <1166191807.7459.16.camel@pcjc2lap>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Update:

Kernel 2.6.18-r4

I've done some more testing, and I've narrowed the problem down to the 
"processor" cpu driver.
I disabled all power management features in the kernel, and compiled 
ACPI as modules so that they would not be loaded until I wanted them to be.

APM is off.
CPU Frequency Scaling is off.
ACPI is compiled entirely as modules to be loaded by the user.

While running on the battery:
As soon as I "modprobe processor" the humming begins, and as soon as I 
"rmmod processor" the humming stops.

While running on AC, if I "modprobe processor" there is no buzzing. I 
can remove the AC adapter and the computer remains silent.

It seems to be something related to the way that the processor driver is 
handling power to the CPU. Ideas?
