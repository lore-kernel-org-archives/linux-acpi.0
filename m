From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 5/6] nfit, address-range-scrub: rework and simplify ARS
 state machine
Date: Tue, 3 Apr 2018 08:33:58 -0700
Message-ID: <CAPcyv4hbt-YNA_NA6Sic7Uzfg6EVwtPPyztFrGPjoYze9nfT9g@mail.gmail.com>
References: <152273076087.38372.4803377088477706610.stgit@dwillia2-desk3.amr.corp.intel.com>
 <152273078779.38372.13062348829183334140.stgit@dwillia2-desk3.amr.corp.intel.com>
 <f4c0ca57-3c4a-9805-a66a-6a61aec2b108@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <f4c0ca57-3c4a-9805-a66a-6a61aec2b108-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: Linux ACPI <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-nvdimm <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 3, 2018 at 8:29 AM, Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
>
[..]
>> +               if (test_and_set_bit(ARS_REQ, &nfit_spa->ars_state))
>> +                       busy++;
>> +               else {
>> +                       if (flags == ND_ARS_RETURN_PREV_DATA)
>
>
> if (flags & ND_ARS_RETURN_PREV_DATA)?
>
> I think the spec allows other bits set in the flag byte.
>

True, and it might be better to pass in the kernel's ARS_SHORT flag
rather than the firmware interface value.
