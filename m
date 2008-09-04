From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: a problem about the two patches in bug 10724 & 11428
Date: Thu, 04 Sep 2008 11:43:26 +0800
Message-ID: <1220499806.4007.113.camel@yakui_zhao.sh.intel.com>
References: <1220251221.4039.52.camel@yakui_zhao.sh.intel.com>
	 <20080901122158.GB21970@khazad-dum.debian.net> <48BC522D.60905@suse.de>
	 <48BC57C9.2040409@suse.de>
	 <1220421722.4007.4.camel@yakui_zhao.sh.intel.com>  <48BE32AF.0@suse.de>
	 <1220429030.4007.22.camel@yakui_zhao.sh.intel.com>
	 <48BE427C.3070204@suse.de>
	 <1220430856.4007.38.camel@yakui_zhao.sh.intel.com>
	 <48BF0FA1.4040807@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:59142 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753397AbYIDD3X (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 3 Sep 2008 23:29:23 -0400
In-Reply-To: <48BF0FA1.4040807@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-acpi@vger.kernel.org, lenb@kernel.org

On Thu, 2008-09-04 at 02:28 +0400, Alexey Starikovskiy wrote:
> Hi Yakui,
>=20
> Zhao Yakui wrote:
> >> If you _disable_ EC GPE or not enable it in first place, EC(hardwa=
re) will be working in
> >> poll mode. So, there is no spare code to clean up, sorry.=20
> > Not understand what you said.
> It seems to be not my problem...
> > After your three patches hit the upstream kernel, the EC GPE is sti=
ll
> > enabled when EC timeout happens. In such case when EC is accessed, =
EC
> > will work in polling mode. At the same time EC GPE interrupt still =
can
> > be triggered.
> One of my patches adds option to not enable EC GPE (ec_intr=3D0), so =
it is
> possible to run EC driver in hardware poll mode, and all the code for=
 such
> operation is needed. I do not know how to say it in simpler terms, so=
rry.
> If it is still unclear, please consult with Len...=20
Hi, Alexey
   After investigation I found that the laptop in bug 11428 is the same
as that in bug 8459. Is the EC on such laptop that you mean "optimized"
EC? But in fact the OBF and IBF can reflect the EC status correctly
although sometimes there is no GPE interrupt confirmation.
  =20
  Accorind to ACPI spec 3.0b, the embedded controller must generate SCI=
s for commands as follows:
=E2=80=A2 Read Command (3 Bytes)
   Byte #1     (Command byte Header)          Interrupt on IBF=3D0=20
   Byte #2     (Address byte to read)         No Interrupt
   Byte #3     (Data read to host)            Interrupt on OBF=3D1
=E2=80=A2 Write Command (3 Bytes)
  Byte #1     (Command byte Header)          Interrupt on IBF=3D0
  Byte #2     (Address byte to write)        Interrupt on IBF=3D0
  Byte #3     (Data to read )                Interrupt on IBF=3D0
=E2=80=A2 Query Command (2 Bytes)
  Byte #1     (Command byte Header)          No Interrupt
  Byte #2     (Query value to host)          Interrupt on OBF=3D1
=E2=80=A2 Burst Enable Command (2 Bytes)
  Byte #1     (Command byte Header)          No Interrupt
  Byte #2     (Burst acknowledge byte)       Interrupt on OBF=3D1
=E2=80=A2 Burst Disable Command (1 Byte)
  Byte #1     (Command byte Header)          Interrupt on IBF=3D0

But from the log in comment #46 of bug8459 and comment #26 of bug 11428
we can get the following info:
   a. In the course of read command, EC GPE interrupt is triggered only
after read command is issued. Sometimes there is no interrupt after OBF
becomes 1(data ready and Host can read it).=20
   b. In the course of query command, sometimes there is no interrupt
after OBF becomes 1(data ready).
   c. In the course of burst disable command, sometimes there is no
interrupt after burst disable command is issued although the IBF is
already zero.(Input buffer is empty)

>From the above log we can know that the EC status is already what OS
expected although there is no interrupt confirmation in some cases. For
example: When issuing read/query command, the OBF already becomes
one(Data ready). When issuing the burst disable command, the IBF alread=
y
becomes zero.(EC input buffer is empty).  It means that EC still can
work well by polling EC status to check whether it is what OS expected.
And I believe that is valid for all laptops. If the OBF and IBF can't
reflect the EC status correctly, the windows also can't work well.=20

At the same time maybe EC will send a notification event requiring OS's
attention. In such case OS can detect whether the notification event is
sent  by checking the SCI_EVT bit in the EC GPE interrupt service
routine.(I.E . acpi_ec_gpe_handler). In fact only checking notification
event in ec gpe handler is enough to make EC work.

If so, the EC work flowchart will become very simple. I will try to
write this patch and consult with Len.

There is another issue. From the log in  comment #26 of bug 11428 I fin=
d
that OS still issues the burst disable command although EC already exit=
s
the burst mode. Maybe we should check whether the EC is in burst mode
before issuing EC burst disable command.
    >ACPI: EC: transaction start
    >[  124.540016] ACPI: EC: <--- command =3D 0x83
    >[  124.540016] ACPI: EC: ---> status =3D 0x0a
    >[  124.542009] ACPI: EC: ---> status =3D 0x08
    >[  124.542009] ACPI: EC: transaction end

Thanks.
 =20
=20
  =20

> Alex.

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
