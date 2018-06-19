From: "Elliott, Robert (Persistent Memory)" <elliott-ZPxbGqLxI0U@public.gmane.org>
Subject: RE: [PATCH v3 1/2] acpi/nfit: Update nfit driver to comply with ACPI
 6.1
Date: Tue, 19 Jun 2018 14:31:28 +0000
Message-ID: <AT5PR8401MB1169ECE7D26644D39DB735D5AB700@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <1461620099-11933-1-git-send-email-toshi.kani@hpe.com>
 <1461620099-11933-2-git-send-email-toshi.kani@hpe.com>
 <CAA9_cmenbY9GStibRjO0BfTq0kzzzqThiLeOygJsT9L03BFsBQ@mail.gmail.com>
 <1529350667.14039.119.camel@hpe.com>
 <CAPcyv4jbctFgCob58sjQZ8msGOT7GBe=+Z_2P6YvNrrK-ztMag@mail.gmail.com>
 <AT5PR8401MB1169FA8B55B36BAE8DF0F6EBAB710@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
 <CAPcyv4goV+VR15qpio-wqDpDS3nXsfYEbTSk1Ws6DPp6ECKcRQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <CAPcyv4goV+VR15qpio-wqDpDS3nXsfYEbTSk1Ws6DPp6ECKcRQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: 'Dan Williams' <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "Moore,
 Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Dan Williams [mailto:dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]
> Sent: Monday, June 18, 2018 4:47 PM
> To: Elliott, Robert (Persistent Memory) <elliott-ZPxbGqLxI0U@public.gmane.org>
> Cc: Kani, Toshi <toshi.kani-ZPxbGqLxI0U@public.gmane.org>; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-
> nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org; Moore, Robert <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Li, Juston
> <juston.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org; linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [PATCH v3 1/2] acpi/nfit: Update nfit driver to comply with
> ACPI 6.1


> Let's take something simple like Vendor ID. What is the Vendor ID for
> these DIMMs and what does Linux print in sysfs?

Here are some examples (kernel 4.17):

$ cd /sys/bus/nd/devices/nmem0/nfit
$ grep -s . *
device:0x314e
dsm_mask:0x3c76
family:1
flags:smart_notify
format:0x0101
formats:1
handle:0x1
id:802c-0f-1612-122f8255	[SPD bytes 320-328, in that order left-to-right]
phys_id:0x16
rev_id:0x3100
serial:0x122f8255
subsystem_device:0x3141
subsystem_rev_id:0x0100
subsystem_vendor:0x8034	[Cypress Semiconductor]
vendor:0x802c		[Micron]

$ cd /sys/bus/nd/devices/nmem1/nfit
$ grep -s . *
device:0x314e
dsm_mask:0x3c76
family:1
flags:smart_notify
format:0x0101
formats:1
handle:0x2
id:802c-0f-1612-122f7f5e
phys_id:0x15
rev_id:0x3100
serial:0x122f7f5e
subsystem_device:0x3141
subsystem_rev_id:0x0100
subsystem_vendor:0x8034
vendor:0x802c

Some corresponding information for those NVDIMM-Ns as reported by dmidecode:

Handle 0x00A8, DMI type 237, 9 bytes
OEM-specific Type
        Header and Data:
                ED 09 A8 00 16 00 01 02 03
        Strings:
                Micron		[Module manufacturer]
                18ASF1G72XF12G1Y11AA	[Module part number]
                122F8255	[Module serial number]

Handle 0x00A7, DMI type 237, 9 bytes
OEM-specific Type
        Header and Data:
                ED 09 A7 00 15 00 01 02 03
        Strings:
                Micron
                18ASF1G72XF12G1Y11AA
                122F7F5E
