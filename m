From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: Problems evaluating WMI method
Date: Wed, 1 Oct 2008 21:26:28 +0100
Message-ID: <200810012126.29618.carlos@strangeworlds.co.uk>
References: <200810012113.50723.duartejcsilva@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:47370 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114AbYJAU0k (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Oct 2008 16:26:40 -0400
In-Reply-To: <200810012113.50723.duartejcsilva@gmail.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Duarte Silva <duartejcsilva@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Wednesday 01 October 2008 21:13:50 Duarte Silva wrote:
> I got the correct answer when I do instance = 0x33 and method_id = 0x01.
> So, I looked at hp-wmi.c code and acer-wmi.c and they depend on this
> instance and method_id. But my laptop doesnt seem to depend. 

acer-wmi doesn't rely on the instance_id, it just gets ignored. It does use 
the method_id though.

> Is this 
> instance and method_id a WMI standart or is it a HP and Acer laptop
> specific? My laptop is a LG.

Yes, these are part of the WMI standard (in that, they need to be passed in). 
I would recommend you read through the spec:

http://web.archive.org/web/20071011004327/http://www.microsoft.com/whdc/system/pnppwr/wmi/wmi-acpi.mspx

Essentially - you need to pass the instance and method id's, but what values 
you pass and their meaning is completely vendor specific (which is pretty 
much a good summary of ACPI-WMI in general).

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
