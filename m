From: Zaher Salman <zaher@triumf.ca>
Subject: slow susped to disk
Date: Mon, 03 Apr 2006 11:00:59 +0200
Message-ID: <4430E44B.7070003@triumf.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from trshare.triumf.ca ([142.90.100.191]:61899 "EHLO
	trshare.triumf.ca") by vger.kernel.org with ESMTP id S1750815AbWDCJBF
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 3 Apr 2006 05:01:05 -0400
Received: from [192.168.1.100] (87-7-ftth.onsnet.nu [84.35.7.87])
	(authenticated bits=0)
	by trshare.triumf.ca (8.12.11.20060308/8.12.10) with ESMTP id k33910MV028678
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Mon, 3 Apr 2006 02:01:03 -0700
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I upgraded the kernel from 2.6.15 to 2.6.16 on my presario 2100. Both 
kernels were compiled with the similar configuration files. Anyway I 
found that suspend to disk (and resume) is much slower on 2.6.16 
compared to 2.6.15. Any idea for why that might happen or how can I 
speed it up? There is also a big difference when suspending with the 
laptop plugged or not..

thanks
Zaher

-- 
Zaher Salman

TRIUMF
4004 Wesbrook Mall
Vancouver, B.C.
Canada V6T 2A3

Email: zaher@triumf.ca
Tel.: + 1 604 222 1047 ext. 6588
Fax:  + 1 604 222 1074 

