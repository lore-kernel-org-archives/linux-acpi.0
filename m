From: "Kani, Toshimitsu" <toshi.kani@hpe.com>
Subject: Re: [PATCH 3/3] ghes_edac: add platform check to enable ghes_edac
Date: Mon, 24 Jul 2017 18:12:18 +0000
Message-ID: <1500919377.2042.66.camel@hpe.com>
References: <1500650732.2042.45.camel@hpe.com>
         <20170721124401.5f94aba9@vento.lan>    <1500654661.2042.49.camel@hpe.com>
         <20170721140131.40079805@vento.lan>    <20170721172344.GA11316@nazgul.tnic>
         <1500661773.2042.53.camel@hpe.com>     <20170722062853.GA2050@nazgul.tnic>
         <1500907209.2042.55.camel@hpe.com>     <20170724150432.GA31295@nazgul.tnic>
         <1500909372.2042.58.camel@hpe.com>     <20170724153716.GA17708@nazgul.tnic>
         <1500911226.2042.60.camel@hpe.com> <20170724145606.3686ba39@vento.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170724145606.3686ba39@vento.lan>
Content-Language: en-US
Content-ID: <D98825691C954A4EAA0E33F691F7E606@NAMPRD84.PROD.OUTLOOK.COM>
Sender: linux-kernel-owner@vger.kernel.org
To: "mchehab@s-opensource.com" <mchehab@s-opensource.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>, "mchehab@kernel.org" <mchehab@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "srinivas.pandruvada@linux.intel.com" <srinivas.pandruvada@linux.intel.com>, "bp@alien8.de" <bp@alien8.de>, "tony.luck@intel.com" <tony.luck@intel.com>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

T24gTW9uLCAyMDE3LTA3LTI0IGF0IDE0OjU2IC0wMzAwLCBNYXVybyBDYXJ2YWxobyBDaGVoYWIg
d3JvdGU6DQo+IEVtIE1vbiwgMjQgSnVsIDIwMTcgMTU6NTY6MjcgKzAwMDANCiA6DQo+IFRoYXQn
cyBwcm9iYWJseSB0b28gbGF0ZSBmb3IgbWUgYXMgSSByZWNlaXZlZCBhIG5ldyBIUCBtYWNoaW5l
DQo+IHdlIGJvdWdodCBqdXN0IGxhc3Qgd2VlaywgYnV0IGZvciB0aGUgbmV4dCB0aW1lIEkgd291
bGQgbmVlZCB0bw0KPiBnZXQgYSBuZXcgaGFyZHdhcmUsIHdoYXQgd291bGQgYmUgdGhlIG5vbi1S
QVMgZXF1aXZhbGVudCB0bw0KPiBhIE1MIDM1MCBHOSB0b3dlci1tb3VudGVkIG1hY2hpbmUgd2l0
aCB0d28gWGVvbiB2NCBDUFVzIGFuZCBpTE8/DQoNClN1Y2ggc2VydmVycyBhcmUgY2FsbGVkICJI
UEUgQ2xvdWRsaW5lIi4gIEJ1dCBJIHRoaW5rIHRoZXkgYXJlIGFsbA0KcmFjay1tb3VudGVkLCBu
b3QgdG93ZXItbW91bnRlZCBtYWNoaW5lcy4gIEhQIEluYy4gKHdoaWNoIGlzIG5vdyBhDQpzZXBh
cmF0ZSBjb21wYW55IGZvciBjb25zdW1lci1vcmllbnRlZCBwcm9kdWN0cykgcHJvYmFibHkgaGFz
IHN1Y2gNCm1hY2hpbmUuDQoNClRoYW5rcywNCi1Ub3NoaQ0K
