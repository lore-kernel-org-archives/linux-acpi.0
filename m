From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH -next] x86/e820: fix build when ACPI is disabled
Date: Wed, 12 Jan 2011 12:49:13 -0800
Message-ID: <4D2E13C9.7030704@oracle.com>
References: <20110112141822.c29314c4.sfr@canb.auug.org.au> <20110112122014.2d8455d7.randy.dunlap@oracle.com> <201101122135.55567.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet10.oracle.com ([148.87.113.121]:33700 "EHLO
	rcsinet10.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756099Ab1ALUvS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 12 Jan 2011 15:51:18 -0500
In-Reply-To: <201101122135.55567.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Jiri Slaby <jslaby@suse.cz>, lenb@kernel.org, linux-acpi@vger.kernel.org

On 01/12/11 12:35, Rafael J. Wysocki wrote:
> On Wednesday, January 12, 2011, Randy Dunlap wrote:
>> From: Randy Dunlap <randy.dunlap@oracle.com>
>>
>> Fix build error when CONFIG_ACPI is not enabled:
>>
>> arch/x86/kernel/e820.c:734: error:implicit declaration of function 'suspend_nvs_register'


> I'd prefer the appended patch (it also should fix the problem indicated by Jiri).
> 
> Does it work for you?

Yes, both build error and warning are fixed.  Thanks.

Acked-by: Randy Dunlap <randy.dunlap@oracle.com>


-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
