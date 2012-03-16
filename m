From: Chen Gong <gong.chen@linux.intel.com>
Subject: Re: [PATCH v2] ACPI, APEI, EINJ, limit the range of einj_param
Date: Fri, 16 Mar 2012 13:41:51 +0800
Message-ID: <4F62D29F.2090503@linux.intel.com>
References: <4F506E8A.8010901@linux.intel.com> <1330747003-11891-1-git-send-email-gong.chen@linux.intel.com> <4F61AE40.1020908@linux.intel.com> <3908561D78D1C84285E8C5FCA982C28F15B65247@ORSMSX103.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:16815 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753489Ab2CPFly (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 16 Mar 2012 01:41:54 -0400
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F15B65247@ORSMSX103.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Luck, Tony" <tony.luck@intel.com>
Cc: "Huang, Ying" <ying.huang@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

=E4=BA=8E 3/16/2012 12:48 AM, Luck, Tony =E5=86=99=E9=81=93:
>> -	if (paddrv4) {
>> +	if (param_extension&&   paddrv4) {
> looks like needs a space moved from after the "&&"
> to before it. But otherwise:
>
> Acked-by: Tony Luck<tony.luck@intel.com>
Not sure why because my patch looks good. Maybe my mail client does=20
something
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
