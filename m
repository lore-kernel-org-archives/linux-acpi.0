From: "Ow Mun Heng" <ow.mun.heng-Sjgp3cTcYWE@public.gmane.org>
Subject: Success : S4 Suspend to Disk on D600
Date: Mon, 1 Mar 2004 11:42:14 +0800
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <C386328088ED7F4E9F81AFBABDDF60DA045C6D77@wdmyexch02.my.asia.wdc.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_001_01C3FF3F.2FE6F71E"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
content-class: urn:content-classes:message
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Acpi-List (E-mail)" <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

This is a multi-part message in MIME format.

------_=_NextPart_001_01C3FF3F.2FE6F71E
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi All,

RH9 + D600 + 2.6.3 kernel (acpi-20040211 patch + laptop mode)
suspend is compiled into the kernel
tg3/sound/usb as modules

I just want to report success with this configuration.
To suspend, I need to 1st, remove tg3 (ethernet) modules.
Then I blank the display (xset, though it's not really good since
we go back to console and ACPI spits out messages)
USB is dead after resuming.. but doing a rmmod uhci_hcd and then
modprobing it resurrected the usb.


Suspend is initiated using echo 4 > /proc/acpi/sleep and using=20
the Fn-Suspend key passing to acpid events. Kinda long to write 500+Mb=20
but.. oh what the heck. it's Good)


I've tried S1 and S3..no Dice. The suspend works ok.. but=20
on powering on.. hard disk spins up.. no Console/X11.
(I guess this is a known issue)

I've yet to try removing sound and usb modules from the kernel.
More experimenting needed to see if S1 and S3 works.


PS : S3/S1 is useful only because it resumes Fast right? but still
draws power. hmm.. might not be so useful for me. :)

Cheers,                                               =20
Mun Heng, Ow                                           =20


------_=_NextPart_001_01C3FF3F.2FE6F71E
Content-Type: text/plain;
	name="suspend.txt"
Content-Transfer-Encoding: base64
Content-Description: suspend.txt
Content-Disposition: attachment;
	filename="suspend.txt"

TWFyICAxIDA5OjM1OjE2IG5ldXJvbWFuY2VyIGtlcm5lbDogU3RvcHBpbmcgdGFza3M6ID09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09fA0KTWFyICAxIDA5OjM1OjE2IG5ldXJv
bWFuY2VyIGtlcm5lbDogRnJlZWluZyBtZW1vcnk6IC4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4u
Li4uLi4uLi4uLi4uLi4uLi4uLi4uLi4uLi4ufA0KTWFyICAxIDA5OjM1OjE2IG5ldXJvbWFuY2Vy
IGtlcm5lbDogaGRjOiBzdGFydF9wb3dlcl9zdGVwKHN0ZXA6IDApDQpNYXIgIDEgMDk6MzU6MTYg
bmV1cm9tYW5jZXIga2VybmVsOiBoZGM6IGNvbXBsZXRpbmcgUE0gcmVxdWVzdCwgc3VzcGVuZA0K
TWFyICAxIDA5OjM1OjE2IG5ldXJvbWFuY2VyIGtlcm5lbDogaGRhOiBzdGFydF9wb3dlcl9zdGVw
KHN0ZXA6IDApDQpNYXIgIDEgMDk6MzU6MTYgbmV1cm9tYW5jZXIga2VybmVsOiBoZGE6IGNvbXBs
ZXRpbmcgUE0gcmVxdWVzdCwgc3VzcGVuZA0KTWFyICAxIDA5OjM1OjE2IG5ldXJvbWFuY2VyIGtl
cm5lbDogL2NyaXRpY2FsIHNlY3Rpb246IENvdW50aW5nIHBhZ2VzIHRvIGNvcHlbbm9zYXZlIGMw
NGIyMDAwXSAocGFnZXMgbmVlZGVkOiA1OTkzKzUxMj02NTA1IGZyZWU6IDEyNDk5NikNCk1hciAg
MSAwOTozNToxNiBuZXVyb21hbmNlciBrZXJuZWw6IEFsbG9jIHBhZ2VkaXINCk1hciAgMSAwOToz
NToxNiBuZXVyb21hbmNlciBrZXJuZWw6IFtub3NhdmUgYzA0YjIwMDBdPDQ+RnJlZWluZyBwcmV2
IGFsbG9jYXRlZCBwYWdlZGlyDQpNYXIgIDEgMDk6MzU6MjIgbmV1cm9tYW5jZXIga2VybmVsOiBo
ZGE6IFdha2V1cCByZXF1ZXN0IGluaXRlZCwgd2FpdGluZyBmb3IgIUJTWS4uLg0KTWFyICAxIDA5
OjM1OjI1IG5ldXJvbWFuY2VyIGtlcm5lbDogaGRhOiBzdGFydF9wb3dlcl9zdGVwKHN0ZXA6IDEw
MDApDQpNYXIgIDEgMDk6MzU6MzEgbmV1cm9tYW5jZXIga2VybmVsOiBoZGE6IGNvbXBsZXRpbmcg
UE0gcmVxdWVzdCwgcmVzdW1lDQpNYXIgIDEgMDk6MzU6MzQgbmV1cm9tYW5jZXIga2VybmVsOiBo
ZGM6IFdha2V1cCByZXF1ZXN0IGluaXRlZCwgd2FpdGluZyBmb3IgIUJTWS4uLg0KTWFyICAxIDA5
OjM1OjM3IG5ldXJvbWFuY2VyIGtlcm5lbDogaGRjOiBzdGFydF9wb3dlcl9zdGVwKHN0ZXA6IDEw
MDApDQpNYXIgIDEgMDk6MzU6MzggbmV1cm9tYW5jZXIga2VybmVsOiBoZGM6IGNvbXBsZXRpbmcg
UE0gcmVxdWVzdCwgcmVzdW1lDQpNYXIgIDEgMDk6MzU6MzggbmV1cm9tYW5jZXIga2VybmVsOiBG
aXhpbmcgc3dhcCBzaWduYXR1cmVzLi4uIG9rDQpNYXIgIDEgMDk6MzU6MzggbmV1cm9tYW5jZXIg
a2VybmVsOiBCYWRuZXNzIGluIHJlZHJhd19zY3JlZW4gYXQgZHJpdmVycy9jaGFyL3Z0LmM6NjA3
DQpNYXIgIDEgMDk6MzU6MzggbmV1cm9tYW5jZXIga2VybmVsOiBDYWxsIFRyYWNlOg0KTWFyICAx
IDA5OjM1OjM4IG5ldXJvbWFuY2VyIGtlcm5lbDogIFs8YzAyYjJiNDg+XSByZWRyYXdfc2NyZWVu
KzB4MjE4LzB4MjIwDQpNYXIgIDEgMDk6MzU6MzggbmV1cm9tYW5jZXIga2VybmVsOiAgWzxjMDEz
NzM5ND5dIGRvX21hZ2ljX3Jlc3VtZV8yKzB4ZDQvMHgxMDANCk1hciAgMSAwOTozNTozOCBuZXVy
b21hbmNlciBrZXJuZWw6ICBbPGMwMzI1NTRmPl0gZG9fbWFnaWMrMHgxMWYvMHgxMzANCk1hciAg
MSAwOTozNTozOCBuZXVyb21hbmNlciBrZXJuZWw6ICBbPGMwMTM3NWQ2Pl0gc29mdHdhcmVfc3Vz
cGVuZCsweGE2LzB4YzANCk1hciAgMSAwOTozNTozOSBuZXVyb21hbmNlciBrZXJuZWw6ICBbPGMw
MjkyYjgyPl0gYWNwaV9zeXN0ZW1fd3JpdGVfc2xlZXArMHhhYi8weGM5DQpNYXIgIDEgMDk6MzU6
MzkgbmV1cm9tYW5jZXIga2VybmVsOiAgWzxjMDE1NjA5ZT5dIHZmc193cml0ZSsweGJlLzB4MTMw
DQpNYXIgIDEgMDk6MzU6MzkgbmV1cm9tYW5jZXIga2VybmVsOiAgWzxjMDE1NjFjMj5dIHN5c193
cml0ZSsweDQyLzB4NzANCk1hciAgMSAwOTozNTozOSBuZXVyb21hbmNlciBrZXJuZWw6ICBbPGMw
MTA5NDg5Pl0gc3lzZW50ZXJfcGFzdF9lc3ArMHg1Mi8weDcxDQpNYXIgIDEgMDk6MzU6MzkgbmV1
cm9tYW5jZXIga2VybmVsOg0KTWFyICAxIDA5OjM1OjM5IG5ldXJvbWFuY2VyIGtlcm5lbDogQmFk
bmVzcyBpbiBzZXRfb3JpZ2luIGF0IGRyaXZlcnMvY2hhci92dC5jOjU3OQ0KTWFyICAxIDA5OjM1
OjM5IG5ldXJvbWFuY2VyIGtlcm5lbDogQ2FsbCBUcmFjZToNCk1hciAgMSAwOTozNTozOSBuZXVy
b21hbmNlciBrZXJuZWw6ICBbPGMwMmIyOTIyPl0gc2V0X29yaWdpbisweGMyLzB4ZDANCk1hciAg
MSAwOTozNTozOSBuZXVyb21hbmNlciBrZXJuZWw6ICBbPGMwMmIyYTc4Pl0gcmVkcmF3X3NjcmVl
bisweDE0OC8weDIyMA0KTWFyICAxIDA5OjM1OjM5IG5ldXJvbWFuY2VyIGtlcm5lbDogIFs8YzAx
MzczOTQ+XSBkb19tYWdpY19yZXN1bWVfMisweGQ0LzB4MTAwDQpNYXIgIDEgMDk6MzU6MzkgbmV1
cm9tYW5jZXIga2VybmVsOiAgWzxjMDMyNTU0Zj5dIGRvX21hZ2ljKzB4MTFmLzB4MTMwDQpNYXIg
IDEgMDk6MzU6MzkgbmV1cm9tYW5jZXIga2VybmVsOiAgWzxjMDEzNzVkNj5dIHNvZnR3YXJlX3N1
c3BlbmQrMHhhNi8weGMwDQpNYXIgIDEgMDk6MzU6MzkgbmV1cm9tYW5jZXIga2VybmVsOiAgWzxj
MDI5MmI4Mj5dIGFjcGlfc3lzdGVtX3dyaXRlX3NsZWVwKzB4YWIvMHhjOQ0KTWFyICAxIDA5OjM1
OjM5IG5ldXJvbWFuY2VyIGtlcm5lbDogIFs8YzAxNTYwOWU+XSB2ZnNfd3JpdGUrMHhiZS8weDEz
MA0KTWFyICAxIDA5OjM1OjM5IG5ldXJvbWFuY2VyIGtlcm5lbDogIFs8YzAxNTYxYzI+XSBzeXNf
d3JpdGUrMHg0Mi8weDcwDQpNYXIgIDEgMDk6MzU6MzkgbmV1cm9tYW5jZXIga2VybmVsOiAgWzxj
MDEwOTQ4OT5dIHN5c2VudGVyX3Bhc3RfZXNwKzB4NTIvMHg3MQ0KTWFyICAxIDA5OjM1OjM5IG5l
dXJvbWFuY2VyIGtlcm5lbDoNCk1hciAgMSAwOTozNTozOSBuZXVyb21hbmNlciBrZXJuZWw6IEJh
ZG5lc3MgaW4gc2V0X3BhbGV0dGUgYXQgZHJpdmVycy9jaGFyL3Z0LmM6Mjg2NA0KTWFyICAxIDA5
OjM1OjM5IG5ldXJvbWFuY2VyIGtlcm5lbDogQ2FsbCBUcmFjZToNCk1hciAgMSAwOTozNTozOSBu
ZXVyb21hbmNlciBrZXJuZWw6ICBbPGMwMmI3MTI4Pl0gc2V0X3BhbGV0dGUrMHg4OC8weDkwDQpN
YXIgIDEgMDk6MzU6MzkgbmV1cm9tYW5jZXIga2VybmVsOiAgWzxjMDJiMmE5Mj5dIHJlZHJhd19z
Y3JlZW4rMHgxNjIvMHgyMjANCk1hciAgMSAwOTozNTozOSBuZXVyb21hbmNlciBrZXJuZWw6ICBb
PGMwMTM3Mzk0Pl0gZG9fbWFnaWNfcmVzdW1lXzIrMHhkNC8weDEwMA0KTWFyICAxIDA5OjM1OjM5
IG5ldXJvbWFuY2VyIGtlcm5lbDogIFs8YzAzMjU1NGY+XSBkb19tYWdpYysweDExZi8weDEzMA0K
TWFyICAxIDA5OjM1OjM5IG5ldXJvbWFuY2VyIGtlcm5lbDogIFs8YzAxMzc1ZDY+XSBzb2Z0d2Fy
ZV9zdXNwZW5kKzB4YTYvMHhjMA0KTWFyICAxIDA5OjM1OjM5IG5ldXJvbWFuY2VyIGtlcm5lbDog
IFs8YzAyOTJiODI+XSBhY3BpX3N5c3RlbV93cml0ZV9zbGVlcCsweGFiLzB4YzkNCk1hciAgMSAw
OTozNTozOSBuZXVyb21hbmNlciBrZXJuZWw6ICBbPGMwMTU2MDllPl0gdmZzX3dyaXRlKzB4YmUv
MHgxMzANCk1hciAgMSAwOTozNTozOSBuZXVyb21hbmNlciBrZXJuZWw6ICBbPGMwMTU2MWMyPl0g
c3lzX3dyaXRlKzB4NDIvMHg3MA0KTWFyICAxIDA5OjM1OjM5IG5ldXJvbWFuY2VyIGtlcm5lbDog
IFs8YzAxMDk0ODk+XSBzeXNlbnRlcl9wYXN0X2VzcCsweDUyLzB4NzENCk1hciAgMSAwOTozNToz
OSBuZXVyb21hbmNlciBrZXJuZWw6DQpNYXIgIDEgMDk6MzU6MzkgbmV1cm9tYW5jZXIga2VybmVs
OiBSZXN0YXJ0aW5nIHRhc2tzLi4uIGRvbmUNCg0K

------_=_NextPart_001_01C3FF3F.2FE6F71E--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
