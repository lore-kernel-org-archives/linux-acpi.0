From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 6/9] ACPI: thinkpad-acpi: add sysfs support to fan subdriver
Date: Wed, 25 Apr 2007 01:58:18 -0400
Message-ID: <200704250158.18297.lenb@kernel.org>
References: <11774261003184-git-send-email-hmh@hmh.eng.br> <11774261011195-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:38046 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423218AbXDYGGV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Apr 2007 02:06:21 -0400
In-Reply-To: <11774261011195-git-send-email-hmh@hmh.eng.br>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org

I'm glad to see the proc->sysfs conversion.
I'm glad to see compatibility with hwmon.
I think it will be handy to read fan speed.

I'm doubtful about the utility of setting fan speed.
It seems like it is enough rope for users to hang themselves,
and the need for a "safety net" seems to confirm that.

-Len
