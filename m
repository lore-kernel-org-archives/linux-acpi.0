From: Alexey Starikovskiy <astarikovskiy@suse.de>
Subject: Re: EC
Date: Fri, 03 Jul 2009 06:28:42 +0400
Message-ID: <4A4D6CDA.7060206@suse.de>
References: <76780B19A496DC4B80439008DAD7076C03453A5BFC@PDSMSX501.ccr.corp.intel.com> <4A4C51AF.8080206@suse.de> <76780B19A496DC4B80439008DAD7076C03453A5CB9@PDSMSX501.ccr.corp.intel.com> <4A4C6589.4070108@suse.de> <76780B19A496DC4B80439008DAD7076C03453A5E98@PDSMSX501.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from charybdis-ext.suse.de ([195.135.221.2]:38889 "EHLO
	emea5-mh.id5.novell.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752584AbZGCC2j (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Jul 2009 22:28:39 -0400
In-Reply-To: <76780B19A496DC4B80439008DAD7076C03453A5E98@PDSMSX501.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Li, Shaohua =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> They said if burst timeout, then a GPE will fire. OS should check the=
 burst bit in status reg to know if EC is in burst mode. If not, os mig=
ht reissue burst enable as a retry.
The main question is, in case of the burst timeout, do they abort read/=
write transaction they happen to be in?
>=20
> They don't have any document to share with us. If you have other ques=
tions, please let me know, but please give detail questions so I can fo=
rward them to EC firmware engineer. This is a good chance for us to mak=
e EC better.=20
Is there any circumstance when they can start GPE storm?


Thanks,
Alex.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
