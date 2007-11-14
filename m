From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [PATCH] ACPI: Battery: remove cycle from battery removal.
Date: Thu, 15 Nov 2007 00:06:28 +0300
Message-ID: <473B6354.3090700@suse.de>
References: <20071114175416.17650.71659.stgit@localhost.localdomain> <200711142221.57469.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:34219 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755105AbXKNVGv (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Wed, 14 Nov 2007 16:06:51 -0500
In-Reply-To: <200711142221.57469.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: LenBrown <lenb@kernel.org>, Linux-acpi@vger.kernel.org

Rafael J. Wysocki wrote:
> On Wednesday, 14 of November 2007, Alexey Starikovskiy wrote:
>> get_property() should not call battery_update(),
>> it also should call get_status() only if battery is present to
>> avoid cycle and oops.
>>
>> Signed-off-by: Alexey Starikovskiy <astarikovskiy@suse.de>
>> Tested-by: Rolf Eike Beer <eike-kernel@sf-tec.de>
>> Acked-by: Johannes Weiner <hannes@saeurebad.de>
> 
> It looks like this patch has been merged as commit
> 9104476e4efbef8a8e32d48ced583603ff32a2db
Yes, I noticed.

Thanks,
Alex.
