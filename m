From: "Kani, Toshi" <toshi.kani-ZPxbGqLxI0U@public.gmane.org>
Subject: Re: [PATCH 0/4] Adding support to parse BERT for libnvdimm
Date: Fri, 30 Mar 2018 15:04:58 +0000
Message-ID: <1522422276.2693.268.camel@hpe.com>
References: <152236282506.35558.2067249639136170490.stgit@djiang5-desk3.ch.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <152236282506.35558.2067249639136170490.stgit-Cxk7aZI4ujnJARH06PadV2t3HXsI98Cx0E9HWUfgJXw@public.gmane.org>
Content-Language: en-US
Content-ID: <611C14C1B0FB5C43A134DC8BADA16EC5-mmYPd6ayCNGroOM5E8FhRbjFIynDaujOfM0AETQt39g@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: "dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>, "tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, 2018-03-29 at 15:37 -0700, Dave Jiang wrote:
> The following series implements support for parsing of the BERT records
> and adding the error memory ranges to nvdimm badblocks in order for the
> kernel to avoid prevent the kernel from accessing those areas. And with
> the addition of this support, we can surface the nd regions instead of waiting
> for ARS to complete. So the ARS handling is reworked to run in the
> background and not block nd region registration.

Hi Dave,

I agree on the problem, and adding an ability to obtain pmem badblocks
records at boot-time without waiting for a new ARS scan to complete is a
good option for users.

However, I do not think using the BERT table is a good approach.  This
requires FW to report pmem badblocks records with a new interface in
addition to ARS records, which FW already implements for pmem.  ACPI 6.2
defines Start ARS with Flags Bit[1] set to report badblocks record
without starting a new ARS scan.  We set this bit after receiving a 0x81
notification at this point.

Can we use ARS with Flags bit[1] set at boot-time so that both OS and FW
can use the same ARS implementation?

Thanks,
-Toshi
