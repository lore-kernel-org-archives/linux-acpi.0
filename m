From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v3] aerdrv: Move cper_print_aer() call out of interrupt
 context
Date: Thu, 30 May 2013 09:37:08 -0400
Message-ID: <1369921028.26799.4.camel@gandalf.local.home>
References: <20130529190326.24171.86905.stgit@grignak.americas.hpqcorp.net>
	 <30463843.EmBn1xaq3I@vostro.rjw.lan>
	 <3908561D78D1C84285E8C5FCA982C28F2DA70112@ORSMSX106.amr.corp.intel.com>
	 <A961433CDFF2F640A2866803152E61F95D13A6F2@G9W0715.americas.hpqcorp.net>
	 <20130530072849.GA20793@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hrndva-omtalb.mail.rr.com ([71.74.56.122]:9979 "EHLO
	hrndva-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755741Ab3E3NhM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 May 2013 09:37:12 -0400
In-Reply-To: <20130530072849.GA20793@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: "Ortiz, Lance E" <lance.oritz@hp.com>, "Luck, Tony" <tony.luck@intel.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, "bhelgaas@google.com" <bhelgaas@google.com>, "lance_ortiz@hotmail.com" <lance_ortiz@hotmail.com>, "jiang.liu@huawei.com" <jiang.liu@huawei.com>, "mchehab@redhat.com" <mchehab@redhat.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Thu, 2013-05-30 at 09:28 +0200, Borislav Petkov wrote:
> On Thu, May 30, 2013 at 04:55:20AM +0000, Ortiz, Lance E wrote:
> > This TODO is a note for future clean-up and is not directly related=
 to
> >the bug being fixed with this patch. Which lends to the argument of =
why
> >put the TODO in this patch? Opportunistic. I don=E2=80=99t think we =
want to
> >create a separate patch just for a TODO note.
>=20
> Sounds to me, this TODO item should be on your TODO list - not in ker=
nel
> sources :-)
>=20

Also, that TODO sounds like there's output to userspace that can be
parsed by a userspace tool. If a tool expects the current format, it ma=
y
not be acceptable to change it later.

If the contents of this patch has nothing to do with the TODO, then
leave it out. It just confuses things.

-- Steve


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
