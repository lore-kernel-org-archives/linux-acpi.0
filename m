From: Tejun Heo <teheo@suse.de>
Subject: Re: [PATCH 5/8] fix hotplug race
Date: Mon, 09 Jun 2008 10:16:32 +0900
Message-ID: <484C8470.1000404@suse.de>
References: <1212729768.25188.28.camel@sli10-desk.sh.intel.com> <484C843C.5010306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ns2.suse.de ([195.135.220.15]:56186 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752771AbYFIBQl (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 8 Jun 2008 21:16:41 -0400
In-Reply-To: <484C843C.5010306@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Accardi, Kristen C" <kristen.c.accardi@intel.com>, Holger Macht <hmacht@suse.de>, mjg59 <mjg59@srcf.ucam.org>, Jeff Garzik <jeff@garzik.org>

Tejun Heo wrote:
> Shaohua Li wrote:
>> hotplug notification handler and drivers' notification handler are all
>> running in one workqueue. Before hotplug removes an acpi device, the
>> device driver's notification handler is already be recorded to run just
>> after global notification handler. After hotplug notification handler
>> runs, acpica will notice a NULL notification handler and crash. This
>> patch runs hotplug in other workqueue and wait for all acpi notication
>> handlers finish. This is found in battery hotplug, but actually all
>> hotplug can be affected.
>>
>> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>> Signed-off-by: Shaohua Li <shaohua.li@intel.com> 
>> ---
>>  drivers/acpi/dock.c     |   24 +++++++++++++++++++++++-
>>  drivers/acpi/osl.c      |   44 +++++++++++++++++++++++++++++++++++++++-----
>>  include/acpi/acpiosxf.h |    3 +++
>>  3 files changed, 65 insertions(+), 6 deletions(-)
> 
> I don't understand the ACPI/dock specific changes but libata-acpi
> definitely looks much prettier this way.  Holger, does everything look okay?

Aiee.. This should have been a reply to PATCH 6/8 not PATCH 5/8.  Sorry.

-- 
tejun
