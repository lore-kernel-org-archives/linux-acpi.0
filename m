From: Len Brown <lenb@kernel.org>
Subject: Ambient Light Sensor?
Date: Mon, 19 Mar 2007 13:41:41 -0400
Message-ID: <200703191341.41823.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37184 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966053AbXCSRnH (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 19 Mar 2007 13:43:07 -0400
Received: from d975xbx2.site (c-65-96-213-102.hsd1.ma.comcast.net [65.96.213.102])
	(authenticated bits=0)
	by hera.kernel.org (8.13.8/8.13.7) with ESMTP id l2JHfla6030377
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-acpi@vger.kernel.org>; Mon, 19 Mar 2007 17:43:02 GMT
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Has anybody seen ACPI-based ambient light sensor support on a commercial system?

You'd recognize it by a device with PNPid ACPI0008 exported via the AML device tree.

I've seen it on an Intel Capell Valley CRB, but I was wondering
if anybody is using it in the "real world" yet.

I've seen just the dmesg from a MacBook Pro on the web
suggesting that system exports ACPI0008:
http://www.uwsg.iu.edu/hypermail/linux/kernel/0703.0/1475.html

thanks,
-Len
