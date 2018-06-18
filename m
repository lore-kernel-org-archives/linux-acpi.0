From: "Kani, Toshi" <toshi.kani-ZPxbGqLxI0U@public.gmane.org>
Subject: Re: [PATCH v3 1/2] acpi/nfit: Update nfit driver to comply with ACPI
 6.1
Date: Mon, 18 Jun 2018 19:39:35 +0000
Message-ID: <1529350667.14039.119.camel@hpe.com>
References: <1461620099-11933-1-git-send-email-toshi.kani@hpe.com>
 <1461620099-11933-2-git-send-email-toshi.kani@hpe.com>
 <CAA9_cmenbY9GStibRjO0BfTq0kzzzqThiLeOygJsT9L03BFsBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <CAA9_cmenbY9GStibRjO0BfTq0kzzzqThiLeOygJsT9L03BFsBQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Content-Language: en-US
Content-ID: <DA7E9EEEE7D0534C854733E9A6DF8D30-mmYPd6ayCNGroOM5E8FhRbjFIynDaujOfM0AETQt39g@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: "dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, 2018-06-18 at 12:01 -0700, Dan Williams wrote:
> On Mon, Apr 25, 2016 at 2:43 PM Toshi Kani <toshi.kani-ZPxbGqLxI0U@public.gmane.org> wrote:
> > 
> > ACPI 6.1, Table 5-133, updates NVDIMM Control Region Structure
> > as follows.
> >  - Valid Fields, Manufacturing Location, and Manufacturing Date
> >    are added from reserved range.  No change in the structure size.
> >  - IDs (SPD values) are stored as arrays of bytes (i.e. big-endian
> >    format).  The spec clarifies that they need to be represented
> >    as arrays of bytes as well.
> > 
> 
> Circling back on this a couple years too late... where are you reading
> this "arrays of bytes" note. As far as I can see this is wrong. JEDEC
> says that vendor id is stored LSB of the id is stored at the lowest
> byte in SPD, which is little endian. So it seems Linux has showing the
> incorrect value for a long time now.

This follows ACPI 6.2a section 5.2.25.10 NVDIMM Representation Format,
which Robert cited in his comment below:
https://patchwork.kernel.org/patch/10237609/

Thanks,
-Toshi
