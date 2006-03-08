From: Len Brown <len.brown@intel.com>
Subject: acpi slab consumption
Date: Wed, 8 Mar 2006 02:14:08 -0500
Message-ID: <200603080214.10132.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fmr22.intel.com ([143.183.121.14]:32986 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S1752022AbWCHHOQ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 8 Mar 2006 02:14:16 -0500
Received: from scsfmr101.sc.intel.com (scsfmr101.sc.intel.com [10.3.253.10])
	by scsfmr002.sc.intel.com (8.12.10/8.12.10/d: major-outer.mc,v 1.1 2004/09/17 17:50:56 root Exp $) with ESMTP id k287EEQu004878
	for <linux-acpi@vger.kernel.org>; Wed, 8 Mar 2006 07:14:14 GMT
Received: from fmssmxvs041.fm.intel.com (fmssmxvs041.fm.intel.com [132.233.42.126])
	by scsfmr101.sc.intel.com (8.12.10/8.12.10/d: major-inner.mc,v 1.2 2004/09/17 18:05:01 root Exp $) with SMTP id k2878e8V030919
	for <linux-acpi@vger.kernel.org>; Wed, 8 Mar 2006 07:08:40 GMT
Received: from intel.com ([10.127.52.93])
 by fmssmxvs041.fm.intel.com (SAVSMTP 3.1.7.47) with SMTP id M2006030723141313545
 for <linux-acpi@vger.kernel.org>; Tue, 07 Mar 2006 23:14:13 -0800
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Anybody interested in auditing ACPI slab usage?

ftp.linux.org.uk/pub/people/viro/slab-leaks.patch

with CONFIG_DEBUG_SLAB_LEAK

creates /proc/slab_allocators

cheers,
-Len


