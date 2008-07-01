From: Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH 1/7] ACPI: thinkpad-acpi: minor refactor on radio switch
 init
Date: Tue, 01 Jul 2008 20:44:48 +0200
Message-ID: <486A7B20.4020502@firstfloor.org>
References: <1214936875-4812-1-git-send-email-hmh@hmh.eng.br> <1214936875-4812-2-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from one.firstfloor.org ([213.235.205.2]:59745 "EHLO
	one.firstfloor.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758229AbYGASow (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Jul 2008 14:44:52 -0400
In-Reply-To: <1214936875-4812-2-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net

Henrique de Moraes Holschuh wrote:
> Change the code of hotkey_init, wan_init and bluetooth_init a bit to make it
> much easier to add some Kconfig-selected debugging code later.

The later seems to be wrong, the debugging code is already included?

Description seems to be incomplete.

-Andi
