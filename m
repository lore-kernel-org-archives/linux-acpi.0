From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: [PATCH 70/73] ACPICA: Fix to disable unknown spurious GPEs
Date: Fri, 25 Apr 2008 06:39:59 +0400
Message-ID: <4811447F.6010602@suse.de>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>	 <480EC916.1050407@suse.de>	 <9D39833986E69849A2A8E74C1078B6B3372B65@orsmsx415.amr.corp.intel.com>	 <200804242140.28805.lenb@kernel.org>	 <1209088386.3538.18.camel@rzhang-crestline.sh.intel.com>	 <9D39833986E69849A2A8E74C1078B6B33735F5@orsmsx415.amr.corp.intel.com>	 <48113D80.70406@suse.de> <1209090486.3538.36.camel@rzhang-crestline.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:55266 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753407AbYDYCjz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Apr 2008 22:39:55 -0400
In-Reply-To: <1209090486.3538.36.camel@rzhang-crestline.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: "Moore, Robert" <robert.moore@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

Zhang Rui wrote:
> On Fri, 2008-04-25 at 10:10 +0800, Alexey Starikovskiy wrote:
>> Actually, I too don't know why _disabling_ some GPE could trigger EC
>> one...
>> May be Len could try to debug this issue, as he is the only one with
>> hardware...
>> One thought is that EC GPE is not present in GPE scope, thus it will
>> be not configured by the
>> time 6217' code is executed. So, in theory, 6217 could try to disable
>> EC GPE.
> In acpi_install_gpe_handler, Linux always disables the GPE before
> installing a GPE handler.
> After 6217 is applied, when installing EC GPE handler, Linux will invoke
> acpi_hw_write_gpe_enable_reg to try to disable EC GPE which is not done
> before. Don't know if this is related.
No, EC GPE handler is installed later. Thus the error is triggered 
during execution of 6217 code...
