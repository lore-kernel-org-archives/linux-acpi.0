From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: eeepc-laptop: bugreport
Date: Sun, 15 Nov 2009 17:07:22 +0000
Message-ID: <4B00354A.7000300@tuffmail.co.uk>
References: <cone.1258203372.445001.1633.1000@eeekiste> <71cd59b00911140641i1502e95bt81d87db848feaf0@mail.gmail.com> <cone.1258211472.464906.1633.1000@eeekiste> <71cd59b00911150139i5d7377cawda04a17e5e50d05e@mail.gmail.com> <cone.1258285991.924736.2588.1000@eeekiste> <4AFFF61E.6090707@tuffmail.co.uk> <cone.1258301205.852230.1663.1000@eeekiste> <4B002951.4080704@tuffmail.co.uk> <cone.1258304218.643429.1671.1000@eeekiste>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.25]:42969 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751865AbZKORHT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Nov 2009 12:07:19 -0500
Received: by ey-out-2122.google.com with SMTP id 9so1665167eyd.19
        for <linux-acpi@vger.kernel.org>; Sun, 15 Nov 2009 09:07:24 -0800 (PST)
In-Reply-To: <cone.1258304218.643429.1671.1000@eeekiste>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: andrej.gelenberg@udo.edu
Cc: Corentin Chary <corentin.chary@gmail.com>, linux acpi <linux-acpi@vger.kernel.org>

andrej.gelenberg@udo.edu wrote:
> Hi,
>
> Alan Jenkins writes:
>
>> We'd better fix that :).
>>
>> Any interesting errors in dmesg?
>>
>> What's the latest version that's worked for you in the past?
>
> i think, the problem is, that since 2.6.32-rc* acpi don't find
> ASUS010 (it is not in /sys/bus/acpi/devices).
> It is there on 2.6.31.
>
> Regards,
> Andrej

Well spotted!

Mind filing this in Bugzilla?  That helps both for the core ACPI 
developers, and for regression tracking.  It also gives a good place to 
attach large files like acpidump output and full dmesg logs.

Thanks
Alan
