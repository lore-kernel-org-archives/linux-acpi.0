From: olm-acpi-devel-+d40ctR3GU7QT0dZR+AlfA@public.gmane.org
Subject: Re: Error in "Executing all Device _STA and_INI methods"
Date: Tue, 20 Jan 2004 09:31:17 -0800 (PST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.58.0401200923290.22574@gyumri.hekiat.org>
References: <Pine.LNX.4.58.0401200725360.21707@gyumri.hekiat.org>
 <1074613959.2740.5.camel@localhost>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811327-1581724198-1074619877=:22574"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1074613959.2740.5.camel-bi+AKbBUZKZeoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Greg Sarjeant <greg-QNIYhHqVzB9kr2E5YSwMOQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime-oOUblnuQwHKola3qYQ6TW/IULO3mGbRi9nwVQlTi/Pw@public.gmane.org for more info.

---1463811327-1581724198-1074619877=:22574
Content-Type: TEXT/PLAIN; charset=US-ASCII

I applied the patch to 2.6.1. It compiled with a few warnings.

drivers/acpi/ec.c: In function `acpi_ec_start':
drivers/acpi/ec.c:742: warning: implicit declaration of function `acpi_ns_evaluate_relative'
drivers/acpi/ec.c:750: warning: implicit declaration of function `acpi_ns_get_external_pathname'
drivers/acpi/ec.c:750: warning: initialization makes pointer from integer without a cast

It seems to have resolved the error I was having, however, I'm still
not able to control the states.

There is another error, further down:

ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
pci_link-0403 [44] acpi_pci_link_set     : Link disabled
ACPI: Unable to set IRQ for PCI Interrupt Link [LNKE] (likely buggy ACPI BIOS). Aborting ACPI-based IRQ routing. Try pci=noacpi or acpi=off
 pci_irq-0262 [41] acpi_pci_irq_lookup   : Invalid IRQ link routing entry
 pci_irq-0302 [41] acpi_pci_irq_derive   : Unable to derive IRQ for device 0000:02:08.0
ACPI: No IRQ known for interrupt pin A of device 0000:02:08.0
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'

I've attached the full dmesg output.


Ovanes


On Tue, 20 Jan 2004, Greg Sarjeant wrote:

> Hello,
>
> Gateway laptops do not seem to provide an ECDT. You may want to try this
> patch:
> http://bugzilla.kernel.org/attachment.cgi?id=1690&action=view
>
> It fixed similar issues on my Gateway 200X, and I have seen reports that
> it also fixes the issue on the Gateway M350.
>
> Here is the corresponding bug report:
> http://bugzilla.kernel.org/show_bug.cgi?id=1690
>
> Greg
>
>
> On Tue, 2004-01-20 at 10:37, olm-acpi-devel-+d40ctR3GU7QT0dZR+AlfA@public.gmane.org wrote:
> > Hello,
> >
> > I hope this is the correct list for this question.
> >
> > I have a Gateway 400VTX laptop. It has a 2.2 GHz Celeron CPU.  I just
> > compiled and installed Linux 2.6.1 on it. I chose the "Intel P4/Xeon"
> > option (CONFIG_MPENTIUM4=y) from configuration. I have enabled APCI
> > but not APM.
> >
> > I'm checking my dmesg and noticed some errors:
> >
> > Executing all Device _STA and_INI methods:......evregion-0249 [21] ev_address_space_dispa: no handler for region(c12db5a8) [EmbeddedControl]
> >  exfldio-0282 [20] ex_access_region      : Region EmbeddedControl(3) has no handler
> >  dswexec-0422 [13] ds_exec_end_op        : [LGreater]: Could not resolve operands, AE_NOT_EXIST
> >  psparse-1120: *** Error: Method execution failed [\_SB_.PCI0._INI] (Node c12e06a8), AE_NOT_EXIST
> >   nsinit-0397 [06] ns_init_one_device    : \_SB_.PCI0._INI failed: AE_NOT_EXIST
> >
> > What does this mean? Don't seem to be able to put the machine to any
> > of the reduced states. The following commands produce nothing:
> >
> >   echo "standby" > state
> >   echo "mem" > state
> >   echo "disk" > /sys/power/stat
> >
> > It seems that the laptop is running too hot. I can feel the heat and
> > I don't know if this is 'acceptable' or not. Also, I get a lot of
> > lines line this in my dmesg:
> >
> > [ACPI Debug] String: Temperature increasing: _Q80
> >
> >
> > Thanks in advance for your help.
> >
> > Regards,
> >
> > Ovanes
> >
> > P.S. What follows is the portions of my dmesg which I found relevant
> > to APCI, up to the point where the error is printed.
> >
> >
> > ACPI: RSDP (v000 GATEWA                                    ) @ 0x000f6710
> > ACPI: RSDT (v001 GATEWA 400VTX   0x20030312  LTP 0x00000000) @ 0x0f6e6d53
> > ACPI: FADT (v001 GATEWA 400VTX   0x20030312 PTL  0x00000050) @ 0x0f6ebf64
> > ACPI: BOOT (v001 GATEWA 400VTX   0x20030312  LTP 0x00000001) @ 0x0f6ebfd8
> > ACPI: DSDT (v001 GATEWA 400VTX   0x20030312 MSFT 0x0100000e) @ 0x00000000
> > CPU:     After generic identify, caps: bfebf9ff 00000000 00000000 00000000
> > CPU:     After vendor identify, caps: bfebf9ff 00000000 00000000 00000000
> > CPU: Trace cache: 12K uops, L1 D cache: 8K
> > CPU: L2 cache: 256K
> > CPU:     After all inits, caps: bfebf9ff 00000000 00000000 00000080
> > Intel machine check architecture supported.
> > Intel machine check reporting enabled on CPU#0.
> > CPU#0: Intel P4/Xeon Extended MCE MSRs (12) available
> > CPU: Intel Mobile Intel(R) Celeron(R) CPU 2.20GHz stepping 07
> > ACPI: Subsystem revision 20031002
> >  tbxface-0117 [03] acpi_load_tables      : ACPI Tables successfully acquired
> > Parsing all Control Methods:.................................................................................................................................................................................................
> > Table [DSDT](id F004) - 685 Objects with 55 Devices 193 Methods 15 Regions
> > ACPI Namespace successfully loaded at root c03c6cfc
> > ACPI: IRQ 9 was Edge Triggered, setting to Level Triggerd
> > evxfevnt-0093 [04] acpi_enable           : Transition to ACPI mode successful
> > evgpeblk-0748 [06] ev_create_gpe_block   : GPE 00 to 31 [_GPE] 4 regs at 0000000000001028 on int 9Completing Region/Field/Buffer/Package initialization:.................................................................
> > Initialized 15/15 Regions 0/0 Fields 28/28 Buffers 22/22 Packages (693 nodes)
> > Executing all Device _STA and_INI methods:......evregion-0249 [21] ev_address_space_dispa: no handler for region(c12db5a8) [EmbeddedControl]
> >  exfldio-0282 [20] ex_access_region      : Region EmbeddedControl(3) has no handler
> >  dswexec-0422 [13] ds_exec_end_op        : [LGreater]: Could not resolve operands, AE_NOT_EXIST
> >  psparse-1120: *** Error: Method execution failed [\_SB_.PCI0._INI] (Node c12e06a8), AE_NOT_EXIST
> >   nsinit-0397 [06] ns_init_one_device    : \_SB_.PCI0._INI failed: AE_NOT_EXIST
> > ..................................................
> > 56 Devices found containing: 56 _STA, 0 _INI methods
> > ACPI: Interpreter enabled
> >
> >
> > -------------------------------------------------------
> > The SF.Net email is sponsored by EclipseCon 2004
> > Premiere Conference on Open Tools Development and Integration
> > See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
> > http://www.eclipsecon.org/osdn
> > _______________________________________________
> > Acpi-devel mailing list
> > Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> > https://lists.sourceforge.net/lists/listinfo/acpi-devel
> >
>
>
---1463811327-1581724198-1074619877=:22574
Content-Type: TEXT/plain; charset=US-ASCII; name="dmesg.txt"
Content-Transfer-Encoding: BASE64
Content-Description: 
Content-Disposition: attachment; filename="dmesg.txt"

TGludXggdmVyc2lvbiAyLjYuMSAocm9vdEBsb2NhbGhvc3QpIChnY2MgdmVy
c2lvbiAzLjIuMiAyMDAzMDIyMiAoUmVkIEhhdCBMaW51eCAzLjIuMi01KSkg
IzE0IFR1ZSBKYW4gMjAgMDk6MTE6MDQgUFNUIDIwMDQNCkJJT1MtcHJvdmlk
ZWQgcGh5c2ljYWwgUkFNIG1hcDoNCiBCSU9TLWU4MjA6IDAwMDAwMDAwMDAw
MDAwMDAgLSAwMDAwMDAwMDAwMDlmODAwICh1c2FibGUpDQogQklPUy1lODIw
OiAwMDAwMDAwMDAwMDlmODAwIC0gMDAwMDAwMDAwMDBhMDAwMCAocmVzZXJ2
ZWQpDQogQklPUy1lODIwOiAwMDAwMDAwMDAwMGNlMDAwIC0gMDAwMDAwMDAw
MDBkMDAwMCAocmVzZXJ2ZWQpDQogQklPUy1lODIwOiAwMDAwMDAwMDAwMGRj
MDAwIC0gMDAwMDAwMDAwMDEwMDAwMCAocmVzZXJ2ZWQpDQogQklPUy1lODIw
OiAwMDAwMDAwMDAwMTAwMDAwIC0gMDAwMDAwMDAwZjZlMDAwMCAodXNhYmxl
KQ0KIEJJT1MtZTgyMDogMDAwMDAwMDAwZjZlMDAwMCAtIDAwMDAwMDAwMGY2
ZWMwMDAgKEFDUEkgZGF0YSkNCiBCSU9TLWU4MjA6IDAwMDAwMDAwMGY2ZWMw
MDAgLSAwMDAwMDAwMDBmNzAwMDAwIChBQ1BJIE5WUykNCiBCSU9TLWU4MjA6
IDAwMDAwMDAwMGY3MDAwMDAgLSAwMDAwMDAwMDEwMDAwMDAwIChyZXNlcnZl
ZCkNCiBCSU9TLWU4MjA6IDAwMDAwMDAwZmY4MDAwMDAgLSAwMDAwMDAwMGZm
YzAwMDAwIChyZXNlcnZlZCkNCiBCSU9TLWU4MjA6IDAwMDAwMDAwZmZmMDAw
MDAgLSAwMDAwMDAwMTAwMDAwMDAwIChyZXNlcnZlZCkNCjBNQiBISUdITUVN
IGF2YWlsYWJsZS4NCjI0Nk1CIExPV01FTSBhdmFpbGFibGUuDQpPbiBub2Rl
IDAgdG90YWxwYWdlczogNjMyMDANCiAgRE1BIHpvbmU6IDQwOTYgcGFnZXMs
IExJRk8gYmF0Y2g6MQ0KICBOb3JtYWwgem9uZTogNTkxMDQgcGFnZXMsIExJ
Rk8gYmF0Y2g6MTQNCiAgSGlnaE1lbSB6b25lOiAwIHBhZ2VzLCBMSUZPIGJh
dGNoOjENCkRNSSBwcmVzZW50Lg0KQUNQSTogUlNEUCAodjAwMCBHQVRFV0Eg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICApIEAgMHgwMDBm
NjcxMA0KQUNQSTogUlNEVCAodjAwMSBHQVRFV0EgNDAwVlRYICAgMHgyMDAz
MDMxMiAgTFRQIDB4MDAwMDAwMDApIEAgMHgwZjZlNmQ1Mw0KQUNQSTogRkFE
VCAodjAwMSBHQVRFV0EgNDAwVlRYICAgMHgyMDAzMDMxMiBQVEwgIDB4MDAw
MDAwNTApIEAgMHgwZjZlYmY2NA0KQUNQSTogQk9PVCAodjAwMSBHQVRFV0Eg
NDAwVlRYICAgMHgyMDAzMDMxMiAgTFRQIDB4MDAwMDAwMDEpIEAgMHgwZjZl
YmZkOA0KQUNQSTogRFNEVCAodjAwMSBHQVRFV0EgNDAwVlRYICAgMHgyMDAz
MDMxMiBNU0ZUIDB4MDEwMDAwMGUpIEAgMHgwMDAwMDAwMA0KQnVpbGRpbmcg
em9uZWxpc3QgZm9yIG5vZGUgOiAwDQpLZXJuZWwgY29tbWFuZCBsaW5lOiBy
byByb290PUxBQkVMPS8gaGRjPWlkZS1zY3NpDQppZGVfc2V0dXA6IGhkYz1p
ZGUtc2NzaQ0KSW5pdGlhbGl6aW5nIENQVSMwDQpQSUQgaGFzaCB0YWJsZSBl
bnRyaWVzOiAxMDI0IChvcmRlciAxMDogODE5MiBieXRlcykNCkRldGVjdGVk
IDIxOTEuNzMxIE1IeiBwcm9jZXNzb3IuDQpVc2luZyB0c2MgZm9yIGhpZ2gt
cmVzIHRpbWVzb3VyY2UNCkNvbnNvbGU6IGNvbG91ciBWR0ErIDgweDI1DQpN
ZW1vcnk6IDI0NjQwMGsvMjUyODAwayBhdmFpbGFibGUgKDE3MjNrIGtlcm5l
bCBjb2RlLCA1NjgwayByZXNlcnZlZCwgNzYyayBkYXRhLCAxMzZrIGluaXQs
IDBrIGhpZ2htZW0pDQpDaGVja2luZyBpZiB0aGlzIHByb2Nlc3NvciBob25v
dXJzIHRoZSBXUCBiaXQgZXZlbiBpbiBzdXBlcnZpc29yIG1vZGUuLi4gT2su
DQpDYWxpYnJhdGluZyBkZWxheSBsb29wLi4uIDQzMjUuMzcgQm9nb01JUFMN
CkRlbnRyeSBjYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDMyNzY4IChvcmRl
cjogNSwgMTMxMDcyIGJ5dGVzKQ0KSW5vZGUtY2FjaGUgaGFzaCB0YWJsZSBl
bnRyaWVzOiAxNjM4NCAob3JkZXI6IDQsIDY1NTM2IGJ5dGVzKQ0KTW91bnQt
Y2FjaGUgaGFzaCB0YWJsZSBlbnRyaWVzOiA1MTIgKG9yZGVyOiAwLCA0MDk2
IGJ5dGVzKQ0KY2hlY2tpbmcgaWYgaW1hZ2UgaXMgaW5pdHJhbWZzLi4uaXQg
aXNuJ3QgKG5vIGNwaW8gbWFnaWMpOyBsb29rcyBsaWtlIGFuIGluaXRyZA0K
RnJlZWluZyBpbml0cmQgbWVtb3J5OiAyMjBrIGZyZWVkDQpDUFU6ICAgICBB
ZnRlciBnZW5lcmljIGlkZW50aWZ5LCBjYXBzOiBiZmViZjlmZiAwMDAwMDAw
MCAwMDAwMDAwMCAwMDAwMDAwMA0KQ1BVOiAgICAgQWZ0ZXIgdmVuZG9yIGlk
ZW50aWZ5LCBjYXBzOiBiZmViZjlmZiAwMDAwMDAwMCAwMDAwMDAwMCAwMDAw
MDAwMA0KQ1BVOiBUcmFjZSBjYWNoZTogMTJLIHVvcHMsIEwxIEQgY2FjaGU6
IDhLDQpDUFU6IEwyIGNhY2hlOiAyNTZLDQpDUFU6ICAgICBBZnRlciBhbGwg
aW5pdHMsIGNhcHM6IGJmZWJmOWZmIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAw
MDgwDQpJbnRlbCBtYWNoaW5lIGNoZWNrIGFyY2hpdGVjdHVyZSBzdXBwb3J0
ZWQuDQpJbnRlbCBtYWNoaW5lIGNoZWNrIHJlcG9ydGluZyBlbmFibGVkIG9u
IENQVSMwLg0KQ1BVIzA6IEludGVsIFA0L1hlb24gRXh0ZW5kZWQgTUNFIE1T
UnMgKDEyKSBhdmFpbGFibGUNCkNQVTogSW50ZWwgTW9iaWxlIEludGVsKFIp
IENlbGVyb24oUikgQ1BVIDIuMjBHSHogc3RlcHBpbmcgMDcNCkVuYWJsaW5n
IGZhc3QgRlBVIHNhdmUgYW5kIHJlc3RvcmUuLi4gZG9uZS4NCkVuYWJsaW5n
IHVubWFza2VkIFNJTUQgRlBVIGV4Y2VwdGlvbiBzdXBwb3J0Li4uIGRvbmUu
DQpDaGVja2luZyAnaGx0JyBpbnN0cnVjdGlvbi4uLiBPSy4NClBPU0lYIGNv
bmZvcm1hbmNlIHRlc3RpbmcgYnkgVU5JRklYDQpORVQ6IFJlZ2lzdGVyZWQg
cHJvdG9jb2wgZmFtaWx5IDE2DQpQQ0k6IFBDSSBCSU9TIHJldmlzaW9uIDIu
MTAgZW50cnkgYXQgMHhmZDljMiwgbGFzdCBidXM9Mg0KUENJOiBVc2luZyBj
b25maWd1cmF0aW9uIHR5cGUgMQ0KbXRycjogdjIuMCAoMjAwMjA1MTkpDQpB
Q1BJOiBTdWJzeXN0ZW0gcmV2aXNpb24gMjAwMzEwMDINCiB0YnhmYWNlLTAx
MTcgWzAzXSBhY3BpX2xvYWRfdGFibGVzICAgICAgOiBBQ1BJIFRhYmxlcyBz
dWNjZXNzZnVsbHkgYWNxdWlyZWQNClBhcnNpbmcgYWxsIENvbnRyb2wgTWV0
aG9kczouLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uDQpUYWJsZSBbRFNEVF0oaWQgRjAwNCkgLSA2
ODUgT2JqZWN0cyB3aXRoIDU1IERldmljZXMgMTkzIE1ldGhvZHMgMTUgUmVn
aW9ucw0KQUNQSSBOYW1lc3BhY2Ugc3VjY2Vzc2Z1bGx5IGxvYWRlZCBhdCBy
b290IGMwM2M2Y2ZjDQpBQ1BJOiBJUlEgOSB3YXMgRWRnZSBUcmlnZ2VyZWQs
IHNldHRpbmcgdG8gTGV2ZWwgVHJpZ2dlcmQNCmV2eGZldm50LTAwOTMgWzA0
XSBhY3BpX2VuYWJsZSAgICAgICAgICAgOiBUcmFuc2l0aW9uIHRvIEFDUEkg
bW9kZSBzdWNjZXNzZnVsDQpldmdwZWJsay0wNzQ4IFswNl0gZXZfY3JlYXRl
X2dwZV9ibG9jayAgIDogR1BFIDAwIHRvIDMxIFtfR1BFXSA0IHJlZ3MgYXQg
MDAwMDAwMDAwMDAwMTAyOCBvbiBpbnQgOQ0KQ29tcGxldGluZyBSZWdpb24v
RmllbGQvQnVmZmVyL1BhY2thZ2UgaW5pdGlhbGl6YXRpb246Li4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uDQpJbml0aWFsaXplZCAxMy8xNSBSZWdpb25zIDAvMCBGaWVs
ZHMgMjgvMjggQnVmZmVycyAyMi8yMiBQYWNrYWdlcyAoNjkzIG5vZGVzKQ0K
RXhlY3V0aW5nIGFsbCBEZXZpY2UgX1NUQSBhbmRfSU5JIG1ldGhvZHM6Li4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4NCjU2IERldmljZXMgZm91bmQgY29udGFpbmluZzogNTYgX1NU
QSwgMSBfSU5JIG1ldGhvZHMNCkFDUEk6IEludGVycHJldGVyIGVuYWJsZWQN
CkFDUEk6IFVzaW5nIFBJQyBmb3IgaW50ZXJydXB0IHJvdXRpbmcNCkFDUEk6
IFBDSSBSb290IEJyaWRnZSBbUENJMF0gKDAwOjAwKQ0KUENJOiBQcm9iaW5n
IFBDSSBoYXJkd2FyZSAoYnVzIDAwKQ0KUENJOiBJZ25vcmluZyBCQVIwLTMg
b2YgSURFIGNvbnRyb2xsZXIgMDAwMDowMDoxZi4xDQpUcmFuc3BhcmVudCBi
cmlkZ2UgLSAwMDAwOjAwOjFlLjANCkFDUEk6IFBDSSBJbnRlcnJ1cHQgUm91
dGluZyBUYWJsZSBbXF9TQl8uUENJMC5fUFJUXQ0KQUNQSTogUENJIEludGVy
cnVwdCBSb3V0aW5nIFRhYmxlIFtcX1NCXy5QQ0kwLlBDSUIuX1BSVF0NCkFD
UEk6IFBDSSBJbnRlcnJ1cHQgTGluayBbTE5LQV0gKElSUXMgKjExKQ0KQUNQ
STogUENJIEludGVycnVwdCBMaW5rIFtMTktCXSAoSVJRcyAqMTApDQpBQ1BJ
OiBQQ0kgSW50ZXJydXB0IExpbmsgW0xOS0NdIChJUlFzIDEwKQ0KQUNQSTog
UENJIEludGVycnVwdCBMaW5rIFtMTktEXSAoSVJRcyAqMTEpDQpBQ1BJOiBQ
Q0kgSW50ZXJydXB0IExpbmsgW0xOS0VdIChJUlFzIDExKQ0KQUNQSTogUENJ
IEludGVycnVwdCBMaW5rIFtMTktGXSAoSVJRcyAxMCkNCkFDUEk6IFBDSSBJ
bnRlcnJ1cHQgTGluayBbTE5LR10gKElSUXMgMTEpDQpBQ1BJOiBQQ0kgSW50
ZXJydXB0IExpbmsgW0xOS0hdIChJUlFzICoxMCkNCkFDUEk6IEVtYmVkZGVk
IENvbnRyb2xsZXIgW0hfRUNdIChncGUgMjkpDQpBQ1BJOiBQb3dlciBSZXNv
dXJjZSBbQ0ZBTl0gKG9uKQ0KQUNQSTogUG93ZXIgUmVzb3VyY2UgW0NGTjJd
IChvZmYpDQpBQ1BJOiBQb3dlciBSZXNvdXJjZSBbQ0ZOM10gKG9uKQ0KTGlu
dXggUGx1ZyBhbmQgUGxheSBTdXBwb3J0IHYwLjk3IChjKSBBZGFtIEJlbGF5
DQpwbnA6IHRoZSBkcml2ZXIgJ3N5c3RlbScgaGFzIGJlZW4gcmVnaXN0ZXJl
ZA0KW0FDUEkgRGVidWddIFN0cmluZzogVGVtcGVyYXR1cmUgaW5jcmVhc2lu
ZzogX1E4MA0KW0FDUEkgRGVidWddIFN0cmluZzogVGVtcGVyYXR1cmUgaW5j
cmVhc2luZzogX1E4MA0KU0NTSSBzdWJzeXN0ZW0gaW5pdGlhbGl6ZWQNCkFD
UEk6IFBDSSBJbnRlcnJ1cHQgTGluayBbTE5LQV0gZW5hYmxlZCBhdCBJUlEg
MTENCkFDUEk6IFBDSSBJbnRlcnJ1cHQgTGluayBbTE5LRF0gZW5hYmxlZCBh
dCBJUlEgMTENCkFDUEk6IFBDSSBJbnRlcnJ1cHQgTGluayBbTE5LSF0gZW5h
YmxlZCBhdCBJUlEgMTANCkFDUEk6IFBDSSBJbnRlcnJ1cHQgTGluayBbTE5L
Q10gZW5hYmxlZCBhdCBJUlEgMTANCkFDUEk6IFBDSSBJbnRlcnJ1cHQgTGlu
ayBbTE5LQl0gZW5hYmxlZCBhdCBJUlEgMTANCnBjaV9saW5rLTA0MDMgWzQ0
XSBhY3BpX3BjaV9saW5rX3NldCAgICAgOiBMaW5rIGRpc2FibGVkDQpBQ1BJ
OiBVbmFibGUgdG8gc2V0IElSUSBmb3IgUENJIEludGVycnVwdCBMaW5rIFtM
TktFXSAobGlrZWx5IGJ1Z2d5IEFDUEkgQklPUykuIEFib3J0aW5nIEFDUEkt
YmFzZWQgSVJRIHJvdXRpbmcuIFRyeSBwY2k9bm9hY3BpIG9yIGFjcGk9b2Zm
DQogcGNpX2lycS0wMjYyIFs0MV0gYWNwaV9wY2lfaXJxX2xvb2t1cCAgIDog
SW52YWxpZCBJUlEgbGluayByb3V0aW5nIGVudHJ5DQogcGNpX2lycS0wMzAy
IFs0MV0gYWNwaV9wY2lfaXJxX2Rlcml2ZSAgIDogVW5hYmxlIHRvIGRlcml2
ZSBJUlEgZm9yIGRldmljZSAwMDAwOjAyOjA4LjANCkFDUEk6IE5vIElSUSBr
bm93biBmb3IgaW50ZXJydXB0IHBpbiBBIG9mIGRldmljZSAwMDAwOjAyOjA4
LjANClBDSTogVXNpbmcgQUNQSSBmb3IgSVJRIHJvdXRpbmcNClBDSTogaWYg
eW91IGV4cGVyaWVuY2UgcHJvYmxlbXMsIHRyeSB1c2luZyBvcHRpb24gJ3Bj
aT1ub2FjcGknIG9yIGV2ZW4gJ2FjcGk9b2ZmJw0KU0JGOiBTaW1wbGUgQm9v
dCBGbGFnIGV4dGVuc2lvbiBmb3VuZCBhbmQgZW5hYmxlZC4NClNCRjogU2V0
dGluZyBib290IGZsYWdzIDB4MQ0KTWFjaGluZSBjaGVjayBleGNlcHRpb24g
cG9sbGluZyB0aW1lciBzdGFydGVkLg0KaWtjb25maWcgMC43IHdpdGggL3By
b2MvY29uZmlnKg0KVkZTOiBEaXNrIHF1b3RhcyBkcXVvdF82LjUuMQ0KTlRG
UyBkcml2ZXIgMi4xLjUgW0ZsYWdzOiBSL1ddLg0KSW5pdGlhbGl6aW5nIENy
eXB0b2dyYXBoaWMgQVBJDQpwY2lfaG90cGx1ZzogUENJIEhvdCBQbHVnIFBD
SSBDb3JlIHZlcnNpb246IDAuNQ0KcHR5OiAyMDQ4IFVuaXg5OCBwdHlzIGNv
bmZpZ3VyZWQNClJlYWwgVGltZSBDbG9jayBEcml2ZXIgdjEuMTINClNlcmlh
bDogODI1MC8xNjU1MCBkcml2ZXIgJFJldmlzaW9uOiAxLjkwICQgOCBwb3J0
cywgSVJRIHNoYXJpbmcgZGlzYWJsZWQNCnBucDogdGhlIGRyaXZlciAnc2Vy
aWFsJyBoYXMgYmVlbiByZWdpc3RlcmVkDQpSQU1ESVNLIGRyaXZlciBpbml0
aWFsaXplZDogMTYgUkFNIGRpc2tzIG9mIDQwOTZLIHNpemUgMTAyNCBibG9j
a3NpemUNCmxvb3A6IGxvYWRlZCAobWF4IDggZGV2aWNlcykNClBQUCBnZW5l
cmljIGRyaXZlciB2ZXJzaW9uIDIuNC4yDQpVbmlmb3JtIE11bHRpLVBsYXRm
b3JtIEUtSURFIGRyaXZlciBSZXZpc2lvbjogNy4wMGFscGhhMg0KaWRlOiBB
c3N1bWluZyAzM01IeiBzeXN0ZW0gYnVzIHNwZWVkIGZvciBQSU8gbW9kZXM7
IG92ZXJyaWRlIHdpdGggaWRlYnVzPXh4DQpoZGE6IFRPU0hJQkEgTUszMDIx
R0FTLCBBVEEgRElTSyBkcml2ZQ0KaGRjOiBRU0kgQ0QtUlcvRFZELVJPTSBT
QlctMjQyLCBBVEFQSSBDRC9EVkQtUk9NIGRyaXZlDQpVc2luZyBhbnRpY2lw
YXRvcnkgaW8gc2NoZWR1bGVyDQppZGUwIGF0IDB4MWYwLTB4MWY3LDB4M2Y2
IG9uIGlycSAxNA0KaWRlMSBhdCAweDE3MC0weDE3NywweDM3NiBvbiBpcnEg
MTUNCmhkYTogbWF4IHJlcXVlc3Qgc2l6ZTogMTI4S2lCDQpbQUNQSSBEZWJ1
Z10gU3RyaW5nOiBUZW1wZXJhdHVyZSBpbmNyZWFzaW5nOiBfUTgwDQpoZGE6
IDU4NjA1MTIwIHNlY3RvcnMgKDMwMDA1IE1CKSwgQ0hTPTU4MTQwLzE2LzYz
DQogaGRhOiBoZGExIGhkYTIgaGRhMyBoZGE0IDwgaGRhNSBoZGE2IGhkYTcg
aGRhOCBoZGE5IGhkYTEwID4NCm1pY2U6IFBTLzIgbW91c2UgZGV2aWNlIGNv
bW1vbiBmb3IgYWxsIG1pY2UNCnNlcmlvOiBpODA0MiBBVVggcG9ydCBhdCAw
eDYwLDB4NjQgaXJxIDEyDQpTeW5hcHRpY3MgVG91Y2hwYWQsIG1vZGVsOiAx
DQogRmlybXdhcmU6IDUuOQ0KIFNlbnNvcjogMjgNCiBuZXcgYWJzb2x1dGUg
cGFja2V0IGZvcm1hdA0KIFRvdWNocGFkIGhhcyBleHRlbmRlZCBjYXBhYmls
aXR5IGJpdHMNCiAtPiBmb3VyIGJ1dHRvbnMNCiAtPiBtdWx0aWZpbmdlciBk
ZXRlY3Rpb24NCiAtPiBwYWxtIGRldGVjdGlvbg0KaW5wdXQ6IFN5blBTLzIg
U3luYXB0aWNzIFRvdWNoUGFkIG9uIGlzYTAwNjAvc2VyaW8xDQpzZXJpbzog
aTgwNDIgS0JEIHBvcnQgYXQgMHg2MCwweDY0IGlycSAxDQppbnB1dDogQVQg
VHJhbnNsYXRlZCBTZXQgMiBrZXlib2FyZCBvbiBpc2EwMDYwL3NlcmlvMA0K
TkVUOiBSZWdpc3RlcmVkIHByb3RvY29sIGZhbWlseSAyDQpJUDogcm91dGlu
ZyBjYWNoZSBoYXNoIHRhYmxlIG9mIDIwNDggYnVja2V0cywgMTZLYnl0ZXMN
ClRDUDogSGFzaCB0YWJsZXMgY29uZmlndXJlZCAoZXN0YWJsaXNoZWQgMTYz
ODQgYmluZCAzMjc2OCkNClBNOiBSZWFkaW5nIHBtZGlzayBpbWFnZS4NClBN
OiBSZXN1bWUgZnJvbSBkaXNrIGZhaWxlZC4NCkFDUEk6IChzdXBwb3J0cyBT
MCBTMyBTNCBTNSkNClJBTURJU0s6IENvbXByZXNzZWQgaW1hZ2UgZm91bmQg
YXQgYmxvY2sgMA0KVkZTOiBNb3VudGVkIHJvb3QgKGV4dDIgZmlsZXN5c3Rl
bSkuDQpram91cm5hbGQgc3RhcnRpbmcuICBDb21taXQgaW50ZXJ2YWwgNSBz
ZWNvbmRzDQpFWFQzLWZzOiBtb3VudGVkIGZpbGVzeXN0ZW0gd2l0aCBvcmRl
cmVkIGRhdGEgbW9kZS4NCkZyZWVpbmcgdW51c2VkIGtlcm5lbCBtZW1vcnk6
IDEzNmsgZnJlZWQNCnNwdXJpb3VzIDgyNTlBIGludGVycnVwdDogSVJRNy4N
Ck5FVDogUmVnaXN0ZXJlZCBwcm90b2NvbCBmYW1pbHkgMQ0KZHJpdmVycy91
c2IvY29yZS91c2IuYzogcmVnaXN0ZXJlZCBuZXcgZHJpdmVyIHVzYmZzDQpk
cml2ZXJzL3VzYi9jb3JlL3VzYi5jOiByZWdpc3RlcmVkIG5ldyBkcml2ZXIg
aHViDQplaGNpX2hjZCAwMDAwOjAwOjFkLjc6IEVIQ0kgSG9zdCBDb250cm9s
bGVyDQpQQ0k6IFNldHRpbmcgbGF0ZW5jeSB0aW1lciBvZiBkZXZpY2UgMDAw
MDowMDoxZC43IHRvIDY0DQplaGNpX2hjZCAwMDAwOjAwOjFkLjc6IGlycSAx
MCwgcGNpIG1lbSBkMDAxODAwMA0KZWhjaV9oY2QgMDAwMDowMDoxZC43OiBu
ZXcgVVNCIGJ1cyByZWdpc3RlcmVkLCBhc3NpZ25lZCBidXMgbnVtYmVyIDEN
ClBDSTogY2FjaGUgbGluZSBzaXplIG9mIDEyOCBpcyBub3Qgc3VwcG9ydGVk
IGJ5IGRldmljZSAwMDAwOjAwOjFkLjcNCmVoY2lfaGNkIDAwMDA6MDA6MWQu
NzogVVNCIDIuMCBlbmFibGVkLCBFSENJIDEuMDAsIGRyaXZlciAyMDAzLUp1
bi0xMw0KaHViIDEtMDoxLjA6IFVTQiBodWIgZm91bmQNCmh1YiAxLTA6MS4w
OiA0IHBvcnRzIGRldGVjdGVkDQpkcml2ZXJzL3VzYi9jb3JlL3VzYi5jOiBy
ZWdpc3RlcmVkIG5ldyBkcml2ZXIgaGlkDQpkcml2ZXJzL3VzYi9pbnB1dC9o
aWQtY29yZS5jOiB2Mi4wOlVTQiBISUQgY29yZSBkcml2ZXINCmh1YiAxLTA6
MS4wOiBuZXcgVVNCIGRldmljZSBvbiBwb3J0IDMsIGFzc2lnbmVkIGFkZHJl
c3MgMg0KRVhUMyBGUyBvbiBoZGE3LCBpbnRlcm5hbCBqb3VybmFsDQpBZGRp
bmcgMjY1MDMyayBzd2FwIG9uIC9kZXYvaGRhOS4gIFByaW9yaXR5Oi0xIGV4
dGVudHM6MQ0KSW5pdGlhbGl6aW5nIFVTQiBNYXNzIFN0b3JhZ2UgZHJpdmVy
Li4uDQpzY3NpMCA6IFNDU0kgZW11bGF0aW9uIGZvciBVU0IgTWFzcyBTdG9y
YWdlIGRldmljZXMNCiAgVmVuZG9yOiBVU0IyLjAgICAgTW9kZWw6IENhcmRS
ZWFkZXIgQ0YgUlcgIFJldjogMC4wPg0KICBUeXBlOiAgIERpcmVjdC1BY2Nl
c3MgICAgICAgICAgICAgICAgICAgICAgQU5TSSBTQ1NJIHJldmlzaW9uOiAw
Mg0KQXR0YWNoZWQgc2NzaSByZW1vdmFibGUgZGlzayBzZGEgYXQgc2NzaTAs
IGNoYW5uZWwgMCwgaWQgMCwgbHVuIDANCkF0dGFjaGVkIHNjc2kgZ2VuZXJp
YyBzZzAgYXQgc2NzaTAsIGNoYW5uZWwgMCwgaWQgMCwgbHVuIDAsICB0eXBl
IDANCldBUk5JTkc6IFVTQiBNYXNzIFN0b3JhZ2UgZGF0YSBpbnRlZ3JpdHkg
bm90IGFzc3VyZWQNClVTQiBNYXNzIFN0b3JhZ2UgZGV2aWNlIGZvdW5kIGF0
IDINCmRyaXZlcnMvdXNiL2NvcmUvdXNiLmM6IHJlZ2lzdGVyZWQgbmV3IGRy
aXZlciB1c2Itc3RvcmFnZQ0KVVNCIE1hc3MgU3RvcmFnZSBzdXBwb3J0IHJl
Z2lzdGVyZWQuDQpram91cm5hbGQgc3RhcnRpbmcuICBDb21taXQgaW50ZXJ2
YWwgNSBzZWNvbmRzDQpFWFQzIEZTIG9uIGhkYTMsIGludGVybmFsIGpvdXJu
YWwNCkVYVDMtZnM6IG1vdW50ZWQgZmlsZXN5c3RlbSB3aXRoIG9yZGVyZWQg
ZGF0YSBtb2RlLg0Ka2pvdXJuYWxkIHN0YXJ0aW5nLiAgQ29tbWl0IGludGVy
dmFsIDUgc2Vjb25kcw0KRVhUMyBGUyBvbiBoZGE2LCBpbnRlcm5hbCBqb3Vy
bmFsDQpFWFQzLWZzOiBtb3VudGVkIGZpbGVzeXN0ZW0gd2l0aCBvcmRlcmVk
IGRhdGEgbW9kZS4NCmtqb3VybmFsZCBzdGFydGluZy4gIENvbW1pdCBpbnRl
cnZhbCA1IHNlY29uZHMNCkVYVDMgRlMgb24gaGRhNSwgaW50ZXJuYWwgam91
cm5hbA0KRVhUMy1mczogbW91bnRlZCBmaWxlc3lzdGVtIHdpdGggb3JkZXJl
ZCBkYXRhIG1vZGUuDQpram91cm5hbGQgc3RhcnRpbmcuICBDb21taXQgaW50
ZXJ2YWwgNSBzZWNvbmRzDQpFWFQzIEZTIG9uIGhkYTEwLCBpbnRlcm5hbCBq
b3VybmFsDQpFWFQzLWZzOiBtb3VudGVkIGZpbGVzeXN0ZW0gd2l0aCBvcmRl
cmVkIGRhdGEgbW9kZS4NCmtqb3VybmFsZCBzdGFydGluZy4gIENvbW1pdCBp
bnRlcnZhbCA1IHNlY29uZHMNCkVYVDMgRlMgb24gaGRhOCwgaW50ZXJuYWwg
am91cm5hbA0KRVhUMy1mczogbW91bnRlZCBmaWxlc3lzdGVtIHdpdGggb3Jk
ZXJlZCBkYXRhIG1vZGUuDQpOVEZTIHZvbHVtZSB2ZXJzaW9uIDMuMS4NCmt1
ZHp1OiBudW1lcmljYWwgc3lzY3RsIDEgMjMgaXMgb2Jzb2xldGUuDQpwbnA6
IHRoZSBkcml2ZXIgJ3BhcnBvcnRfcGMnIGhhcyBiZWVuIHJlZ2lzdGVyZWQN
CnBhcnBvcnQwOiBQQy1zdHlsZSBhdCAweDM3OCAoMHg3NzgpIFtQQ1NQUCxU
UklTVEFURV0NCnBhcnBvcnQwOiBpcnEgNyBkZXRlY3RlZA0KcGFycG9ydDA6
IGNwcF9kYWlzeTogYWE1NTAwZmYoMzgpDQpwYXJwb3J0MDogYXNzaWduX2Fk
ZHJzOiBhYTU1MDBmZigzOCkNCnBhcnBvcnQwOiBjcHBfZGFpc3k6IGFhNTUw
MGZmKDM4KQ0KcGFycG9ydDA6IGFzc2lnbl9hZGRyczogYWE1NTAwZmYoMzgp
DQpyZXF1ZXN0X21vZHVsZTogZmFpbGVkIC9zYmluL21vZHByb2JlIC0tIGJs
b2NrLW1ham9yLTItMC4gZXJyb3IgPSAyNTYNCmlwX3RhYmxlczogKEMpIDIw
MDAtMjAwMiBOZXRmaWx0ZXIgY29yZSB0ZWFtDQpORVQ6IFJlZ2lzdGVyZWQg
cHJvdG9jb2wgZmFtaWx5IDE3DQpJbnRlbChSKSBQUk8vMTAwIE5ldHdvcmsg
RHJpdmVyIC0gdmVyc2lvbiAyLjMuMzAtazENCkNvcHlyaWdodCAoYykgMjAw
MyBJbnRlbCBDb3Jwb3JhdGlvbg0KDQpwY2lfbGluay0wNDAzIFs0N10gYWNw
aV9wY2lfbGlua19zZXQgICAgIDogTGluayBkaXNhYmxlZA0KQUNQSTogVW5h
YmxlIHRvIHNldCBJUlEgZm9yIFBDSSBJbnRlcnJ1cHQgTGluayBbTE5LRV0g
KGxpa2VseSBidWdneSBBQ1BJIEJJT1MpLiBBYm9ydGluZyBBQ1BJLWJhc2Vk
IElSUSByb3V0aW5nLiBUcnkgcGNpPW5vYWNwaSBvciBhY3BpPW9mZg0KIHBj
aV9pcnEtMDI2MiBbNDRdIGFjcGlfcGNpX2lycV9sb29rdXAgICA6IEludmFs
aWQgSVJRIGxpbmsgcm91dGluZyBlbnRyeQ0KIHBjaV9pcnEtMDMwMiBbNDRd
IGFjcGlfcGNpX2lycV9kZXJpdmUgICA6IFVuYWJsZSB0byBkZXJpdmUgSVJR
IGZvciBkZXZpY2UgMDAwMDowMjowOC4wDQpBQ1BJOiBObyBJUlEga25vd24g
Zm9yIGludGVycnVwdCBwaW4gQSBvZiBkZXZpY2UgMDAwMDowMjowOC4wDQpl
MTAwOiBzZWxmdGVzdCBPSy4NCmUxMDA6IGV0aDA6IEludGVsKFIpIFBSTy8x
MDAgTmV0d29yayBDb25uZWN0aW9uDQogIEhhcmR3YXJlIHJlY2VpdmUgY2hl
Y2tzdW1zIGVuYWJsZWQNCg0KTGludXggS2VybmVsIENhcmQgU2VydmljZXMN
CiAgb3B0aW9uczogIFtwY2ldIFtjYXJkYnVzXSBbcG1dDQpZZW50YTogQ2Fy
ZEJ1cyBicmlkZ2UgZm91bmQgYXQgMDAwMDowMjowMi4wIFsxMDdiOjA0MDJd
DQpZZW50YTogSVNBIElSUSBtYXNrIDB4MDBiOCwgUENJIGlycSAxMQ0KU29j
a2V0IHN0YXR1czogMzAwMDA0MTENCmNzOiBJTyBwb3J0IHByb2JlIDB4MGMw
MC0weDBjZmY6IGNsZWFuLg0KY3M6IElPIHBvcnQgcHJvYmUgMHgwMTAwLTB4
MDRmZjogZXhjbHVkaW5nIDB4M2MwLTB4M2RmIDB4NGQwLTB4NGQ3DQpjczog
SU8gcG9ydCBwcm9iZSAweDBhMDAtMHgwYWZmOiBjbGVhbi4NCmNzOiBtZW1v
cnkgcHJvYmUgMHhhMDAwMDAwMC0weGEwZmZmZmZmOiBjbGVhbi4NCm9yaW5v
Y28uYyAwLjEzZSAoRGF2aWQgR2lic29uIDxoZXJtZXNAZ2lic29uLmRyb3Bi
ZWFyLmlkLmF1PiBhbmQgb3RoZXJzKQ0Kb3Jpbm9jb19jcy5jIDAuMTNlIChE
YXZpZCBHaWJzb24gPGhlcm1lc0BnaWJzb24uZHJvcGJlYXIuaWQuYXU+IGFu
ZCBvdGhlcnMpDQpldGgxOiBTdGF0aW9uIGlkZW50aXR5IDAwMWY6MDAwMjow
MDAxOjAwMDQNCmV0aDE6IExvb2tzIGxpa2UgYW4gSW50ZXJzaWwgZmlybXdh
cmUgdmVyc2lvbiAxLjQuMg0KZXRoMTogQWQtaG9jIGRlbW8gbW9kZSBzdXBw
b3J0ZWQNCmV0aDE6IElFRUUgc3RhbmRhcmQgSUJTUyBhZC1ob2MgbW9kZSBz
dXBwb3J0ZWQNCmV0aDE6IFdFUCBzdXBwb3J0ZWQsIDEwNC1iaXQga2V5DQpl
dGgxOiBNQUMgYWRkcmVzcyAwMDowNjoyNToxMTowNjo1Mg0KZXRoMTogU3Rh
dGlvbiBuYW1lICJQcmlzbSAgSSINCmV0aDE6IHJlYWR5DQpldGgxOiBpbmRl
eCAweDAxOiBWY2MgNS4wLCBpcnEgMywgaW8gMHgwMTAwLTB4MDEzZg0KUENJ
OiBTZXR0aW5nIGxhdGVuY3kgdGltZXIgb2YgZGV2aWNlIDAwMDA6MDA6MWYu
NSB0byA2NA0KaW50ZWw4eDA6IGNsb2NraW5nIHRvIDQ4MDAwDQpyZXF1ZXN0
X21vZHVsZTogZmFpbGVkIC9zYmluL21vZHByb2JlIC0tIHNuZC1jYXJkLTEu
IGVycm9yID0gMjU2DQpyZXF1ZXN0X21vZHVsZTogZmFpbGVkIC9zYmluL21v
ZHByb2JlIC0tIGNoYXItbWFqb3ItMTAtMTM0LiBlcnJvciA9IDI1Ng0KTGlu
dXggYWdwZ2FydCBpbnRlcmZhY2UgdjAuMTAwIChjKSBEYXZlIEpvbmVzDQph
dGtiZC5jOiBVbmtub3duIGtleSByZWxlYXNlZCAodHJhbnNsYXRlZCBzZXQg
MiwgY29kZSAweDdhIG9uIGlzYTAwNjAvc2VyaW8wKS4NCmF0a2JkLmM6IFVu
a25vd24ga2V5IHJlbGVhc2VkICh0cmFuc2xhdGVkIHNldCAyLCBjb2RlIDB4
N2Egb24gaXNhMDA2MC9zZXJpbzApLg0KW0FDUEkgRGVidWddIFN0cmluZzog
VGVtcGVyYXR1cmUgaW5jcmVhc2luZzogX1E4MA0K

---1463811327-1581724198-1074619877=:22574--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
