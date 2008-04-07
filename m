From: Alexey Starikovskiy <aystarik@gmail.com>
Subject: Re: ACPI
Date: Mon, 07 Apr 2008 23:26:48 +0400
Message-ID: <47FA7578.9060807@gmail.com>
References: <47FA51D0.10907@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:32244 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbYDGT0t (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 7 Apr 2008 15:26:49 -0400
Received: by fg-out-1718.google.com with SMTP id l27so1560963fgb.17
        for <linux-acpi@vger.kernel.org>; Mon, 07 Apr 2008 12:26:46 -0700 (PDT)
In-Reply-To: <47FA51D0.10907@freenet.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Lademann, Klaus" <azael@freenet.de>
Cc: linux-acpi@vger.kernel.org

Dear Klaus,

Lenovo 3000 N200 is not a ThinkPad, thus thinkpad_acpi fails to load, as 
it fails to
load on Dell, HP, etc.

Regards,
Alex.

Lademann, Klaus wrote:
> Dear Kernel.org - Team
>
> Thats my DMI -Text from Lenovo 3000 N200
> ~# dmesg
>
>
> ACPI: DMI System Vendor: LENOVO
> ACPI: DMI Product Name: 0769B3G
> ACPI: DMI Product Version: 3000 N200
> ACPI: DMI Board Name: IEL10
> ACPI: DMI BIOS Vendor: LENOVO
> ACPI: DMI BIOS Date: 04/18/2007
>
> I have interesting in thinkpad_acpi, but it is not running from
> linux-2.6.24 with
> error "no such device"
>
>   

