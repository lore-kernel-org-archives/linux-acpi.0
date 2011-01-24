From: Phillip Susi <psusi@cfl.rr.com>
Subject: Auto load of coretemp and pkgtemp
Date: Mon, 24 Jan 2011 12:54:17 -0500
Message-ID: <4D3DBCC9.7000804@cfl.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.121]:42480 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753529Ab1AXRyG (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Jan 2011 12:54:06 -0500
Received: from cdptpa-omtalb.mail.rr.com ([10.127.143.51])
          by cdptpa-qmta02.mail.rr.com with ESMTP
          id <20110124175405555.QKAM27091@cdptpa-qmta02.mail.rr.com>
          for <linux-acpi@vger.kernel.org>; Mon, 24 Jan 2011 17:54:05 +0000
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I recently built a new sandybridge system and was surprised to find that
I had to manually load the coretemp and pkgtemp modules to monitor the
cpu temperature.  My last few systems have been AMD where the k8temp
module is automatically loaded.  It seems k8temp has a modalias that
gets it loaded on the correct hardware, but coretemp and pkgtemp have no
alias.  Why is this, and how can I construct a proper alias to get the
intel modules to auto load?
