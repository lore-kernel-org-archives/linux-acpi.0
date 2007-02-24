From: Len Brown <lenb@kernel.org>
Subject: Re: First battery not detected with 2.6.21-rc1
Date: Fri, 23 Feb 2007 22:57:09 -0500
Message-ID: <200702232257.09629.lenb@kernel.org>
References: <45DF428A.8070700@tzi.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43616 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933364AbXBXD7O (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 Feb 2007 22:59:14 -0500
In-Reply-To: <45DF428A.8070700@tzi.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Janosch Machowinski <scotch@tzi.de>
Cc: linux-acpi@vger.kernel.org

> AE_AML_OPERAND_VALUE

Please open a bug report here:
http://bugzilla.kernel.org/enter_bug.cgi?product=ACPI

and please attach (don't paste) the complete output from dmesg -s64000
plus the output from acpidump > acpidump.out.
If you don't have acpidump, you can get it from the latest pmtools here:
http://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/utils/

thanks,
-Len
