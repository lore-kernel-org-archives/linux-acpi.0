From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: ACPI support in Linux?
Date: Sun, 19 Oct 2008 18:50:59 +0400
Message-ID: <48FB4953.2050809@gmail.com>
References: <f188924b0810190404j17e7cb7bo970c7f73ef54fc5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:54863 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751345AbYJSOvD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 19 Oct 2008 10:51:03 -0400
Received: by ug-out-1314.google.com with SMTP id k3so479905ugf.37
        for <linux-acpi@vger.kernel.org>; Sun, 19 Oct 2008 07:51:02 -0700 (PDT)
In-Reply-To: <f188924b0810190404j17e7cb7bo970c7f73ef54fc5a@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Fred ." <eldmannen@gmail.com>
Cc: linux-acpi@vger.kernel.org


Fred . wrote:
> Which version of the ACPI spec does Linux support?
> Is it true that it only supports 2.0?
>
>   
Linux supported 3.0b well before it was published.
See include/acpi/acconfig.h:
/* Version of ACPI supported */
#define ACPI_CA_SUPPORT_LEVEL           3
> ACPI specification, 3.0b, been out since October 10, 2006.
> Linux still does not have support for it?
>   
Do you see any feature not implemented of what?

Regards,
Alex.

