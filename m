From: Ken Perl <kenperl@gmail.com>
Subject: FAN Processor and Thermap
Date: Thu, 19 Mar 2009 16:18:13 +0800
Message-ID: <335b7d740903190118r32d6f4d4ia9146bf2f0d9f6f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.234]:59109 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067AbZCSISO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Mar 2009 04:18:14 -0400
Received: by rv-out-0506.google.com with SMTP id f9so452821rvb.1
        for <linux-acpi@vger.kernel.org>; Thu, 19 Mar 2009 01:18:13 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

After I replaced my mainboard, then I can see errors related to ACPI
during the Linux booting, I can also reproduce it with command below,

moproble fan processor thermap

I got error "no such device",  I ever tried to append following lines
to the /etc/modprobe.d/blacklist but can not succeed, I can still see
same error during boot, another error is "ACPI unable to load system
description tables",

blacklist fan
blacklist processor
blacklist thermap

Do these a big problem? Can anyone tell how I can fix the issue?

-- 
perl -e 'print unpack(u,"62V5N\"FME;G\!E<FQ`9VUA:6PN8V]M\"\@``
")'
