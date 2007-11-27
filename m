From: "Zhang, Rui" <rui.zhang@intel.com>
Subject: RE: No blacklight Re: [patch] remove debug info in acpi video
Date: Tue, 27 Nov 2007 08:45:22 +0800
Message-ID: <823A93EED437D048963A3697DB0E35DEE70D02@pdsmsx414.ccr.corp.intel.com>
References: <20071113005047.GA27837@zhen-devel.sh.intel.com> <1194921410.2969.1.camel@localhost.localdomain> <1195950110.813.1.camel@localhost.localdomain> <20071126012040.GA5493@zhen-devel.sh.intel.com> <1196105959.14119.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:15283 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753182AbXK0Apr convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Nov 2007 19:45:47 -0500
Content-class: urn:content-classes:message
In-Reply-To: <1196105959.14119.9.camel@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>, "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>
Cc: linux-acpi@vger.kernel.org



>-----Original Message-----
>From: Sergio Monteiro Basto [mailto:sergio@sergiomb.no-ip.org]
>Sent: Tuesday, November 27, 2007 3:39 AM
>To: Wang, Zhenyu Z
>Cc: Zhang, Rui; linux-acpi@vger.kernel.org
>Subject: Re: No blacklight Re: [patch] remove debug info in acpi video
>
>
>On Mon, 2007-11-26 at 09:20 +0800, Zhenyu Wang wrote:
>> No idea how could my simple patch cause your problem...
>
>I'm not saying your patch cause the problem , I say when this messages
>begging to appears at more or less at same time my blacklight stops to
>works, but not saying that is direct related to this patch.
>
If the hotkey events is handled via ACPI, which is true in your case,
this debug message always appears no matter the backlight works or not.
:)

>btw , after suspend to disk and resume , blacklight works! .
That's weird.
You can open a bug at http://bugzilla.kernel.org/enter_bug.cgi
And attach the acpidump.

Thanks,
Rui
