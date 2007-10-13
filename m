From: Dave Jones <davej@redhat.com>
Subject: dmidecode mails.
Date: Sat, 13 Oct 2007 13:48:36 -0400
Message-ID: <20071013174835.GF18760@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.redhat.com ([66.187.237.31]:36493 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754062AbXJNAPW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 13 Oct 2007 20:15:22 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx2.redhat.com (8.13.1/8.13.1) with ESMTP id l9E0E5X3017730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Sat, 13 Oct 2007 20:15:22 -0400
Received: from gelk.kernelslacker.org (vpn-14-8.rdu.redhat.com [10.11.14.8])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l9DHma4U000634
	for <linux-acpi@vger.kernel.org>; Sat, 13 Oct 2007 13:48:36 -0400
Received: from gelk.kernelslacker.org (localhost.localdomain [127.0.0.1])
	by gelk.kernelslacker.org (8.14.1/8.13.8) with ESMTP id l9DHmajo031140
	for <linux-acpi@vger.kernel.org>; Sat, 13 Oct 2007 13:48:36 -0400
Received: (from davej@localhost)
	by gelk.kernelslacker.org (8.14.1/8.14.1/Submit) id l9DHmamG031139
	for linux-acpi@vger.kernel.org; Sat, 13 Oct 2007 13:48:36 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

The last month or so, we've seen lots of people posting
their dmidecode output here (in response to seeing requests
for it in dmesg, if their BIOS requests _OSI(Linux) I guess)

I'm wondering if anyone is actually looking at these, because
I don't think I've seen a single follow up to any of them.

Given we're about to do a Fedora release with this printk,
I'm contemplating removing it, because we're going to be
getting them for a long time after upstream removed the printk
otherwise.  Unless someone sees value in continuing to get
the reports ?

	Dave

-- 
http://www.codemonkey.org.uk
