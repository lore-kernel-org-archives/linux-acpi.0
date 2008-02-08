From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Laptop driver documentation
Date: Fri, 8 Feb 2008 13:24:51 +0000
Message-ID: <200802081324.52405.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:40497 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752912AbYBHNZJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Feb 2008 08:25:09 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

I'm currently working on producing some documentation for acer-wmi, but before 
submitting it, I'm wondering where the best place in Documentation/ is for it 
to live?

The only other laptop driver I've seen so far in Documentation/ is 
thinkpad-acpi, which has thinkpad-acpi.txt in the top level directory, but 
I'm not sure this is the best place for these to live. Would it be better to 
perhaps group all laptop driver documentation in something like 
Documentation/laptops/ (or something else along those lines), or should they 
just be left in the top-level Documentation?

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
