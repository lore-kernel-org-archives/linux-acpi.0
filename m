From: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Subject: Re: Help with fan on fujitsu-siemens
Date: Wed, 14 Feb 2007 12:52:52 +0300
Message-ID: <45D2DBF4.5070304@linux.intel.com>
References: <364867.80154.qm@web90511.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:46014 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751514AbXBNJw5 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Feb 2007 04:52:57 -0500
In-Reply-To: <364867.80154.qm@web90511.mail.mud.yahoo.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lorincz Andras <lorandsm@yahoo.com>
Cc: linux-acpi@vger.kernel.org

Lorincz Andras wrote:
> Hello,
>
> I have a fujitsu-siemens amilo l1310g laptop. The
> problem is that the cpu fan doesn't start if the cpu
> heats up, but I can start it manualy by these 2
> commands:
>
> echo 3 > /proc/acpi/fan/FAN0/state
> echo 0 > /proc/acpi/fan/FAN0/state
>
> in this case the fan starts but it won't ever stop
> even if I launch:
>
> echo 3 > /proc/acpi/fan/FAN0/state
>
> I'm using kernel 2.6.18, but tried with 2.6.19 and
> 2.6.20-rc7 also. Any hint on how can be this fixed? Thanks.
>
>
>   
What are the contents of /proc/acpi/thermal_zone/ ?
