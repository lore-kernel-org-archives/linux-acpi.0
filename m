From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Lenovo ThinkPads need acpi_osi="Linux"
Date: Sat, 12 Jan 2008 15:49:16 +0000
Message-ID: <20080112154916.6bca2395@lxorguk.ukuu.org.uk>
References: <20080112022348.GC27524@khazad-dum.debian.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:52992 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751613AbYALPvw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 Jan 2008 10:51:52 -0500
In-Reply-To: <20080112022348.GC27524@khazad-dum.debian.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

> Now, what should we do about it?  Add a quirk to always define the Linux OSI
> string on ThinkPads (based on DMI information)?  All IBM ones (which won't
> have BIOS revisions anymore, anyway) deal well with it, and Lenovo ones
> seem to benefit from it.

If Lenovo systems do the right thing then I guess submit a patch which
checks for a DMI identifier string for Lenovo and if so don't lie to the
ACPI interpreter.

Alan
