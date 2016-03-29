From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 01/30] ACPICA: Linuxize: reduce divergences for 20160212
 release
Date: Mon, 28 Mar 2016 22:56:38 -0700
Message-ID: <1459230998.25110.73.camel@perches.com>
References: <cover.1458714002.git.lv.zheng@intel.com>
	 <cc3b66b74c73a66f82cb715092b6f35105a0cbf8.1458714003.git.lv.zheng@intel.com>
	 <1458783966.1762.6.camel@perches.com>
	 <1AE640813FDE7649BE1B193DEA596E883BB63FB7@SHSMSX101.ccr.corp.intel.com>
	 <1458817225.1762.13.camel@perches.com>
	 <1AE640813FDE7649BE1B193DEA596E883BB655F7@SHSMSX101.ccr.corp.intel.com>
	 <1459134954.25110.26.camel@perches.com>
	 <1AE640813FDE7649BE1B193DEA596E883BB658E2@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtprelay0194.hostedemail.com ([216.40.44.194]:41726 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751435AbcC2F4l (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Mar 2016 01:56:41 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BB658E2@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Tue, 2016-03-29 at 05:37 +0000, Zheng, Lv wrote:
> Hi,

Hi again.
> > No, I disagree. =A0_I_ don't need to. =A0You need to.
> [Lv Zheng]=A0
> Then you don't have to provide the solution as you are not the one ex=
ecuting the process.
> I can fix it myself:
> https://github.com/acpica/acpica/pull/129=A0
> It would be merged by the ACPICA upstream in the near future.

Excellent, thank you.

=46or this:=A0https://github.com/acpica/acpica/pull/129/commits/b2294ca=
e776f5a66a7697414b21949d307e6856f

Maybe you could use \w+ instead of=A0[_a-zA-Z0-9]+

> I'll show you the difficulties of "process" later.

ok, appreciate your time.

> > You shouldn't have a process that generates defective patches
> > and then sends them to the list.
> [Lv Zheng]=A0
> You are not the one executing this process, so you don't know what's =
happening here.

True.

> Actually the Linux repo should be synced to the state of the ACPICA r=
epo.

That's more doubtful, but then again I don't maintain
ACPICA and you do.

cheers, Joe
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
