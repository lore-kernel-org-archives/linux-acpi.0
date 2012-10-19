From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: weird code in acpi/osl.c that could be simplified?
Date: Fri, 19 Oct 2012 09:32:59 -0400 (EDT)
Message-ID: <alpine.DEB.2.02.1210190931370.3906@oneiric>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from astoria.ccjclearline.com ([64.235.106.9]:32925 "EHLO
	astoria.ccjclearline.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964873Ab2JSOf2 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 19 Oct 2012 10:35:28 -0400
Received: from cpe78cd8ec702a0-cm78cd8ec7029d.cpe.net.cable.rogers.com ([174.116.193.149]:45033 helo=crashcourse.ca)
	by astoria.ccjclearline.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.77)
	(envelope-from <rpjday@crashcourse.ca>)
	id 1TPChC-0001FR-F3
	for linux-acpi@vger.kernel.org; Fri, 19 Oct 2012 09:33:02 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org


  this from drivers/acpi/osl.c:

        if (queue == kacpi_hotplug_wq)
                INIT_WORK(&dpc->work, acpi_os_execute_deferred);
        else if (queue == kacpi_notify_wq)
                INIT_WORK(&dpc->work, acpi_os_execute_deferred);
        else
                INIT_WORK(&dpc->work, acpi_os_execute_deferred);

any reason all that can't be collapsed to a simple call to
INIT_WORK()?

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
