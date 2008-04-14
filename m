From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: Re: WMI support on Linux
Date: Mon, 14 Apr 2008 18:55:25 +0100
Message-ID: <200804141855.25974.carlos@strangeworlds.co.uk>
References: <loom.20080414T173138-851@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from phoenix.slamd64.com ([217.10.145.2]:56167 "EHLO
	phoenix.slamd64.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764442AbYDNRza (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Apr 2008 13:55:30 -0400
In-Reply-To: <loom.20080414T173138-851@post.gmane.org>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ajit <ajitrzid@yahoo.com>
Cc: linux-acpi@vger.kernel.org

On Monday 14 April 2008 18:44:40 Ajit wrote:
>     I was curious when WMI BIOS support would be available in the kernel. I
> saw some references to it in the Feb 08 archive( Randy Dunlap & Carlos
> Corbacho ). Is there some patch that I can download to enable this support
> ?

ACPI-WMI is available in the kernel from 2.6.25-rc1 onwards. However, in and 
of itself, ACPI-WMI is not much use - you need another driver on top to 
actually do anything useful with the data/ methods exposed by ACPI-WMI on 
your hardware (e.g. acer-wmi, tc1100-wmi).

The driver is also currently limited in that it does not expose the ACPI-WMI 
internals to userspace yet.

-Carlos
-- 
E-Mail: carlos@strangeworlds.co.uk
Web: strangeworlds.co.uk
GPG Key ID: 0x23EE722D
