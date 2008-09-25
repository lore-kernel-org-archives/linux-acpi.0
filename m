From: Sitsofe Wheeler <sitsofe@yahoo.com>
Subject: Re: Reading EeePC900 battery info causes stalls
Date: Thu, 25 Sep 2008 18:30:27 +0100
Message-ID: <48DBCAB3.8020306@yahoo.com>
References: <gbduo8$nj4$1@ger.gmane.org> <48DB5032.8020604@gmail.com> <48DB5B90.9060607@yahoo.com> <48DB5FEE.4000404@gmail.com> <48DB710A.2060206@gmail.com> <48DB7C5A.6070900@yahoo.com> <48DB7D91.4000206@gmail.com> <48DBA6E4.80008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ptb-relay02.plus.net ([212.159.14.146]:48537 "EHLO
	ptb-relay02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503AbYIYRaW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 25 Sep 2008 13:30:22 -0400
In-Reply-To: <48DBA6E4.80008@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <aystarik@gmail.com>
Cc: linux-acpi@vger.kernel.org

Alexey Starikovskiy wrote:
> Ok, here is the ACPICA-friendly patch, please check if it's still good.

I've tested it and it seems good enough to prevent music playing in 
rhythmbox being interrupted by battery checking. There are cases where 
you can still detect stalling (e.g. while playing games and the battery 
is read) but it's brought latency down from 3232905us to 13900us on a 
desktop kernel which is significant in and of itself.

Tested-by: Sitsofe Wheeler <sitsofe@yahoo.com>

-- 
Sitsofe | http://sucs.org/~sits/
