From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Subject: Re: 2.6.24-rc2-mm1: undefined reference to `local_apic_timer_c2_ok'
Date: Fri, 16 Nov 2007 00:35:58 +0100
Message-ID: <200711160036.00595.m.kozlowski@tuxland.pl>
References: <20071113175906.497a1a6a.akpm@linux-foundation.org> <200711152325.36541.m.kozlowski@tuxland.pl> <200711151749.03950.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:1263 "EHLO
	tuxland.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754774AbXKOXgR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 15 Nov 2007 18:36:17 -0500
In-Reply-To: <200711151749.03950.lenb@kernel.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hello,

> > local_apic_timer_c2_ok
> 
> hmm, looks like you're missing CONFIG_X86_LOCAL_APIC
> so does this go away when you add CONFIG_SMP
> or CONFIG_X86_UP_APIC?

Yes it does. In both cases.

Regards,

	Mariusz
