From: "Cheng Renquan" <crquan@gmail.com>
Subject: HOWTO Get original DSDT?
Date: Thu, 4 Dec 2008 12:07:16 +0800
Message-ID: <91b13c310812032007w6db30ebekfa8e95931c5c17c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:16773 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750773AbYLDEHR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Dec 2008 23:07:17 -0500
Received: by nf-out-0910.google.com with SMTP id d3so2021228nfc.21
        for <linux-acpi@vger.kernel.org>; Wed, 03 Dec 2008 20:07:16 -0800 (PST)
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, lenb@kernel.org

Here we unfourtunately have many Dell Optiple 320 machines,

its hardware profile has been sent out to smolts:
http://www.smolts.org/client/show/pub_32cc3df5-67af-42e9-806a-20dd25f47757

It have notorious ACPI support problem, almost all Linux distros cannot run well
on this hardware (CDROM cannot boot, or cannot install,
or can install but cannot boot from hard disk)
except a China Linux distro RedFlag 5.0 (it runs with ACPI enabled
well, but why?)

some distros can run with acpi=off on it,

Today I found the article on override DSDT, I think this may solve this problem,

http://www.lesswatts.org/projects/acpi/overridingDSDT.php

But with this section,

How to Build a custom DSDT into the kernel

   1. Get original DSDT:

      # cp /proc/acpi/dsdt DSDT

      or

      # acpidump > acpidump.out

The problem is how to get /proc/acpi/dsdt with acpi=off?

if boot without "acpi=off", the kernel will hang, reproduce always,
if boot with "acpi=off", there's no /proc/acpi nor
/sys/devices/platform/acpi/...

So the problem is:

Is there any other approach to get the DSDT?

-- 
Cheng Renquan, Shenzhen, China
Jim Bishop  - "Golf is played by twenty million mature American men
whose wives think they are out having f...
