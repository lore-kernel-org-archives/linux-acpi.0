From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [PATCH 091/171] ACPI: GPE enabling should happen after	EC	installation
Date: Sun, 04 May 2008 10:40:42 +0400
Message-ID: <481D5A6A.4060603@suse.de>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>	 <1209551134.12515.47.camel@yakui_zhao.sh.intel.com>	 <200804300758.54778.carlos@strangeworlds.co.uk>	 <200804300817.53800.carlos@strangeworlds.co.uk>	 <1209573782.16111.32.camel@yakui_zhao.sh.intel.com>	 <4818441D.2010800@suse.de> <1209896900.28197.65.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:44683 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752008AbYEDGku (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 4 May 2008 02:40:50 -0400
In-Reply-To: <1209896900.28197.65.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Carlos Corbacho <carlos@strangeworlds.co.uk>, linux-acpi@vger.kernel.org, Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>

Zhao Yakui wrote:
> But after the patch is applied, it seems that we make a lot of changes
> about the GPE initialization flowchart in ACPICA.
And this flowchart is cast in stone?
> Will these be easily accepted by ACPICA author?
You should probably ask him, not me. We are talking Bob Moore here, yes?
Why don't you add CC to him if you are worried?
> At the same time some RUNTIME GPEs will be enabled twice. When
> acpi_enable_gpe is called in the course of EC installation, some RUNTIME
> GPEs will also be enabled. In fact when the acpi_ev_install_fadt_gpes is
> called, all the RUNTIME GPEs will be enabled. In such case it brings
> that some RUNTIME GPEs are enabled twice. Of course the patch should
> work fine if it is safe to enable RUNTTME GPEs twice.
Please advise me, how we are not enabling them twice if EC init happens after?
The same acpi_enable_gpe will be called from it.

Regards,
Alex.
