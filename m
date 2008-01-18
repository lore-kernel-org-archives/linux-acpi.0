From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode 2.9
Date: Fri, 18 Jan 2008 15:35:54 -0500
Message-ID: <200801181535.54522.lenb@kernel.org>
References: <4780BE66.8050605@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40418 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764619AbYARUgJ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2008 15:36:09 -0500
In-Reply-To: <4780BE66.8050605@gmx.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stefan Becker <zorak1103@gmx.de>
Cc: linux-acpi@vger.kernel.org


> System Information
>     Manufacturer: SAMSUNG ELECTRONICS CO., LTD.
>     Product Name: R59P/R60P/R61P
>     Version: 00YJ
>     Serial Number: 012Z93FP904750
>     UUID: C0974B31-D21D-B211-8000-FF06B87D96A9
>     Wake-up Type: Power Switch
>     SKU Number: Not Specified
>     Family: Not Specified

Does this system run any better or worse when booted with "acpi_osi=Linux"?

Please send me the output from acpidump.
If acpidump is not installed on your machine, you can find it
in pmtools here:
http://www.lesswatts.org/projects/acpi/utilities.php

thanks,
-Len
