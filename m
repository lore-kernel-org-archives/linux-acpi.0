From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [2.624-rc1 regression] lost battery information
Date: Sat, 27 Oct 2007 20:59:37 +0400
Message-ID: <47236E79.3060707@gmail.com>
References: <200710262024.06012.arvidjaar@mail.ru> <200710271855.52866.arvidjaar@mail.ru> <47235727.30808@gmail.com> <200710272049.11969.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:15448 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754876AbXJ0RAA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 27 Oct 2007 13:00:00 -0400
Received: by ug-out-1314.google.com with SMTP id z38so816485ugc
        for <linux-acpi@vger.kernel.org>; Sat, 27 Oct 2007 09:59:58 -0700 (PDT)
In-Reply-To: <200710272049.11969.arvidjaar@mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Frans Pop <elendil@planet.nl>

Andrey Borzenkov wrote:
> On Saturday 27 October 2007, Alexey Starikovskiy wrote:
>> As you wish... :) Please check the attached patch.
>>
> 
> Not sure why you need to reimplement acpi_extract_package, but ...
Take a look on memory allocations around it... :)
> 
> Tested-by: Andrey Borzenkov <arvidjaar@mail.ru>

