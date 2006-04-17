From: "Yu, Luming" <luming.yu@intel.com>
Subject: acpi hotkey sysfs support
Date: Mon, 17 Apr 2006 11:09:10 +0800
Message-ID: <554C5F4C5BA7384EB2B412FD46A3BAD1223969@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:49010 "EHLO
	azsmga101-1.ch.intel.com") by vger.kernel.org with ESMTP
	id S1750995AbWDQDJQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 16 Apr 2006 23:09:16 -0400
Content-class: urn:content-classes:message
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: sziwan@hell.org.pl, Stelian Pop <stelian@popies.net>, thoenig@suse.de, borislav@users.sf.net, john@neggie.net, tauber@informatik.hu-berlin.de
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hello all,

I have created a place under sysfs to have a unified place
to gather user input for common hotkey features. 
http://bugzilla.kernel.org/show_bug.cgi?id=5749#c10

All of you are owner of a specific acpi hotkey driver. 
Would you like to use that sysfs support to reduce the
unnecessary interface complexity.

Thanks a lot
Luming
