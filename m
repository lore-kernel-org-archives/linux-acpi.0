From: Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Subject: Re: Re: Linux 2.4.23-pre8
Date: Mon, 27 Oct 2003 11:19:33 -0200 (BRST)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.44.0310271118340.17121-200000@logos.cnet>
References: <Pine.LNX.4.44.0310271028050.17121-100000@logos.cnet>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-89402102-1067260773=:17121"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44.0310271028050.17121-100000-IP5UegVbiV6sTnJN9+BGXg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Marcelo Tosatti <marcelo.tosatti-3EexvZdKGZRWk0Htik3J/w@public.gmane.org>
Cc: David van Hoose <david.vanhoose-Wuw85uim5zDR7s880joybQ@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime-oOUblnuQwHKola3qYQ6TW/IULO3mGbRi9nwVQlTi/Pw@public.gmane.org for more info.

--8323328-89402102-1067260773=:17121
Content-Type: TEXT/PLAIN; charset=US-ASCII



On Mon, 27 Oct 2003, Marcelo Tosatti wrote:

> 
> 
> On Fri, 24 Oct 2003, David van Hoose wrote:
> 
> > Attached config, boot messages, and interrupts for 2.6.0-test8-bk2.
> > The boot messages do not have any USB debug, but do have ACPI debug. 
> > Also, all of my USB ports work 100% of the time on 2.6 with ACPI enabled.
> 
> David, 
> 
> Have you tried what Len suggested in the bugzilla?
> 
> ----------
> Created an attachment (id=1185)
> SIS I2C quirk foundin 2.6 but not in 2.4
> 
> One difference between 2.4 and 2.6 is the attached SIS quirk added for 
> I2C.
> 
> Please back that quirk out of your 2.6 tree like so:
> 
> patch --dry-run -Rp1 </tmp/sis_quirk_26.diff
> 
> remove the code that depends on it from your .config:
> CONFIG_I2C_SIS96X=n
> 
> and see if that makes 2.6 mis-behave like 2.4, or if USB still runs.
> 
> Also, please verify for me that you get ACPI events properly.
> If you connect your USB mouse to one of the ports that isn't shared
> with acpi, then you should be able to trigger ACPI interrupts by
> pressing your power button.  (if acpid is enabled, it may shut down your
> system,
> so you may want to disable that first), and observering the
> /proc/interrupts row for acpi incrementing for each button press.

Attached is a patch against -test9 to remove the SiS quirks.



--8323328-89402102-1067260773=:17121
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=sis-quirk-test9
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.44.0310271119330.17121-IP5UegVbiV6sTnJN9+BGXg@public.gmane.org>
Content-Description: 
Content-Disposition: attachment; filename=sis-quirk-test9

ZGlmZiAtTnVyIGxpbnV4LTIuNi4wLXRlc3Q5Lm9yaWcvZHJpdmVycy9wY2kv
cXVpcmtzLmMgbGludXgtMi42LjAtdGVzdDkvZHJpdmVycy9wY2kvcXVpcmtz
LmMNCi0tLSBsaW51eC0yLjYuMC10ZXN0OS5vcmlnL2RyaXZlcnMvcGNpL3F1
aXJrcy5jCVNhdCBPY3QgMjUgMTE6NDI6NDcgMjAwMw0KKysrIGxpbnV4LTIu
Ni4wLXRlc3Q5L2RyaXZlcnMvcGNpL3F1aXJrcy5jCU1vbiBPY3QgMjcgMDQ6
Mzk6MzAgMjAwMw0KQEAgLTczNCwzNSArNzM0LDYgQEANCiB9DQogDQogLyoN
Ci0gKiBTaVMgOTZ4IHNvdXRoIGJyaWRnZTogQklPUyB0eXBpY2FsbHkgaGlk
ZXMgU01CdXMgZGV2aWNlLi4uDQotICovDQotc3RhdGljIHZvaWQgX19pbml0
IHF1aXJrX3Npc185Nnhfc21idXMoc3RydWN0IHBjaV9kZXYgKmRldikNCi17
DQotCXU4IHZhbCA9IDA7DQotCXByaW50ayhLRVJOX0lORk8gIkVuYWJsaW5n
IFNpUyA5NnggU01CdXMuXG4iKTsNCi0JcGNpX3JlYWRfY29uZmlnX2J5dGUo
ZGV2LCAweDc3LCAmdmFsKTsNCi0JcGNpX3dyaXRlX2NvbmZpZ19ieXRlKGRl
diwgMHg3NywgdmFsICYgfjB4MTApOw0KLQlwY2lfcmVhZF9jb25maWdfYnl0
ZShkZXYsIDB4NzcsICZ2YWwpOw0KLX0NCi0NCi0vKg0KLSAqIC4uLiBUaGlz
IGlzIGZ1cnRoZXIgY29tcGxpY2F0ZWQgYnkgdGhlIGZhY3QgdGhhdCBzb21l
IFNpUzk2eCBzb3V0aA0KLSAqIGJyaWRnZXMgcHJldGVuZCB0byBiZSA4NUM1
MDMvNTUxMyBpbnN0ZWFkLiAgSW4gdGhhdCBjYXNlIHNlZSBpZiB3ZQ0KLSAq
IHNwb3R0ZWQgYSBjb21wYXRpYmxlIG5vcnRoIGJyaWRnZSB0byBtYWtlIHN1
cmUuDQotICogKHBjaV9maW5kX2RldmljZSBkb2Vzbid0IHdvcmsgeWV0KQ0K
LSAqLw0KLXN0YXRpYyBpbnQgX19kZXZpbml0ZGF0YSBzaXNfOTZ4X2NvbXBh
dGlibGUgPSAwOw0KLQ0KLXN0YXRpYyB2b2lkIF9faW5pdCBxdWlya19zaXNf
NTAzX3NtYnVzKHN0cnVjdCBwY2lfZGV2ICpkZXYpDQotew0KLQlpZiAoc2lz
Xzk2eF9jb21wYXRpYmxlKQ0KLQkJcXVpcmtfc2lzXzk2eF9zbWJ1cyhkZXYp
Ow0KLX0NCi0NCi1zdGF0aWMgdm9pZCBfX2luaXQgcXVpcmtfc2lzXzk2eF9j
b21wYXRpYmxlKHN0cnVjdCBwY2lfZGV2ICpkZXYpDQotew0KLQlzaXNfOTZ4
X2NvbXBhdGlibGUgPSAxOw0KLX0NCiANCiAjaWZkZWYgQ09ORklHX1NDU0lf
U0FUQQ0KIHN0YXRpYyB2b2lkIF9faW5pdCBxdWlya19pbnRlbF9pZGVfY29t
YmluZWQoc3RydWN0IHBjaV9kZXYgKnBkZXYpDQpAQCAtODU0LDE1ICs4MjUs
NiBAQA0KIAl7IFBDSV9GSVhVUF9GSU5BTCwJUENJX1ZFTkRPUl9JRF9JTlRF
TCwgCVBDSV9ERVZJQ0VfSURfSU5URUxfODI0NDNCWF8yLCAJcXVpcmtfbmF0
b21hIH0sDQogCXsgUENJX0ZJWFVQX0ZJTkFMLAlQQ0lfVkVORE9SX0lEX1NJ
LAlQQ0lfREVWSUNFX0lEX1NJXzU1OTcsCQlxdWlya19ub3BjaXBjaSB9LA0K
IAl7IFBDSV9GSVhVUF9GSU5BTCwJUENJX1ZFTkRPUl9JRF9TSSwJUENJX0RF
VklDRV9JRF9TSV80OTYsCQlxdWlya19ub3BjaXBjaSB9LA0KLQl7IFBDSV9G
SVhVUF9IRUFERVIsCVBDSV9WRU5ET1JfSURfU0ksCVBDSV9ERVZJQ0VfSURf
U0lfNTAzLAkJcXVpcmtfc2lzXzUwM19zbWJ1cyB9LA0KLQl7IFBDSV9GSVhV
UF9IRUFERVIsCVBDSV9WRU5ET1JfSURfU0ksCVBDSV9ERVZJQ0VfSURfU0lf
NjQ1LAkJcXVpcmtfc2lzXzk2eF9jb21wYXRpYmxlIH0sDQotCXsgUENJX0ZJ
WFVQX0hFQURFUiwJUENJX1ZFTkRPUl9JRF9TSSwJUENJX0RFVklDRV9JRF9T
SV82NDYsCQlxdWlya19zaXNfOTZ4X2NvbXBhdGlibGUgfSwNCi0JeyBQQ0lf
RklYVVBfSEVBREVSLAlQQ0lfVkVORE9SX0lEX1NJLAlQQ0lfREVWSUNFX0lE
X1NJXzY0OCwJCXF1aXJrX3Npc185NnhfY29tcGF0aWJsZSB9LA0KLQl7IFBD
SV9GSVhVUF9IRUFERVIsCVBDSV9WRU5ET1JfSURfU0ksCVBDSV9ERVZJQ0Vf
SURfU0lfNjUwLAkJcXVpcmtfc2lzXzk2eF9jb21wYXRpYmxlIH0sDQotCXsg
UENJX0ZJWFVQX0hFQURFUiwJUENJX1ZFTkRPUl9JRF9TSSwJUENJX0RFVklD
RV9JRF9TSV82NTEsCQlxdWlya19zaXNfOTZ4X2NvbXBhdGlibGUgfSwNCi0J
eyBQQ0lfRklYVVBfSEVBREVSLAlQQ0lfVkVORE9SX0lEX1NJLAlQQ0lfREVW
SUNFX0lEX1NJXzk2MSwJCXF1aXJrX3Npc185Nnhfc21idXMgfSwNCi0JeyBQ
Q0lfRklYVVBfSEVBREVSLAlQQ0lfVkVORE9SX0lEX1NJLAlQQ0lfREVWSUNF
X0lEX1NJXzk2MiwJCXF1aXJrX3Npc185Nnhfc21idXMgfSwNCi0JeyBQQ0lf
RklYVVBfSEVBREVSLAlQQ0lfVkVORE9SX0lEX1NJLAlQQ0lfREVWSUNFX0lE
X1NJXzk2MywJCXF1aXJrX3Npc185Nnhfc21idXMgfSwNCiAJeyBQQ0lfRklY
VVBfRklOQUwsCVBDSV9WRU5ET1JfSURfQUwsIAlQQ0lfREVWSUNFX0lEX0FM
X00xNjQ3LCAJcXVpcmtfYWxpbWFnaWsgfSwNCiAJeyBQQ0lfRklYVVBfRklO
QUwsCVBDSV9WRU5ET1JfSURfQUwsIAlQQ0lfREVWSUNFX0lEX0FMX00xNjUx
LCAJcXVpcmtfYWxpbWFnaWsgfSwNCiAJeyBQQ0lfRklYVVBfRklOQUwsCVBD
SV9WRU5ET1JfSURfVklBLAlQQ0lfREVWSUNFX0lEX1ZJQV84MzYzXzAsCXF1
aXJrX3ZpYWxhdGVuY3kgfSwNCmRpZmYgLU51ciBsaW51eC0yLjYuMC10ZXN0
OS5vcmlnL2luY2x1ZGUvbGludXgvcGNpX2lkcy5oIGxpbnV4LTIuNi4wLXRl
c3Q5L2luY2x1ZGUvbGludXgvcGNpX2lkcy5oDQotLS0gbGludXgtMi42LjAt
dGVzdDkub3JpZy9pbmNsdWRlL2xpbnV4L3BjaV9pZHMuaAlTYXQgT2N0IDI1
IDExOjQzOjI5IDIwMDMNCisrKyBsaW51eC0yLjYuMC10ZXN0OS9pbmNsdWRl
L2xpbnV4L3BjaV9pZHMuaAlNb24gT2N0IDI3IDA0OjM5OjUxIDIwMDMNCkBA
IC01OTUsOSArNTk1LDYgQEANCiAjZGVmaW5lIFBDSV9ERVZJQ0VfSURfU0lf
NzUyCQkweDA3NTINCiAjZGVmaW5lIFBDSV9ERVZJQ0VfSURfU0lfNzU1CQkw
eDA3NTUNCiAjZGVmaW5lIFBDSV9ERVZJQ0VfSURfU0lfOTAwCQkweDA5MDAN
Ci0jZGVmaW5lIFBDSV9ERVZJQ0VfSURfU0lfOTYxCQkweDA5NjENCi0jZGVm
aW5lIFBDSV9ERVZJQ0VfSURfU0lfOTYyCQkweDA5NjINCi0jZGVmaW5lIFBD
SV9ERVZJQ0VfSURfU0lfOTYzCQkweDA5NjMNCiAjZGVmaW5lIFBDSV9ERVZJ
Q0VfSURfU0lfNTEwNwkJMHg1MTA3DQogI2RlZmluZSBQQ0lfREVWSUNFX0lE
X1NJXzUzMDAJCTB4NTMwMA0KICNkZWZpbmUgUENJX0RFVklDRV9JRF9TSV81
NTExCQkweDU1MTENCg==
--8323328-89402102-1067260773=:17121--


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
