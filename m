From: "Zhao, Yakui" <yakui.zhao@intel.com>
Subject: RE: [PATCH] ACPI: EC: do transaction from interrupt context
Date: Fri, 26 Sep 2008 21:54:52 +0800
Message-ID: <9D7649D18729DE4BB2BD7B494F7FEDC201DE13D8@pdsmsx415.ccr.corp.intel.com>
References: <20080925170030.15311.27823.stgit@thinkpad> <48DBCFE0.8050905@yahoo.com> <1222391199.4023.125.camel@yakui_zhao.sh.intel.com> <200809261433.53674.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:24034 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751871AbYIZNy4 convert rfc822-to-8bit (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Fri, 26 Sep 2008 09:54:56 -0400
Content-class: urn:content-classes:message
In-Reply-To: <200809261433.53674.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Sitsofe Wheeler <sitsofe@yahoo.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, LenBrown <lenb@kernel.org>, Linux-acpi@vger.kernel.org

Alan gives a suggestion that after processing the EC notification event=
, EC driver
should continue to issue the query command and process the EC notificat=
ion event until the query command returns zero.
But this suggestion will break my laptop. On my laptop when issuing the=
 query command, a non-zero query event is  returned but it can't be pro=
cessed.(There is no corresponding ACPI _Qxx object). At the same time t=
he SCI_EVT bit won't be cleared. In such case OS can't exit the functio=
n of acpi_ec_query_handler, which causes that the acpid kernel thread c=
an't work well.

In fact according to my analysis IMO Alexey's patch will break my lapto=
p. But now the laptop is not in my hand and I can't do the test. After =
I own the laptop again, I will do the test and attach the corresponding=
 info.

At the same time there are two generic issues in this patch:
   a. spin_lock is overkill. When 2000 EC I/O read/write are executed, =
the CPU interrupt will be disabled for about 1.5ms. This will affect th=
e normal laptops.
   b. the local variable that resides in process stack space is used in=
 interrupt-context.=20

Best regards.

-----Original Message-----
=46rom: Rafael J. Wysocki [mailto:rjw@sisk.pl]=20
Sent: 2008=C4=EA9=D4=C226=C8=D5 20:34
To: Zhao, Yakui
Cc: Sitsofe Wheeler; Alexey Starikovskiy; LenBrown; Linux-acpi@vger.ker=
nel.org
Subject: Re: [PATCH] ACPI: EC: do transaction from interrupt context

On Friday, 26 of September 2008, Zhao Yakui wrote:
> On Thu, 2008-09-25 at 18:52 +0100, Sitsofe Wheeler wrote:
> > Alexey Starikovskiy wrote:
> > > It is easier and faster to do transaction directly from interrupt=
 context
> > > rather than waking control thread.
> > > Also, cleaner GPE storm avoidance is implemented.
> Hi, Sitsofe
>     I think that the problem on the asus-EEEPC can't be resolved real=
ly
> by the Alexey's patch. IMO it is only lucky.
>    In fact the main problem on Asus-EEEPC is related with the broken =
EC.
> Before an EC notification event is processed, another EC notification
> event arrives again.
>    If EC driver check whether the SCI_EVT bit is set after processing
> one EC notification event, the problem will be resolved.=20
>     http://bugzilla.kernel.org/show_bug.cgi?id=3D11089
>     Alan Jenkins already sent a patch about how to fix the issue on t=
he
> Asus-EEEPC.
>   =20
>    But if the above patch is merged , maybe it will break some laptop=
s.
> On my laptop when issuing the query command, a non-zero query event i=
s
> returned but it can't be processed.(There is no corresponding ACPI _Q=
xx
> object). At the same time the SCI_EVT bit won't be cleared. In such c=
ase
> OS can't exit the function of acpi_ec_query_handler, which causes tha=
t
> the acpid kernel thread can't work well.

So does the patch break your box as a result?

Rafael
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
