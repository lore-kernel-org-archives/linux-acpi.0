From: Michael Wallner <mike@iworks.at>
Subject: sony-laptop: Which models need snc_enable?
Date: Tue, 03 Mar 2009 15:37:25 +0100
Message-ID: <gojfb4$j3a$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:36744 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753023AbZCCOhn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 3 Mar 2009 09:37:43 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LeVkV-0005Rb-OE
	for linux-acpi@vger.kernel.org; Tue, 03 Mar 2009 14:37:35 +0000
Received: from gate-g21.inqnet.at ([78.142.172.145])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Tue, 03 Mar 2009 14:37:35 +0000
Received: from mike by gate-g21.inqnet.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Tue, 03 Mar 2009 14:37:35 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Hi,

I wonder if the special snc_enable routines are only needed
for models with the SNY5001 device?

Mine has SNY6001 and SNY9001, so I wonder if I'd need
the snc_enable specific stuff too?

Thanks,
Mike

