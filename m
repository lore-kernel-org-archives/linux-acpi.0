From: <Alex_Gagniuc@Dellteam.com>
Subject: Re: [PATCH 0/2] PCI/AER: Consistently use _OSC to determine who owns
 AER
Date: Tue, 20 Nov 2018 22:36:26 +0000
Message-ID: <e92c6c4f33c84f23ae47137f4ecb11f0@ausx13mps321.AMER.DELL.COM>
References: <20181115231605.24352-1-mr.nuke.me@gmail.com>
 <CABo9ajD5GJY7MrMjQc3hE=4tpPKpeceMtVEHwCwgjrvJUYjLvg@mail.gmail.com>
 <20181119165318.GB26595@localhost.localdomain>
 <74f2c527-0890-5e14-5e2d-48934a42dae6@kernel.org>
 <ab2427f1-c1f0-68fe-5335-1494caafdcbb@kernel.org>
 <20181119174127.GE26595@localhost.localdomain>
 <ef0a24e4-906e-f6df-c646-1fe47ea0dcc0@kernel.org>
 <20181119181051.GA26707@localhost.localdomain>
 <c0d6535f-324b-557a-3d0e-ccec070459a7@kernel.org>
 <3f923367-2cc1-c0d6-bca6-bf9a03d1b9ca@gmail.com>
 <ef6b19de-dd18-850f-4db9-8ab71b975e94@kernel.org>
 <bb575cfdcd0a4c50b489fb16eccfbff2@ausx13mps321.AMER.DELL.COM>
 <84013a8a-287d-d700-6710-91cc35f507c8@kernel.org>
 <9c9531c7efb846438f03f744b9afc466@ausx13mps321.AMER.DELL.COM>
 <3b18a9fa-7bdd-0fb4-285d-4efb454be50a@kernel.org>
 <e86f04ef8c054d61969862a6e7b72d0d@ausx13mps321.AMER.DELL.COM>
 <314e59da-48e1-545b-3ee9-6e5056b90fd9@kernel.org>
 <4728316eb84446358e0a07bbf1e42b57@ausx13mps321.AMER.DELL.COM>
 <bac2c78a-cd56-7287-e4fd-6042e9b3432c@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: okaya@kernel.org, mr.nuke.me@gmail.com, keith.busch@intel.com
Cc: baicar.tyler@gmail.com, Austin.Bolen@dell.com, Shyam.Iyer@dell.com, lukas@wunner.de, bhelgaas@google.com, rjw@rjwysocki.net, lenb@kernel.org, ruscur@russell.cc, sbobroff@linux.ibm.com, oohall@gmail.com, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-acpi@vger.kernel.org

On 11/20/2018 04:08 PM, Sinan Kaya wrote:=0A=
> One version is:=0A=
> "if HEST table is present, ignore _OSC"=0A=
> or=0A=
> Another version is:=0A=
> "if HEST table is present, make sure that FW sets _OSC bit for AER to=0A=
> false. Otherwise, warn like crazy that this BIOS is broken and needs=0A=
> an update and can cause all sorts of trouble"=0A=
=0A=
ACPI 6.2 Ch 6.2.11.3, Table 6-197=0A=
	PCI Express Advanced Error Reporting control=0A=
=0A=
	The firmware sets this bit to 1 to grant control over PCI=0A=
	Express Advanced Error Reporting.=0A=
	If firmware allows the OS control of this feature, then in the=0A=
	context of the _OSC method it must ensure that error messages=0A=
	are routed to device interrupts as described in the PCI=0A=
	Express Base Specification. Additionally, after control is=0A=
	transferred to the OS, firmware must not modify the Advanced=0A=
	Error Reporting Capability. If control of this feature was=0A=
	requested and denied or was not requested, firmware returns=0A=
	this bit set to 0.=0A=
