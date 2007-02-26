From: <Jordan_Hargrave@Dell.com>
Subject: Re: acpi_find_bmc() and acpi_get_table()
Date: Mon, 26 Feb 2007 12:30:29 -0600
Message-ID: <5DDAB7BA7BDB58439DD0EED0B8E9A3AE073879@ausx3mpc102.aus.amer.dell.com>
References: <200702102327.28312.lenb@kernel.org>
	<200702152103.54960.bjorn.helgaas@hp.com>
	<45D53DDE.5000300@acm.org>
	<200702192131.52947.bjorn.helgaas@hp.com>
	<45DA9931.80605@linux.intel.com> <45DAFDD8.909@acm.org>
	<20070225215922.GA28931@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C759D4.3155C160"
Return-path: <openipmi-developer-bounces@lists.sourceforge.net>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openipmi-developer>
List-Post: <mailto:openipmi-developer@lists.sourceforge.net>
List-Help: <mailto:openipmi-developer-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openipmi-developer>,
	<mailto:openipmi-developer-request@lists.sourceforge.net?subject=subscribe>
Sender: openipmi-developer-bounces@lists.sourceforge.net
Errors-To: openipmi-developer-bounces@lists.sourceforge.net
To: Matt_Domsch@dell.com, minyard@acm.org
Cc: linux-acpi@vger.kernel.org, alexey.y.starikovskiy@linux.intel.com, bjorn.helgaas@hp.com, openipmi-developer@lists.sourceforge.net, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C759D4.3155C160
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Corey,

  Here is the patch (RHEL5 base code) I've been testing that detects the =
ACPI namespace object.
The IPI0001 device doesn't contain the register spacing directly; it has =
a _CRS resource object that
(for KCS) has two I/O port entries.  I save the first port in =
io.addr_data, then calculate the register spacing based on subtracting =
the 2nd port address and the 1st.

I'm thinking of changing the register spacing to using an array of =
port/memory addresses to make calculating interface addresses more =
generic.

eg.
static unsigned char port_inb(struct si_sm_io *io, unsigned int offset)
{
        unsigned int addr =3D io->addr_data;

        return inb(addr + (offset * io->regspacing));
}

would become something like:
static unsigned char port_inb(struct si_sm_io *io, unsigned int offset)
{
        unsigned int addr =3D io->addr_data[offset];

        return inb(addr);
}

--jordan hargrave
Dell Enterprise Linux Engineering



-----Original Message-----
From: Matt Domsch [mailto:Matt_Domsch@dell.com]
Sent: Sun 2/25/2007 3:59 PM
To: Corey Minyard; Hargrave, Jordan
Cc: Alexey Starikovskiy; linux-acpi@vger.kernel.org; openipmi; Len =
Brown; Bjorn Helgaas
Subject: Re: [Openipmi-developer] acpi_find_bmc() and acpi_get_table()
=20
On Tue, Feb 20, 2007 at 07:55:36AM -0600, Corey Minyard wrote:
> Alexey Starikovskiy wrote:
> > Bjorn Helgaas wrote:
> >> On Thursday 15 February 2007 22:15, Corey Minyard wrote:
> >> =20
> >>> Bjorn Helgaas wrote:
> >>>   =20
> >>>> On Saturday 10 February 2007 21:27, Len Brown wrote:
> >>>>       =20
> >>>>> acpi_find_bmc() appears to be searching for multiple SPMI tables =

> >>>>> in the RSDT and running
> >>>>> try_init_acpi() on each of them
> >>>>> until it doesn't find any more.
> >>>>>            =20
> >>>> I can't remember why we look at the SPMI table(s) rather than
> >>>> registering a normal ACPI (or even PNP) driver.  Unless we
> >>>> need to poke the BMC very early, wouldn't it be better to
> >>>> rely on the device description in the namespace?
> >>>>        =20
> >>> For some strange reason the normal ACPI information does not
> >>> have all the information needed by the driver.  It doesn't have
> >>> register size or spacing information.
> >>>    =20
> >>
> >> I guess that would be a defect in the way ACPI is being used,
> >> wouldn't it?  A PNP ID should define the device programming
> >> model, including things like register size and spacing.  It
> >> sounds like somebody didn't define a new PNP ID when he should
> >> have.  I wonder whether it's worth trying to fix this.
> >>
> >>  =20
> > Yes, it is considered an ACPI fault. Could you please describe in=20
> > detail, which registers miss the information? And probably your=20
> > acpidump will help as well.
> I don't have a machine with an ACPI description of the BMC.  I'll copy =

> the mailing list to see if anyone has an ACPI-described BMC.
>=20
> I don't know that much about ACPI, so maybe that information is=20
> described somehow in a way the IPMI spec doesn't talk about directly,=20
> like in the _CRS object.

Let me copy my teammate Jordan Hargrave in on this, as he's been
working with our BIOS team to implement discovery through an IPI0
object in the namespace, and thinks he can derive the register spacing
and interrupt assignment (if any).

--=20
Matt Domsch
Software Architect
Dell Linux Solutions linux.dell.com & www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com



------_=_NextPart_001_01C759D4.3155C160
Content-Type: text/x-patch;
	name="rhel5.patch"
Content-Transfer-Encoding: base64
Content-Description: rhel5.patch
Content-Disposition: attachment;
	filename="rhel5.patch"

LS0tIC91c3Ivc3JjL3JlZGhhdC9CVUlMRC9rZXJuZWwtMi42LjE4L2xpbnV4LTIuNi4xOC54ODZf
NjQvZHJpdmVycy9jaGFyL2lwbWkvaXBtaV9zaV9pbnRmLmMJMjAwNy0wMi0yNiAxMDo0MDo1NS4w
MDAwMDAwMDAgLTA2MDAKKysrIGlwbWlfc2lfaW50Zi5jCTIwMDctMDItMjYgMTI6MTA6MDUuMDAw
MDAwMDAwIC0wNjAwCkBAIC0xMzcxLDYgKzEzNzEsNTggQEAgc3RhdGljIF9fZGV2aW5pdCB2b2lk
IGhhcmRjb2RlX2ZpbmRfYm1jKAogICAgdGhyb3VnaCB0aGUgdGFibGVzIHNlcXVlbnRpYWxseS4g
IE9uY2Ugd2UgZG9uJ3QgZmluZCBhIHRhYmxlLCB0aGVyZQogICAgYXJlIG5vIG1vcmUuICovCiBz
dGF0aWMgaW50IGFjcGlfZmFpbHVyZSA9IDA7CitzdGF0aWMgYWNwaV9oYW5kbGUgYWNwaV9pcG1p
X2hhbmRsZTsKKworI2RlZmluZSBBQ1BJX0lQTUlfRFJJVkVSX05BTUUgImlwbWkiCisjZGVmaW5l
IEFDUElfSVBNSV9DTEFTUyAgICAgICAiaXBtaSIKKyNkZWZpbmUgQUNQSV9JUE1JX0hJRCAgICAg
ICAgICJJUEkwMDAxIgorCitzdGF0aWMgaW50IGFjcGlfaXBtaV9hZGQoc3RydWN0IGFjcGlfZGV2
aWNlICopOworc3RhdGljIGludCBhY3BpX2lwbWlfcmVtb3ZlKHN0cnVjdCBhY3BpX2RldmljZSAq
LCBpbnQpOworCitzdGF0aWMgc3RydWN0IGFjcGlfZHJpdmVyIGFjcGlfaXBtaV9kcml2ZXIgPSB7
CisgIC5uYW1lID0gQUNQSV9JUE1JX0RSSVZFUl9OQU1FLAorICAuY2xhc3MgPSBBQ1BJX0lQTUlf
Q0xBU1MsCisgIC5pZHMgPSBBQ1BJX0lQTUlfSElELAorICAub3BzID0geworICAgIC5hZGQgPSBh
Y3BpX2lwbWlfYWRkLAorICAgIC5yZW1vdmUgPSBhY3BpX2lwbWlfcmVtb3ZlLAorICB9LAorfTsK
Kworc3RhdGljIGFjcGlfc3RhdHVzCithY3BpX2lwbWlfZ2V0cmVzb3VyY2Uoc3RydWN0IGFjcGlf
cmVzb3VyY2UgKnJlcywgdm9pZCAqY29udGV4dCkKK3sKKwlzdHJ1Y3Qgc21pX2luZm8gKmluZm8g
PSBjb250ZXh0OworCQorCWlmIChyZXMtPnR5cGUgPT0gQUNQSV9SRVNPVVJDRV9UWVBFX0lPKSB7
CisJCXN0cnVjdCBhY3BpX3Jlc291cmNlX2lvICppb19yZXMgPSAmcmVzLT5kYXRhLmlvOworCQlp
ZiAoaW5mby0+aW8uYWRkcl9kYXRhID09IDApIHsKKwkJCWluZm8tPmlvLnJlZ3NoaWZ0ID0gMDsK
KwkJCWluZm8tPmlvLnJlZ3NpemUgPSBpb19yZXMtPmFkZHJlc3NfbGVuZ3RoOworCQkJaW5mby0+
aW8uYWRkcl9kYXRhID0gaW9fcmVzLT5taW5pbXVtOworCQkJaW5mby0+aW8uYWRkcl90eXBlID0g
SVBNSV9JT19BRERSX1NQQUNFOworCQkJaW5mby0+aW9fc2V0dXAgPSBwb3J0X3NldHVwOworCQl9
CisJCWVsc2UgeworCQkJLyogQ2FsY3VsYXRlIHJlZ3NwYWNpbmcgYmFzZWQgb24gcHJldmlvdXMg
cmVnaXN0ZXIgKi8KKwkJCWluZm8tPmlvLnJlZ3NwYWNpbmcgPSBpb19yZXMtPm1pbmltdW0gLSBp
bmZvLT5pby5hZGRyX2RhdGE7CisJCX0KKwl9CisJcmV0dXJuIEFFX09LOworfQorCitpbnQgYWNw
aV9pcG1pX2FkZChzdHJ1Y3QgYWNwaV9kZXZpY2UgKmRldmljZSkKK3sKKwlpZiAoZGV2aWNlKQor
CQlhY3BpX2lwbWlfaGFuZGxlID0gZGV2aWNlLT5oYW5kbGU7CisJcmV0dXJuIDA7Cit9CisKK2lu
dCBhY3BpX2lwbWlfcmVtb3ZlKHN0cnVjdCBhY3BpX2RldmljZSAqZGV2aWNlLCBpbnQgdHlwZSkK
K3sKKwlyZXR1cm4gMDsKK30KIAogLyogRm9yIEdQRS10eXBlIGludGVycnVwdHMuICovCiBzdGF0
aWMgdTMyIGlwbWlfYWNwaV9ncGUodm9pZCAqY29udGV4dCkKQEAgLTE0NzgsNiArMTUzMCw3MiBA
QCBzdHJ1Y3QgU1BNSVRhYmxlIHsKIAlzOCAgICAgIHNwbWlfaWRbMV07IC8qIEEgJ1wwJyB0ZXJt
aW5hdGVkIGFycmF5IHN0YXJ0cyBoZXJlLiAqLwogfTsKIAorc3RhdGljIF9fZGV2aW5pdCBpbnQg
dHJ5X2luaXRfYWNwaWRldigpCit7CisgIAlhY3BpX3N0YXR1cyBzdGF0dXMgPSBBRV9PSzsKKwl1
bnNpZ25lZCBsb25nIHN0YSwgdHlwZSwgZ3BlOworCXN0cnVjdCBzbWlfaW5mbyAgKmluZm87CisK
KwlpZiAoYWNwaV9pcG1pX2hhbmRsZSA9PSAwKQorCSAgCXJldHVybiAtRU5PREVWOworCisJaW5m
byA9IGt6YWxsb2Moc2l6ZW9mKCppbmZvKSwgR0ZQX0tFUk5FTCk7CisJaWYgKGluZm8gPT0gTlVM
TCkgeworCQlwcmludGsoS0VSTl9FUlIgImlwbWlfc2k6IENvdWxkIG5vdCBhbGxvY2F0ZSBTSSBk
YXRhICgzKVxuIik7CisJICAJcmV0dXJuIC1FTk9NRU07CisJfQorCisJc3RhdHVzID0gYWNwaV9l
dmFsdWF0ZV9pbnRlZ2VyKGFjcGlfaXBtaV9oYW5kbGUsICJfU1RBIiwgTlVMTCwgJnN0YSk7CisJ
aWYgKHN0YXR1cyAhPSBBRV9PSyB8fCAhKHN0YSAmIEFDUElfU1RBX0RFVklDRV9QUkVTRU5UKSkg
eworCQlwcmludGsoS0VSTl9FUlIgImlwbWlfc2k6IF9TVEEgbm90IHByZXNlbnRcbiIpOworCQlr
ZnJlZShpbmZvKTsKKwkJcmV0dXJuIC1FTk9ERVY7CisJfQorCisJc3RhdHVzID0gYWNwaV9ldmFs
dWF0ZV9pbnRlZ2VyKGFjcGlfaXBtaV9oYW5kbGUsICJfSUZUIiwgTlVMTCwgJnR5cGUpOworCWlm
IChzdGF0dXMgIT0gQUVfT0spIHsKKwkJcHJpbnRrKEtFUk5fRVJSICJpcG1pX3NpOiBDb3VsZCBu
b3QgZ2V0IF9JRlQgaW50ZXJmYWNlIHR5cGVcbiIpOworCQlrZnJlZShpbmZvKTsKKwkJcmV0dXJu
IC1FTk9ERVY7CisJfQorCXN0YXR1cyA9IGFjcGlfZXZhbHVhdGVfaW50ZWdlcihhY3BpX2lwbWlf
aGFuZGxlLCAiX0dQRSIsIE5VTEwsICZncGUpOworCWlmIChzdGF0dXMgPT0gQUVfT0spIHsKKwkJ
aW5mby0+aXJxID0gZ3BlOworCQlpbmZvLT5pcnFfc2V0dXAgPSBhY3BpX2dwZV9pcnFfc2V0dXA7
CisJfQorCisJaW5mby0+YWRkcl9zb3VyY2UgPSAiQUNQSSI7CisJc3dpdGNoICh0eXBlKSB7CisJ
Y2FzZSAxOgorCQlpbmZvLT5zaV90eXBlID0gU0lfS0NTOworCQlicmVhazsKKwljYXNlIDI6CisJ
CWluZm8tPnNpX3R5cGUgPSBTSV9TTUlDOworCQlicmVhazsKKwljYXNlIDM6CisJCWluZm8tPnNp
X3R5cGUgPSBTSV9CVDsKKwkJYnJlYWs7CisJZGVmYXVsdDoKKwkJcHJpbnRrKEtFUk5fSU5GTyAi
aXBtaV9zaTogVW5rbm93biBBQ1BJL1NQTUkgU0kgdHlwZSAlZFxuIiwKKwkJCXR5cGUpOworCQlr
ZnJlZShpbmZvKTsKKwkJcmV0dXJuIC1FSU87CisJfQorCWFjcGlfd2Fsa19yZXNvdXJjZXMoYWNw
aV9pcG1pX2hhbmRsZSwgTUVUSE9EX05BTUVfX0NSUywKKwkJCSAgICBhY3BpX2lwbWlfZ2V0cmVz
b3VyY2UsIGluZm8pOworCWlmIChpbmZvLT5pby5yZWdzcGFjaW5nID09IDApIHsKKwkJcHJpbnRr
KEtFUk5fRVJSICJpcG1pX3NpOiBDb3VsZCBub3QgZ2V0IHJlZ2lzdGVyIHNwYWNpbmchXG4iKTsK
KwkJa2ZyZWUoaW5mbyk7CisJCXJldHVybiAtRU5PREVWOworCX0KKwlpZiAodHJ5X3NtaV9pbml0
KGluZm8pID09IDApIHsKKwkJcHJpbnRrKEtFUk5fSU5GTyAiaXBtaV9zaTogRm91bmQgQUNQSSBJ
UE1JIGRldmljZSAlcyBhdCAlcyBhZGRyZXNzIDB4JWx4XG4iLAorCQkJc2lfdG9fc3RyW2luZm8t
PnNpX3R5cGVdLCBhZGRyX3NwYWNlX3RvX3N0cltpbmZvLT5pby5hZGRyX3R5cGVdLAorCQkJaW5m
by0+aW8uYWRkcl9kYXRhKTsKKwl9CisJcmV0dXJuIDA7Cit9CisKIHN0YXRpYyBfX2RldmluaXQg
aW50IHRyeV9pbml0X2FjcGkoc3RydWN0IFNQTUlUYWJsZSAqc3BtaSkKIHsKIAlzdHJ1Y3Qgc21p
X2luZm8gICppbmZvOwpAQCAtMTU3Niw2ICsxNjk0LDEyIEBAIHN0YXRpYyBfX2RldmluaXQgdm9p
ZCBhY3BpX2ZpbmRfYm1jKHZvaWQKIAlpZiAoYWNwaV9mYWlsdXJlKQogCQlyZXR1cm47CiAKKwkv
KiBSZWFsbHkgd2Ugb25seSBuZWVkIHRvIGdldCB0aGUgSVBNSSBkZXZpY2UgaGFuZGxlIGhlcmUg
Ki8KKwlhY3BpX2J1c19yZWdpc3Rlcl9kcml2ZXIoJmFjcGlfaXBtaV9kcml2ZXIpOworCWFjcGlf
YnVzX3VucmVnaXN0ZXJfZHJpdmVyKCZhY3BpX2lwbWlfZHJpdmVyKTsKKwlpZiAodHJ5X2luaXRf
YWNwaWRldigpID09IDApCisJCXJldHVybjsKKwogCWZvciAoaSA9IDA7IDsgaSsrKSB7CiAJCXN0
YXR1cyA9IGFjcGlfZ2V0X2Zpcm13YXJlX3RhYmxlKCJTUE1JIiwgaSsxLAogCQkJCQkJIEFDUElf
TE9HSUNBTF9BRERSRVNTSU5HLAo=

------_=_NextPart_001_01C759D4.3155C160
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
------_=_NextPart_001_01C759D4.3155C160
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Openipmi-developer mailing list
Openipmi-developer@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openipmi-developer

------_=_NextPart_001_01C759D4.3155C160--
