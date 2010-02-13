From: Dariush Forouher <dariush@forouher.de>
Subject: Re: ACPI/ata regression with hotplugging the dvd drive
Date: Sat, 13 Feb 2010 19:40:37 +0100
Message-ID: <4B76F225.1090209@forouher.de>
References: <4B76D3E7.6000904@forouher.de> <4B76EE70.1060605@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:59218 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752195Ab0BMSki (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 13 Feb 2010 13:40:38 -0500
In-Reply-To: <4B76EE70.1060605@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Robert Hancock <hancockrwd@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi <linux-acpi@vger.kernel.org>

On 13.02.2010 19:24, Robert Hancock wrote:

> This lockdep error in dmesg looks suspicious. Does this match the point 
> where the DVD drive was inserted?

Yes, it does. Looking back through the logs, it appears sporadically since at
least 2.6.32, always when inserting the drive.

regards
Dariush
