From: "Moore, Robert" <robert.moore@intel.com>
Subject: RE: [PATCH 70/73] ACPICA: Fix to disable unknown spurious GPEs
Date: Thu, 24 Apr 2008 21:18:19 -0700
Message-ID: <9D39833986E69849A2A8E74C1078B6B337361E@orsmsx415.amr.corp.intel.com>
References: <1207974356-30687-1-git-send-email-lenb@kernel.org>	 <480EC916.1050407@suse.de>	 <9D39833986E69849A2A8E74C1078B6B3372B65@orsmsx415.amr.corp.intel.com>	 <200804242140.28805.lenb@kernel.org>	 <1209088386.3538.18.camel@rzhang-crestline.sh.intel.com>	 <9D39833986E69849A2A8E74C1078B6B33735F5@orsmsx415.amr.corp.intel.com>	 <48113D80.70406@suse.de> <1209090486.3538.36.camel@rzhang-crestline.sh.intel.com> <4811447F.6010602@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:22053 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750981AbYDYESV convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 25 Apr 2008 00:18:21 -0400
Content-class: urn:content-classes:message
In-Reply-To: <4811447F.6010602@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>, "Zhang, Rui" <rui.zhang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

>> After 6217 is applied, when installing EC GPE handler, Linux will
invoke
>> acpi_hw_write_gpe_enable_reg to try to disable EC GPE which is not
done
>> before. Don't know if this is related.
>No, EC GPE handler is installed later. Thus the error is triggered
>during execution of 6217 code...

Attempt to disable EC GPE causes a GPE? I still do not understand.


>-----Original Message-----
>From: Alexey Starikovskiy [mailto:astarikovskiy@suse.de]
>Sent: Thursday, April 24, 2008 7:40 PM
>To: Zhang, Rui
>Cc: Moore, Robert; Len Brown; linux-acpi@vger.kernel.org
>Subject: Re: [PATCH 70/73] ACPICA: Fix to disable unknown spurious GPEs
>
>Zhang Rui wrote:
>> On Fri, 2008-04-25 at 10:10 +0800, Alexey Starikovskiy wrote:
>>> Actually, I too don't know why _disabling_ some GPE could trigger EC
>>> one...
>>> May be Len could try to debug this issue, as he is the only one with
>>> hardware...
>>> One thought is that EC GPE is not present in GPE scope, thus it will
>>> be not configured by the
>>> time 6217' code is executed. So, in theory, 6217 could try to
disable
>>> EC GPE.
>> In acpi_install_gpe_handler, Linux always disables the GPE before
>> installing a GPE handler.
>> After 6217 is applied, when installing EC GPE handler, Linux will
invoke
>> acpi_hw_write_gpe_enable_reg to try to disable EC GPE which is not
done
>> before. Don't know if this is related.
>No, EC GPE handler is installed later. Thus the error is triggered
>during execution of 6217 code...
