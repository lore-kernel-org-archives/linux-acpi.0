From: Len Brown <lenb@kernel.org>
Subject: linux kernel release cycle
Date: Wed, 12 Sep 2007 23:12:18 -0400
Message-ID: <200709122312.18542.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38714 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755832AbXIMDMa (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Wed, 12 Sep 2007 23:12:30 -0400
Received: from d975xbx2 (c-65-96-213-102.hsd1.ma.comcast.net [65.96.213.102])
	(authenticated bits=0)
	by hera.kernel.org (8.13.8/8.13.8) with ESMTP id l8D3CNHI022943
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <Linux-acpi@vger.kernel.org>; Thu, 13 Sep 2007 03:12:24 GMT
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux-acpi@vger.kernel.org

At the kernel summit, Linus made it quite clear that
he wants almost all changes from sub-system trees (like ACPI)
in the beginning of the 2-week merge window -- preferably the 1st day.

He wants no-function-change cleanups to happen in the merge window too,
though I got the impression that later in the merge window was acceptable for those,
unless your name is Andrew Morton who can push those in rc2.

After rc1 is declared, we should be pushing upstream nothing but bug fixes --
with the focus on regression bug fixes.

This means that if you want to push any feature-related patches
in 2.6.24, I basically need them in my test tree now -- 2.6.23-rc6.

thanks,
-Len
