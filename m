From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 01/30] ACPICA: Linuxize: reduce divergences for 20160212
 release
Date: Sun, 27 Mar 2016 20:15:54 -0700
Message-ID: <1459134954.25110.26.camel@perches.com>
References: <cover.1458714002.git.lv.zheng@intel.com>
	 <cc3b66b74c73a66f82cb715092b6f35105a0cbf8.1458714003.git.lv.zheng@intel.com>
	 <1458783966.1762.6.camel@perches.com>
	 <1AE640813FDE7649BE1B193DEA596E883BB63FB7@SHSMSX101.ccr.corp.intel.com>
	 <1458817225.1762.13.camel@perches.com>
	 <1AE640813FDE7649BE1B193DEA596E883BB655F7@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtprelay0126.hostedemail.com ([216.40.44.126]:37611 "EHLO
	smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753511AbcC1DP6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 27 Mar 2016 23:15:58 -0400
In-Reply-To: <1AE640813FDE7649BE1B193DEA596E883BB655F7@SHSMSX101.ccr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Zheng, Lv" <lv.zheng@intel.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Brown, Len" <len.brown@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

On Mon, 2016-03-28 at 03:02 +0000, Zheng, Lv wrote:
> Hi,

Hello.

> > So why not fix the process script first?
> > Maybe add something like:
> > $ grep -E "^typedef\s+\w+\s*\*?\s*acpi_\w+" include/acpi/actypes.h =
| \
> > =A0 grep -Eoh "\bacpi_\w+"
> >=20
> > to the acpi_types variable in the lindent_single function
> [Lv Zheng]=A0
> I don't think this can work given:
> 1. we are not only dealing with typedefs, but structs, struct xxx wil=
l be converted into types during the release process.
> 2. we have only upper cased type names in ACPICA upstream, but have t=
he lower cased type names in Linux, and this doesn't solve that.
> So I guess you didn't test your idea.

Good guess.

The "maybe add something like" should give you a clue.

> You need to pull ACPICA repo and do the followings to confirm if this=
 is working:

No, I disagree. =A0_I_ don't need to. =A0You need to.

You shouldn't have a process that generates defective patches
and then sends them to the list.

cheers, Joe
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
