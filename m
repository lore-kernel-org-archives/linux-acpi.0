From: Neal Becker <ndbecker2@gmail.com>
Subject: 2.6.16-rc2 panic acpi (hpdv8000)
Date: Mon, 06 Feb 2006 09:00:01 -0500
Message-ID: <ds7kp0$5mp$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:43905 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932124AbWBFOWc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 6 Feb 2006 09:22:32 -0500
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1F67FU-0007t2-5f
	for linux-acpi@vger.kernel.org; Mon, 06 Feb 2006 15:21:50 +0100
Received: from nat-expu-252-168.hns.com ([139.85.252.168])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Mon, 06 Feb 2006 15:21:48 +0100
Received: from ndbecker2 by nat-expu-252-168.hns.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-acpi@vger.kernel.org>; Mon, 06 Feb 2006 15:21:48 +0100
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

I get a panic immediately on boot with 2.6.16-rc2.  I have captured a picture here:
https://bugzilla.redhat.com/bugzilla/attachment.cgi?id=124152&action=view

