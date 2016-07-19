From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] acpi,
 nfit: fix acpi_check_dsm() vs zero functions implemented
Date: Tue, 19 Jul 2016 13:01:16 -0700
Message-ID: <CAPcyv4hbyq7MVQrTxYixo+fP7R=wV-Nt84NNfVJKrYWwUSJg=Q@mail.gmail.com>
References: <146679026571.24395.11569929364936343871.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20160719171153.GA121461@tevye.fc.hp.com>
 <cfd9968d-9835-0ef1-fafd-54fd3b892d1c@hpe.com>
 <CAPcyv4gqmjMFveV+iE2NbvWnTb5kdy8w54VDgLYxeMJ5NJyzbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <CAPcyv4gqmjMFveV+iE2NbvWnTb5kdy8w54VDgLYxeMJ5NJyzbw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Linda Knippers <linda.knippers-ZPxbGqLxI0U@public.gmane.org>
Cc: Xiao Guangrong <guangrong.xiao-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>, Marvin Spinhirne <spin-ZPxbGqLxI0U@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Linux ACPI <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jul 19, 2016 at 11:52 AM, Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> On Tue, Jul 19, 2016 at 11:50 AM, Linda Knippers <linda.knippers-ZPxbGqLxI0U@public.gmane.org> wrote:
>> On 7/19/2016 1:11 PM, Jerry Hoemann wrote:
[..]
>>> As nfit_mem->family always equals NVDIMM_FAMILY_INTEL, no subsequent
>>> DSM call will succeed for NVDIMM_FAMILY_HPE1 or any other
>>> family.
>>>
>>> I don't have a fix as of yet, but wanted to make you aware of
>>> the problem.
>>
>> Could we try the all known UUIDs looking for one that returns a non-zero
>> value?
>>
>
> Yes, that seems like the way forward, and also make not finding a DSM
> family non-fatal.

Actually, all we need is that last bit...  Jerry, Xiao, can you try
the attached patch on top for v4.7-rc6 to see if it works in both HPe
and QEMU 2.6 environments respectively?
