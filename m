From: AnandK <anand.kori@gmail.com>
Subject: =?utf-8?b?X0NQQw==?= info
Date: Fri, 15 Nov 2013 23:03:42 +0000 (UTC)
Message-ID: <loom.20131116T000311-462@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from plane.gmane.org ([80.91.229.3]:34614 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752476Ab3KOXUF (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Nov 2013 18:20:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glad-acpi-devel@m.gmane.org>)
	id 1VhSgF-0003aI-6X
	for linux-acpi@vger.kernel.org; Sat, 16 Nov 2013 00:20:03 +0100
Received: from zcce02cs1743-db20.houston.hp.com ([15.203.233.77])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sat, 16 Nov 2013 00:20:03 +0100
Received: from anand.kori by zcce02cs1743-db20.houston.hp.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Sat, 16 Nov 2013 00:20:03 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi All, 
I am try to write a driver for performance tuning. I am new to ACPI spec and 
going through this I need to get the performance values from the PCC subspace 
registers. I am trying to use acpi_read and by passing passing the info 
through Generic Address Register. 

By doing this I get an error saying Unknown Subspace Id. I do feel it is not 
the right way to get the register value and at the same point unable to 
understand how to do this. 

Could someone point me or give an idea how this should be made to work. 

Thanks, 
Anand

