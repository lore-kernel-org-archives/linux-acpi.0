From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v2] libnvdimm, nd_blk: mask off reserved status bits
Date: Mon, 8 Aug 2016 12:36:30 -0700
Message-ID: <CAPcyv4jr4KSsVn-CgJmqYXqcZ=Rah9UP025x-4Uv2rz8S0JW=Q@mail.gmail.com>
References: <20160729205912.20436-1-ross.zwisler@linux.intel.com>
 <20160802182653.6647-1-ross.zwisler@linux.intel.com>
 <20160808191019.GA965@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20160808191019.GA965-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Cc: "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Lee,
 Chun-Yi" <jlee-IBi9RG/b67k@public.gmane.org>, Linux ACPI <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Aug 8, 2016 at 12:10 PM, Ross Zwisler
<ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org> wrote:
> On Tue, Aug 02, 2016 at 12:26:53PM -0600, Ross Zwisler wrote:
>> The "NVDIMM Block Window Driver Writer's Guide":
>>
>> http://pmem.io/documents/
>> http://pmem.io/documents/NVDIMM_DriverWritersGuide-July-2016.pdf
>>
>> defines the layout of the block window status register.  For the July 2016
>> version of the spec linked to above, this happens in Figure 4 on page 26.
>>
>> The only bits defined in this spec are bits 31, 5, 4, 2, 1 and 0.  The rest
>> of the bits in the status register are reserved, and there is a warning
>> following the diagram that says:
>>
>>   Note: The driver cannot assume the value of the RESERVED bits in the
>>   status register are zero. These reserved bits need to be masked off, and
>>   the driver must avoid checking the state of those bits.
>>
>> This change ensures that for hardware implementations that set these
>> reserved bits in the status register, the driver won't incorrectly fail the
>> block I/Os.
>>
>> Signed-off-by: Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
>> Reviewed-by: Lee, Chun-Yi <jlee-IBi9RG/b67k@public.gmane.org>
>> Cc: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> Cc: stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org # v4.2+
>
> Ping on this patch - through which tree should we merge this for v4.8-rc2?
> Dan's nvdimm tree?

It's getting 0-day coverage on my libnvdimm-pending branch and will go
to Linus at the end of the week.
