From: Len Brown <lenb@kernel.org>
Subject: Re: Re-add ibft tree to linux-next please
Date: Tue, 17 Jan 2012 09:08:30 -0500
Message-ID: <4F1580DE.1060002@kernel.org>
References: <20111212145330.GA16278@andromeda.dapyr.net> <4EE68D57.7030603@zytor.com> <20111213021536.GC2730@konrad-lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:52905 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753763Ab2AQOId (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 17 Jan 2012 09:08:33 -0500
In-Reply-To: <20111213021536.GC2730@konrad-lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad@darnok.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Konrad Rzeszutek Wilk <konrad@kernel.org>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, sfr@canb.auug.org.au, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, pjones@redhat.com


> The trick is that we also have to retain the code functionality if
> "# CONFIG_ACPI is not set" to scan the memory for the iBFT. That part
> should definitly _not_ be moved to drivers/acpi. It could be moved to
> arch/x86/ .. but it could also stay in drivers/firmware. <shrugs>


Are there really hardware/firmware configurations that support IBFT
and do not support ACPI?

If yes, do they require an OS that has CONFIG_ACPI=n?
Or would finding the table with CONFIG_ACPI=y and acpi_disabled=1
be sufficient?

-Len

