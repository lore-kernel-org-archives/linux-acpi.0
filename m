From: Janosch Machowinski <scotch@tzi.de>
Subject: annoying fan problem
Date: Tue, 21 Feb 2006 01:04:14 +0100
Message-ID: <43FA58FE.80700@tzi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-bremen.de ([134.102.201.18]:11154 "EHLO
	informatik.uni-bremen.de") by vger.kernel.org with ESMTP
	id S1161200AbWBTX54 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 20 Feb 2006 18:57:56 -0500
Received: from [192.168.0.1] (dslc-082-082-066-139.pools.arcor-ip.net [82.82.66.139])
	(authenticated bits=0)
	by informatik.uni-bremen.de (8.13.4/8.13.2) with ESMTP id k1KNveed011599
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Tue, 21 Feb 2006 00:57:53 +0100 (CET)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hey folks,
I got an annoying problem with my fan, when I boot the system,
it is allways on, with full speed. If I start compiling some stuff,
or use BurnP6 to get the CPU over 65 degrees, the fan starts
to behave right and goes into passive mode on cooldown.
The notebook is an Asus M68Ne and has the latest bios installed.
cat trip_points shows :
critical (S5):           105 C
passive:                 100 C: tc1=2 tc2=10 tsp=100 devices=0xc14d5ea0

cat cooling_mode
<setting not supported>
cooling mode:   passive

Any ideas ?
Thanks
      Janosch



