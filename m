From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: Warning: pnp 00:0b: can't evaluate _CRS: 12311
Date: Wed, 25 Apr 2012 15:57:27 -0600
Message-ID: <CAErSpo7Yj6_QZCSeNKXksiYayV53gkUubVBTnRRu8z1pyWeMQQ@mail.gmail.com>
References: <CA+icZUWVwUr19xL0Dn5mHnZjQaVjj6VYD3BMMktEWO0vgoZEXw@mail.gmail.com>
 <CA+icZUUGFaz0c-tHa9EGUxZaxPj_M=zrE+kE0dv5UMoA6GyN3w@mail.gmail.com>
 <CAErSpo5vZSf_EZr6-XnAA8N2Luv6rA92YtZsidWZCZ8rarkPUQ@mail.gmail.com>
 <CA+icZUU+asnLWAevwqKBgnvrmKNitL8-0+8ijDii4pt9VsjspA@mail.gmail.com>
 <94F2FBAB4432B54E8AACC7DFDE6C92E346A77806@ORSMSX101.amr.corp.intel.com>
 <CAErSpo5E3E=A+EEAZjmkYc8x3B==9ZtYufNaG4t8xQegtOfxfA@mail.gmail.com> <94F2FBAB4432B54E8AACC7DFDE6C92E346A77908@ORSMSX101.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <94F2FBAB4432B54E8AACC7DFDE6C92E346A77908@ORSMSX101.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Moore, Robert" <robert.moore@intel.com>
Cc: "sedat.dilek@gmail.com" <sedat.dilek@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Lin, Ming M" <ming.m.lin@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Wed, Apr 25, 2012 at 3:39 PM, Moore, Robert <robert.moore@intel.com>=
 wrote:
> This disassembly might make more sense. From the looks of the ASL, se=
veral of the address base and length fields are being updated dynamical=
ly. =A0I don't see anything that would corrupt a resource descriptor, h=
owever.
>
>
> Are we certain that the ACPI Error and pnp messages are directly rela=
ted to the PNP0C02 device ID?
>
> [ =A0 =A00.293699] system 00:0a: Plug and Play ACPI device, IDs PNP0c=
02 (active)
> [ =A0 =A00.294032] ACPI Error: Invalid/unsupported resource descripto=
r: Type 0x00 (20120320/utresrc-650)
> [ =A0 =A00.294037] pnp 00:0b: can't evaluate _CRS: 12311

Oh, I'm sorry, I just wasted your time.  I didn't notice the 0a/0b
mismatch.  You're right, the _CRS error is on 00:0b, and we don't know
what the path is or the PNP ID for 00:0b.

Sedat, can you run "grep . /sys/bus/pnp/devices/*/id" please?  That
will at least show us the PNP ID of device 00:0b.

Bjorn
