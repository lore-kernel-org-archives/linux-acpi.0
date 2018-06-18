From: "Elliott, Robert (Persistent Memory)" <elliott-ZPxbGqLxI0U@public.gmane.org>
Subject: RE: [PATCH v3 1/2] acpi/nfit: Update nfit driver to comply with ACPI
 6.1
Date: Mon, 18 Jun 2018 21:37:39 +0000
Message-ID: <AT5PR8401MB1169FA8B55B36BAE8DF0F6EBAB710@AT5PR8401MB1169.NAMPRD84.PROD.OUTLOOK.COM>
References: <1461620099-11933-1-git-send-email-toshi.kani@hpe.com>
 <1461620099-11933-2-git-send-email-toshi.kani@hpe.com>
 <CAA9_cmenbY9GStibRjO0BfTq0kzzzqThiLeOygJsT9L03BFsBQ@mail.gmail.com>
 <1529350667.14039.119.camel@hpe.com>
 <CAPcyv4jbctFgCob58sjQZ8msGOT7GBe=+Z_2P6YvNrrK-ztMag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <CAPcyv4jbctFgCob58sjQZ8msGOT7GBe=+Z_2P6YvNrrK-ztMag-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: 'Dan Williams' <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Kani, Toshi" <toshi.kani-ZPxbGqLxI0U@public.gmane.org>
Cc: "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "Moore,
 Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org



> -----Original Message-----
> From: Dan Williams [mailto:dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org]
> Sent: Monday, June 18, 2018 2:47 PM
> To: Kani, Toshi <toshi.kani-ZPxbGqLxI0U@public.gmane.org>
> Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org; Moore, Robert
> <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>; Li, Juston <juston.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>;
> rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org; linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Elliott, Robert (Persistent
> Memory) <elliott-ZPxbGqLxI0U@public.gmane.org>
> Subject: Re: [PATCH v3 1/2] acpi/nfit: Update nfit driver to comply with
> ACPI 6.1
> 
> On Mon, Jun 18, 2018 at 12:39 PM, Kani, Toshi <toshi.kani-ZPxbGqLxI0U@public.gmane.org> wrote:
> > On Mon, 2018-06-18 at 12:01 -0700, Dan Williams wrote:
> >> On Mon, Apr 25, 2016 at 2:43 PM Toshi Kani <toshi.kani-ZPxbGqLxI0U@public.gmane.org> wrote:
> >> >
> >> > ACPI 6.1, Table 5-133, updates NVDIMM Control Region Structure
> >> > as follows.
> >> >  - Valid Fields, Manufacturing Location, and Manufacturing Date
> >> >    are added from reserved range.  No change in the structure size.
> >> >  - IDs (SPD values) are stored as arrays of bytes (i.e. big-endian
> >> >    format).  The spec clarifies that they need to be represented
> >> >    as arrays of bytes as well.
> >> >
> >>
> >> Circling back on this a couple years too late... where are you reading
> >> this "arrays of bytes" note. As far as I can see this is wrong. JEDEC
> >> says that vendor id is stored LSB of the id is stored at the lowest
> >> byte in SPD, which is little endian. So it seems Linux has showing the
> >> incorrect value for a long time now.
> >
> > This follows ACPI 6.2a section 5.2.25.10 NVDIMM Representation Format,
> > which Robert cited in his comment below:
> > https://patchwork.kernel.org/patch/10237609/
> 
> Right, the representation format has the fields big-endian for some
> reason, but the individual values for sysfs should be show
> little-endian as far as I can see. What am I missing?

In practice, the serial numbers from three major DDR4 DIMM manufacturers
are being assigned as big-endian, like in this set of NVDIMM-Ns:
/sys/bus/nd/devices/nmem0/nfit/serial:0x122f8255
/sys/bus/nd/devices/nmem1/nfit/serial:0x122f7f5e
/sys/bus/nd/devices/nmem2/nfit/serial:0x122f818f
/sys/bus/nd/devices/nmem3/nfit/serial:0x122f821c
/sys/bus/nd/devices/nmem4/nfit/serial:0x122f817e
/sys/bus/nd/devices/nmem5/nfit/serial:0x122f81cd
/sys/bus/nd/devices/nmem6/nfit/serial:0x122f821e
/sys/bus/nd/devices/nmem7/nfit/serial:0x122f819b
/sys/bus/nd/devices/nmem8/nfit/serial:0x122f81a2
/sys/bus/nd/devices/nmem9/nfit/serial:0x122f8198
/sys/bus/nd/devices/nmem10/nfit/serial:0x122f8193
/sys/bus/nd/devices/nmem11/nfit/serial:0x122f7f58
/sys/bus/nd/devices/nmem12/nfit/serial:0x122f81cb
/sys/bus/nd/devices/nmem13/nfit/serial:0x122f8181
/sys/bus/nd/devices/nmem14/nfit/serial:0x122f8210
/sys/bus/nd/devices/nmem15/nfit/serial:0x122f821f

and this set of regular DIMMs:
396851B4
3968134C
396852DA
396850AB
39685A13
39685317
396852DD
396852D9

Of the possible approaches for the sysfs nfit field decodes:
fixed big-endian:
  matches printed label content (text and barcode)
  matches ACPI display advice for management tools
  probably matches SMBIOS Serial Number string format (although
    that depends on the system firmware)
  requires user to know that this OS uses big-endian
  has been upstream for a while now
fixed little-endian:
  harder to see that cd812f12 matches 122f81cd seen elsewhere
  harder to notice that B4516839 is a peer of 4C136839
  might match other little-endian-only OSes
  requires user to know that this OS uses little-endian
native endian:
  most confusing
  config/status files referencing the DIMMs are not portable
  requires user to know that this OS uses native endianness
  requires user to know the CPU endianness
  was upstream several years ago
