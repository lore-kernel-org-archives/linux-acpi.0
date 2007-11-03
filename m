From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: [PATCH] 2.6.24: make /proc/acpi/ac_adapter dependent on ACPI_PROCFS
Date: Sat, 03 Nov 2007 13:09:00 +0300
Message-ID: <472C48BC.30809@gmail.com>
References: <200710302321.19497.arvidjaar@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:64446 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756469AbXKCKJH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 3 Nov 2007 06:09:07 -0400
Received: by ug-out-1314.google.com with SMTP id z38so719096ugc
        for <linux-acpi@vger.kernel.org>; Sat, 03 Nov 2007 03:09:05 -0700 (PDT)
In-Reply-To: <200710302321.19497.arvidjaar@mail.ru>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrey Borzenkov <arvidjaar@mail.ru>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Andrey Borzenkov wrote:
> Let's make it consistent with battery code; also it fixes HAL case of 
> duplicated adapters. Somebody will have to sort out HAL with ACPI_PROCFS 
> case ...
>
> -andrey
>   
Andrey,
Please excuse me, I mis-understood your comment, and thought that you 
are trying to
do AC adapter register/unregister at on/off.

Acked-by: Alexey Starikovskiy <astarikovskiy@suse.de>
