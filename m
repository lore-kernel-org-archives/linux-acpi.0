From: Petr Olivka <petr.olivka-jmYXjVuSQ4U@public.gmane.org>
Subject: Re: D600: S1 and S3 resume
Date: Wed, 17 Dec 2003 08:42:11 +0100 (CET)
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <Pine.LNX.4.58.0312170828060.7976@pcd403z.vsb.cz>
References: <Pine.LNX.4.30.0311251150140.19330-100000@pcd403z.vsb.cz>
 <20031203181826.GA28870@tate.loria.fr> <Pine.LNX.4.58.0312051054030.2457@pcd403z.vsb.cz>
 <20031208104746.GA21225@tate.loria.fr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-996275822-1494578376-1071646931=:7976"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20031208104746.GA21225-xkTd+U360DcAs8EywTwl9A@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Emmanuel =?iso-8859-1?Q?Thom=E9?= <Emmanuel.Thome-/zGXu1G9BXs@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime-oOUblnuQwHKola3qYQ6TW/IULO3mGbRi9nwVQlTi/Pw@public.gmane.org for more info.

---996275822-1494578376-1071646931=:7976
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE

Sorry my late. I was decompressing and decoding DELL BIOS image
to obtain asm source of smm bios. Now I try to understand it. It is
terrible job.

In attach is my lspci and standby script.
Now I am using "stanby" script with rmmod, in attached script is modules
removing commented out.

poli


On Mon, 8 Dec 2003, Emmanuel [iso-8859-1] Thom=E9 wrote:

>
> This seems pretty odd ; we should have very similar hardware, if not
> identical. Would you mind sending me your lspci -vn ? I'd be interested
> also in having a look to your suspend script.
>
> Note that the only situation in which I've had an oops triggered from
> the usb subsystem was with the original kernel setup: re-enabling all
> usb controllers on resume, regardless of timeouts. My patch explicitely
> fails on controller timeout, which avoids this sort of nasty problems
> (oopsing from rmmod).
>
> Also, do you have any usb device actually plugged into your system when
> suspending ?
>
> You're right poking usb-devel about this sort of woes. There definitely
> is some work to do in order to have usb behave better wrt suspend
> issues.
>
> E.
>
> On Fri, Dec 05, 2003 at 11:05:13AM +0100, Petr Olivka wrote:
> >
> > I did test this patch yesterday, and I have still the same behaviour.
> > After resume from S1 notebook hang. To not hang I everytime stop usbmbr
> > and remove all usb modules, but uhci-hcd fail when unloading:
> >
> > uhci_hcd 0000:00:1d.0: remove, state 1
> > usb usb1: USB disconnect, address 1
> > uhci_hcd 0000:00:1d.0: USB bus 1 deregistered
> > uhci_hcd 0000:00:1d.1: remove, state 1
> > usb usb2: USB disconnect, address 1
> > uhci_hcd 0000:00:1d.1: USB bus 2 deregistered
> > uhci_hcd 0000:00:1d.2: remove, state 1
> > usb usb3: USB disconnect, address 1
> > usb 3-2: USB disconnect, address 2
> > pci_pool_destroy 0000:00:1d.2/uhci_td, def25000 busy
> > uhci_hcd 0000:00:1d.2: USB bus 3 deregistered
> > slab error in kmem_cache_destroy(): cache `uhci_urb_priv': Can't free a=
ll
> > objects
> > Call Trace:
> >  [<c013866d>] __slab_error+0x21/0x28
> >  [<c0138fe4>] kmem_cache_destroy+0x8c/0x114
> >  [<e28e86d0>] uhci_hcd_cleanup+0x18/0x50 [uhci_hcd]
> >  [<c012e54f>] sys_delete_module+0x17b/0x19c
> >  [<c0141510>] sys_munmap+0x44/0x64
> >  [<c0108faf>] syscall_call+0x7/0xb
> >
> > uhci: not all urb_priv's were freed
> >
> > I will forward this problem to usb-devel.
> >
> > thanks
> >   poli
>
>
---996275822-1494578376-1071646931=:7976
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="lspci.vn"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0312170842110.7976-Rd/Vp7eeBLeOZheNW5JDhQ@public.gmane.org>
Content-Description: 
Content-Disposition: attachment; filename="lspci.vn"

MDA6MDAuMCBDbGFzcyAwNjAwOiA4MDg2OjMzNDAgKHJldiAwMykNCglGbGFn
czogYnVzIG1hc3RlciwgZmFzdCBkZXZzZWwsIGxhdGVuY3kgMA0KCU1lbW9y
eSBhdCBlMDAwMDAwMCAoMzItYml0LCBwcmVmZXRjaGFibGUpIFtzaXplPTEy
OE1dDQoJQ2FwYWJpbGl0aWVzOiBbZTRdICMwOSBbZjEwNF0NCglDYXBhYmls
aXRpZXM6IFthMF0gQUdQIHZlcnNpb24gMi4wDQoNCjAwOjAxLjAgQ2xhc3Mg
MDYwNDogODA4NjozMzQxIChyZXYgMDMpDQoJRmxhZ3M6IGJ1cyBtYXN0ZXIs
IDY2TWh6LCBmYXN0IGRldnNlbCwgbGF0ZW5jeSAzMg0KCUJ1czogcHJpbWFy
eT0wMCwgc2Vjb25kYXJ5PTAxLCBzdWJvcmRpbmF0ZT0wMSwgc2VjLWxhdGVu
Y3k9MzINCglJL08gYmVoaW5kIGJyaWRnZTogMDAwMGMwMDAtMDAwMGNmZmYN
CglNZW1vcnkgYmVoaW5kIGJyaWRnZTogZmMwMDAwMDAtZmRmZmZmZmYNCglQ
cmVmZXRjaGFibGUgbWVtb3J5IGJlaGluZCBicmlkZ2U6IGU4MDAwMDAwLWVm
ZmZmZmZmDQoNCjAwOjFkLjAgQ2xhc3MgMGMwMzogODA4NjoyNGMyIChyZXYg
MDEpDQoJU3Vic3lzdGVtOiA4MDg2OjQ1NDENCglGbGFnczogYnVzIG1hc3Rl
ciwgbWVkaXVtIGRldnNlbCwgbGF0ZW5jeSAwLCBJUlEgMTENCglJL08gcG9y
dHMgYXQgYmY4MCBbc2l6ZT0zMl0NCg0KMDA6MWQuMSBDbGFzcyAwYzAzOiA4
MDg2OjI0YzQgKHJldiAwMSkNCglTdWJzeXN0ZW06IDgwODY6NDU0MQ0KCUZs
YWdzOiBidXMgbWFzdGVyLCBtZWRpdW0gZGV2c2VsLCBsYXRlbmN5IDAsIElS
USAxMQ0KCUkvTyBwb3J0cyBhdCBiZjQwIFtzaXplPTMyXQ0KDQowMDoxZC4y
IENsYXNzIDBjMDM6IDgwODY6MjRjNyAocmV2IDAxKQ0KCVN1YnN5c3RlbTog
ODA4Njo0NTQxDQoJRmxhZ3M6IGJ1cyBtYXN0ZXIsIG1lZGl1bSBkZXZzZWws
IGxhdGVuY3kgMCwgSVJRIDExDQoJSS9PIHBvcnRzIGF0IGJmMjAgW3NpemU9
MzJdDQoNCjAwOjFkLjcgQ2xhc3MgMGMwMzogODA4NjoyNGNkIChyZXYgMDEp
IChwcm9nLWlmIDIwKQ0KCVN1YnN5c3RlbTogMTAyODowMTFkDQoJRmxhZ3M6
IGJ1cyBtYXN0ZXIsIG1lZGl1bSBkZXZzZWwsIGxhdGVuY3kgMCwgSVJRIDEx
DQoJTWVtb3J5IGF0IGY0ZmZmYzAwICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFi
bGUpIFtzaXplPTFLXQ0KCUNhcGFiaWxpdGllczogWzUwXSBQb3dlciBNYW5h
Z2VtZW50IHZlcnNpb24gMg0KCUNhcGFiaWxpdGllczogWzU4XSAjMGEgWzIw
ODBdDQoNCjAwOjFlLjAgQ2xhc3MgMDYwNDogODA4NjoyNDQ4IChyZXYgODEp
DQoJRmxhZ3M6IGJ1cyBtYXN0ZXIsIGZhc3QgZGV2c2VsLCBsYXRlbmN5IDAN
CglCdXM6IHByaW1hcnk9MDAsIHNlY29uZGFyeT0wMiwgc3Vib3JkaW5hdGU9
MDIsIHNlYy1sYXRlbmN5PTMyDQoJSS9PIGJlaGluZCBicmlkZ2U6IDAwMDBk
MDAwLTAwMDBlZmZmDQoJTWVtb3J5IGJlaGluZCBicmlkZ2U6IGY2MDAwMDAw
LWZiZmZmZmZmDQoNCjAwOjFmLjAgQ2xhc3MgMDYwMTogODA4NjoyNGNjIChy
ZXYgMDEpDQoJRmxhZ3M6IGJ1cyBtYXN0ZXIsIG1lZGl1bSBkZXZzZWwsIGxh
dGVuY3kgMA0KDQowMDoxZi4xIENsYXNzIDAxMDE6IDgwODY6MjRjYSAocmV2
IDAxKSAocHJvZy1pZiA4YSBbTWFzdGVyIFNlY1AgUHJpUF0pDQoJU3Vic3lz
dGVtOiA4MDg2OjQ1NDENCglGbGFnczogYnVzIG1hc3RlciwgbWVkaXVtIGRl
dnNlbCwgbGF0ZW5jeSAwLCBJUlEgMTENCglJL08gcG9ydHMgYXQgPGlnbm9y
ZWQ+DQoJSS9PIHBvcnRzIGF0IDxpZ25vcmVkPg0KCUkvTyBwb3J0cyBhdCA8
aWdub3JlZD4NCglJL08gcG9ydHMgYXQgPGlnbm9yZWQ+DQoJSS9PIHBvcnRz
IGF0IGJmYTAgW3NpemU9MTZdDQoJTWVtb3J5IGF0IDIwMDAwMDAwICgzMi1i
aXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTFLXQ0KDQowMDoxZi41IENs
YXNzIDA0MDE6IDgwODY6MjRjNSAocmV2IDAxKQ0KCVN1YnN5c3RlbTogMTAy
ODowMTFkDQoJRmxhZ3M6IGJ1cyBtYXN0ZXIsIG1lZGl1bSBkZXZzZWwsIGxh
dGVuY3kgMCwgSVJRIDExDQoJSS9PIHBvcnRzIGF0IGI4MDAgW3NpemU9MjU2
XQ0KCUkvTyBwb3J0cyBhdCBiYzQwIFtzaXplPTY0XQ0KCU1lbW9yeSBhdCBm
NGZmZjgwMCAoMzItYml0LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT01MTJd
DQoJTWVtb3J5IGF0IGY0ZmZmNDAwICgzMi1iaXQsIG5vbi1wcmVmZXRjaGFi
bGUpIFtzaXplPTI1Nl0NCglDYXBhYmlsaXRpZXM6IFs1MF0gUG93ZXIgTWFu
YWdlbWVudCB2ZXJzaW9uIDINCg0KMDA6MWYuNiBDbGFzcyAwNzAzOiA4MDg2
OjI0YzYgKHJldiAwMSkNCglTdWJzeXN0ZW06IDE0ZjE6NTQyMg0KCUZsYWdz
OiBtZWRpdW0gZGV2c2VsLCBJUlEgMTENCglJL08gcG9ydHMgYXQgYjQwMCBb
c2l6ZT0yNTZdDQoJSS9PIHBvcnRzIGF0IGIwODAgW3NpemU9MTI4XQ0KCUNh
cGFiaWxpdGllczogWzUwXSBQb3dlciBNYW5hZ2VtZW50IHZlcnNpb24gMg0K
DQowMTowMC4wIENsYXNzIDAzMDA6IDEwMDI6NGM2NiAocmV2IDAxKQ0KCVN1
YnN5c3RlbTogMTAyODowMTFkDQoJRmxhZ3M6IGJ1cyBtYXN0ZXIsIFZHQSBw
YWxldHRlIHNub29wLCBzdGVwcGluZywgNjZNaHosIG1lZGl1bSBkZXZzZWws
IGxhdGVuY3kgMzIsIElSUSAxMQ0KCU1lbW9yeSBhdCBlODAwMDAwMCAoMzIt
Yml0LCBwcmVmZXRjaGFibGUpIFtzaXplPTEyOE1dDQoJSS9PIHBvcnRzIGF0
IGMwMDAgW3NpemU9MjU2XQ0KCU1lbW9yeSBhdCBmY2ZmMDAwMCAoMzItYml0
LCBub24tcHJlZmV0Y2hhYmxlKSBbc2l6ZT02NEtdDQoJRXhwYW5zaW9uIFJP
TSBhdCA8dW5hc3NpZ25lZD4gW2Rpc2FibGVkXSBbc2l6ZT0xMjhLXQ0KCUNh
cGFiaWxpdGllczogWzU4XSBBR1AgdmVyc2lvbiAyLjANCglDYXBhYmlsaXRp
ZXM6IFs1MF0gUG93ZXIgTWFuYWdlbWVudCB2ZXJzaW9uIDINCg0KMDI6MDAu
MCBDbGFzcyAwMjAwOiAxNGU0OjE2YTYgKHJldiAwMikNCglTdWJzeXN0ZW06
IDEwMjg6ODEyNg0KCUZsYWdzOiBidXMgbWFzdGVyLCA2Nk1oeiwgbWVkaXVt
IGRldnNlbCwgbGF0ZW5jeSA2NCwgSVJRIDExDQoJTWVtb3J5IGF0IGZhZmYw
MDAwICg2NC1iaXQsIG5vbi1wcmVmZXRjaGFibGUpIFtzaXplPTY0S10NCglD
YXBhYmlsaXRpZXM6IFs0MF0gIzA3IFswMDAwXQ0KCUNhcGFiaWxpdGllczog
WzQ4XSBQb3dlciBNYW5hZ2VtZW50IHZlcnNpb24gMg0KCUNhcGFiaWxpdGll
czogWzUwXSBWaXRhbCBQcm9kdWN0IERhdGENCglDYXBhYmlsaXRpZXM6IFs1
OF0gTWVzc2FnZSBTaWduYWxsZWQgSW50ZXJydXB0czogNjRiaXQrIFF1ZXVl
PTAvMyBFbmFibGUtDQoNCjAyOjAxLjAgQ2xhc3MgMDYwNzogMTIxNzo3MTEz
IChyZXYgMjApDQoJU3Vic3lzdGVtOiAxMDI4OjAxMWQNCglGbGFnczogYnVz
IG1hc3Rlciwgc3RlcHBpbmcsIHNsb3cgZGV2c2VsLCBsYXRlbmN5IDE2OCwg
SVJRIDExDQoJTWVtb3J5IGF0IDIwMDAxMDAwICgzMi1iaXQsIG5vbi1wcmVm
ZXRjaGFibGUpIFtzaXplPTRLXQ0KCUJ1czogcHJpbWFyeT0wMiwgc2Vjb25k
YXJ5PTAzLCBzdWJvcmRpbmF0ZT0wNiwgc2VjLWxhdGVuY3k9MTc2DQoJTWVt
b3J5IHdpbmRvdyAwOiAyMDQwMDAwMC0yMDdmZjAwMCAocHJlZmV0Y2hhYmxl
KQ0KCU1lbW9yeSB3aW5kb3cgMTogMjA4MDAwMDAtMjBiZmYwMDANCglJL08g
d2luZG93IDA6IDAwMDA0MDAwLTAwMDA0MGZmDQoJSS9PIHdpbmRvdyAxOiAw
MDAwNDQwMC0wMDAwNDRmZg0KCTE2LWJpdCBsZWdhY3kgaW50ZXJmYWNlIHBv
cnRzIGF0IDAwMDENCg0KMDI6MDEuMSBDbGFzcyAwNjA3OiAxMjE3OjcxMTMg
KHJldiAyMCkNCglTdWJzeXN0ZW06IDEwMjg6MDExZA0KCUZsYWdzOiBidXMg
bWFzdGVyLCBzdGVwcGluZywgc2xvdyBkZXZzZWwsIGxhdGVuY3kgMTY4LCBJ
UlEgMTENCglNZW1vcnkgYXQgMjAwMDIwMDAgKDMyLWJpdCwgbm9uLXByZWZl
dGNoYWJsZSkgW3NpemU9NEtdDQoJQnVzOiBwcmltYXJ5PTAyLCBzZWNvbmRh
cnk9MDcsIHN1Ym9yZGluYXRlPTBhLCBzZWMtbGF0ZW5jeT0xNzYNCglNZW1v
cnkgd2luZG93IDA6IDIwYzAwMDAwLTIwZmZmMDAwIChwcmVmZXRjaGFibGUp
DQoJTWVtb3J5IHdpbmRvdyAxOiAyMTAwMDAwMC0yMTNmZjAwMA0KCUkvTyB3
aW5kb3cgMDogMDAwMDQ4MDAtMDAwMDQ4ZmYNCglJL08gd2luZG93IDE6IDAw
MDA0YzAwLTAwMDA0Y2ZmDQoJMTYtYml0IGxlZ2FjeSBpbnRlcmZhY2UgcG9y
dHMgYXQgMDAwMQ0KDQo=

---996275822-1494578376-1071646931=:7976
Content-Type: TEXT/PLAIN; charset=US-ASCII; name=standby
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.58.0312170842111.7976-Rd/Vp7eeBLeOZheNW5JDhQ@public.gmane.org>
Content-Description: 
Content-Disposition: attachment; filename=standby

IyEvYmluL3NoDQoNCi4gL2V0Yy9wcm9maWxlIA0KDQpVU0JNR1I9L2V0Yy9p
bml0LmQvdXNibWdyDQpBVU1JWD0vZXRjL2luaXQuZC9hdW1peA0KUENNQ0lB
PS9ldGMvaW5pdC5kL3BjbWNpYQ0KDQpMQ0Q9Ii9yb290L3JhZGVvbi9yYWRl
b250b29sIGxpZ2h0Ig0KDQppZiBbIC1mIC90bXAvLlgwLWxvY2sgXQ0KICB0
aGVuDQogICAgTENEPSJ4c2V0IC1kaXNwbGF5IDowLjAgZHBtcyBmb3JjZSIN
CmZpDQoNCg0KJFVTQk1HUiBzdG9wDQokUENNQ0lBIHN0b3ANCiRBVU1JWCBz
dG9wDQppZmRvd24gZXRoMCANCg0KI2ZvciBpIGluIGBsc21vZCB8IGF3ayAn
e3ByaW50ICQxO30nYDsgZG8gcm1tb2QgJGk7IHNsZWVwIDAuMTsgZG9uZQ0K
DQpzeW5jDQokTENEIG9mZg0KaGRwYXJtIC15IC9kZXYvaGRhDQoNCmVjaG8g
MSA+IC9wcm9jL2FjcGkvc2xlZXANCiNlY2hvIC1uICJzdGFuZGJ5IiA+IC9z
eXMvcG93ZXIvc3RhdGUNCg0KJExDRCBvbg0KDQovZXRjL2luaXQuZC9tb2R1
dGlscyBzdGFydA0KDQppZnVwIGV0aDANCg0KJFVTQk1HUiBzdGFydA0KJFBD
TUNJQSBzdGFydA0KJEFVTUlYIHN0YXJ0DQoNCg==

---996275822-1494578376-1071646931=:7976--


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
