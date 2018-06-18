From: Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v3 1/2] acpi/nfit: Update nfit driver to comply with ACPI 6.1
Date: Mon, 18 Jun 2018 12:46:41 -0700
Message-ID: <CAPcyv4jbctFgCob58sjQZ8msGOT7GBe=+Z_2P6YvNrrK-ztMag@mail.gmail.com>
References: <1461620099-11933-1-git-send-email-toshi.kani@hpe.com>
 <1461620099-11933-2-git-send-email-toshi.kani@hpe.com> <CAA9_cmenbY9GStibRjO0BfTq0kzzzqThiLeOygJsT9L03BFsBQ@mail.gmail.com>
 <1529350667.14039.119.camel@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1529350667.14039.119.camel@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Kani, Toshi" <toshi.kani@hpe.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>, "Moore, Robert" <robert.moore@intel.com>, "Li, Juston" <juston.li@intel.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, Jun 18, 2018 at 12:39 PM, Kani, Toshi <toshi.kani@hpe.com> wrote:
> On Mon, 2018-06-18 at 12:01 -0700, Dan Williams wrote:
>> On Mon, Apr 25, 2016 at 2:43 PM Toshi Kani <toshi.kani@hpe.com> wrote:
>> >
>> > ACPI 6.1, Table 5-133, updates NVDIMM Control Region Structure
>> > as follows.
>> >  - Valid Fields, Manufacturing Location, and Manufacturing Date
>> >    are added from reserved range.  No change in the structure size.
>> >  - IDs (SPD values) are stored as arrays of bytes (i.e. big-endian
>> >    format).  The spec clarifies that they need to be represented
>> >    as arrays of bytes as well.
>> >
>>
>> Circling back on this a couple years too late... where are you reading
>> this "arrays of bytes" note. As far as I can see this is wrong. JEDEC
>> says that vendor id is stored LSB of the id is stored at the lowest
>> byte in SPD, which is little endian. So it seems Linux has showing the
>> incorrect value for a long time now.
>
> This follows ACPI 6.2a section 5.2.25.10 NVDIMM Representation Format,
> which Robert cited in his comment below:
> https://patchwork.kernel.org/patch/10237609/

Right, the representation format has the fields big-endian for some
reason, but the individual values for sysfs should be show
little-endian as far as I can see. What am I missing?
