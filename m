From: "xavier.gnata@gmail.com" <xavier.gnata@gmail.com>
Subject: macbook air 2013 boot stuck at "smpboot: Booting Node 0, Processors
 #1"
Date: Tue, 23 Jul 2013 00:56:48 +0200
Message-ID: <51EDB8B0.5000101@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ea0-f174.google.com ([209.85.215.174]:58629 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387Ab3GVW4u (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 22 Jul 2013 18:56:50 -0400
Received: by mail-ea0-f174.google.com with SMTP id o10so4065788eaj.19
        for <linux-acpi@vger.kernel.org>; Mon, 22 Jul 2013 15:56:48 -0700 (PDT)
Received: from ?IPv6:2001:a60:2514:1901:223:14ff:fe22:3e48? ([2001:a60:2514:1901:223:14ff:fe22:3e48])
        by mx.google.com with ESMTPSA id n45sm54387160eew.1.2013.07.22.15.56.47
        for <linux-acpi@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 22 Jul 2013 15:56:48 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

Vanila kernels 3.9.11, 3.10.2 and 3.11-rc2 don't boot on a macbook air 2013.
They get completely stuck early at "smpboot: Booting Node 0, Processors #1"
See https://launchpadlibrarian.net/145295798/3.11-rc1_boot_stuck.jpg

acpi=off does not help because then it crashes most of the time in 
clockevents_config
Screenshot and dump of the hardware config at 
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/1197451

What else could help to know were the problem is?

Xavier
