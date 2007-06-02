From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] _TPC,_TSS,_PTC support
Date: Sat, 2 Jun 2007 00:35:44 -0400
Message-ID: <200706020035.44136.lenb@kernel.org>
References: <3877989d0705260749y1fd55beau899f25b39e881d5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:43004 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751570AbXFBEfw (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 2 Jun 2007 00:35:52 -0400
In-Reply-To: <3877989d0705260749y1fd55beau899f25b39e881d5a@mail.gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Luming Yu <luming.yu@gmail.com>
Cc: linux-acpi@vger.kernel.org

a couple places use local_irq_disable/local_irq_enable

but it isn't obvious why interrupts need to be disabled.
also, wouldn't it be safer to use local_irq_save/local_irq_restore
in the event the code is used with interrupts off?

Applied to acpi-test (and then Lindented:-)

thanks,
-Len
