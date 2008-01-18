From: Len Brown <lenb@kernel.org>
Subject: Re: dmidecode output (Inspiron 1501)
Date: Fri, 18 Jan 2008 17:11:26 -0500
Message-ID: <200801181711.26862.lenb@kernel.org>
References: <20071122180342.4b827e8e@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:34294 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761214AbYARWLq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2008 17:11:46 -0500
In-Reply-To: <20071122180342.4b827e8e@mail.ru>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: =?utf-8?q?=D0=A1=2E=D0=9A=2E?= <9039145715@mail.ru>
Cc: linux-acpi@vger.kernel.org

> 	Manufacturer: Dell Inc.
>	Product Name: Inspiron 1501 

With 2.6.22, did you notice any functional difference with "acpi_osi=!Linux"?

(or since the default changed at 2.6.23, with 2.6.23 or later
 do you notice any difference with "acpi_osi=Linux"?)

Please send me the output from acpidump.
If you don't have acpidump, you can get it from pmtools here:
http://www.lesswatts.org/projects/acpi/utilities.php

thanks,
-Len
