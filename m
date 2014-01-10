From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH] acpi memory hotplug, add parameter to disable memory
 hotplug [v2]
Date: Fri, 10 Jan 2014 09:55:19 -0500
Message-ID: <52D009D7.1010600@redhat.com>
References: <1389364615-13320-1-git-send-email-prarit@redhat.com> <20140110144910.GB19115@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:13304 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750877AbaAJOzt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 10 Jan 2014 09:55:49 -0500
In-Reply-To: <20140110144910.GB19115@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Vivek Goyal <vgoyal@redhat.com>
Cc: linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, kosaki.motohiro@gmail.com, dyoung@redhat.com, linux-acpi@vger.kernel.org, kexec@lists.infradead.org



On 01/10/2014 09:49 AM, Vivek Goyal wrote:
> On Fri, Jan 10, 2014 at 09:36:55AM -0500, Prarit Bhargava wrote:
> 
> [..]
>> This can also be reproduced by using the memmap=exactmap and mem=X
>> parameters on the main kernel and booting.
>>
>> This patchset resolves the problem by adding a kernel parameter,
>> acpi_no_memhotplug, to disable ACPI memory hotplug.
> 
> Hi Prarit,
> 
> People seem to like the idea of disabling hotplug automatically if
> memmap=exactmap or mem=X is passed on command line. Can you please take
> care of that too. That way we would not have to modify kexec-tools and
> kernel update will fix this issue.

Oh, okay.  I'll do that right now.

P.

> 
> Thanks
> Vivek
