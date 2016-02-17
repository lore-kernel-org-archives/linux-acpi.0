From: Jean Delvare <jdelvare@suse.de>
Subject: aer_inject vs. apei/einj
Date: Wed, 17 Feb 2016 14:33:06 +0100
Message-ID: <20160217143306.6340c6cf@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:56345 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423002AbcBQNdJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 17 Feb 2016 08:33:09 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-acpi@vger.kernel.org

Hi all,

I am looking for some guidance regarding AER testing. I see that we
have two different drivers for error injection in the kernel:
aer_inject and apei/einj. The user-space aer-inject tool seems to only
care about the former.

How does one know which driver should be used on a given system? I
suppose that only one of them will work on a given system?

My impression is that aer_inject is for "native" AER handling while
apei/einj is for ACPI-driven AER. Is it correct? If not I would
appreciate some pointers explaining when aer_inject should be used and
when apei/einj should be used.

Thanks,
-- 
Jean Delvare
SUSE L3 Support
