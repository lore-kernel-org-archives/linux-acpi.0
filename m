From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: [PATCH] eeepc-laptop: fix hot-unplug on resume
Date: Mon, 29 Jun 2009 15:22:47 +0100
Message-ID: <4A48CE37.3000104@tuffmail.co.uk>
References: <4A48A196.3060409@tuffmail.co.uk> <200906291616.57440.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-1920.google.com ([74.125.78.150]:5425 "EHLO
	ey-out-1920.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373AbZF2OWr (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 29 Jun 2009 10:22:47 -0400
In-Reply-To: <200906291616.57440.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Corentin Chary <corentincj@iksaif.net>, linux acpi <linux-acpi@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>

Rafael J. Wysocki wrote:
> On Monday 29 June 2009, Alan Jenkins wrote:
>   
>> The patch below fixes a regression introduced by the rfkill rewrite. 
>> Please consider it for inclusion in 2.6.31 via the ACPI tree.
>>     
>
> Is there a Bugzilla # for this regression?
>
> Rafael
>   

No.

I found it in testing, a few days after I'd submitted the change myself :-/.

Thanks
Alan
