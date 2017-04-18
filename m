From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] acpi, nfit: fix module unload vs workqueue shutdown race
Date: Tue, 18 Apr 2017 16:05:56 -0700
Message-ID: <CAPcyv4jGGiVGigQZMaXo_KfReEAJP=XgmD2GVbDW8hCLaF47Kg@mail.gmail.com>
References: <149253869300.4222.11825248275497461939.stgit@dwillia2-desk3.amr.corp.intel.com>
 <58F68D20.5090607@hpe.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <58F68D20.5090607-ZPxbGqLxI0U@public.gmane.org>
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
Cc: Linux ACPI <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Apr 18, 2017 at 3:03 PM, Linda Knippers <linda.knippers-ZPxbGqLxI0U@public.gmane.org> wrote:
> On 04/18/2017 02:06 PM, Dan Williams wrote:
>> The workqueue may still be running when the devres callbacks start
>> firing to deallocate an acpi_nfit_desc instance. Stop and flush the
>> workqueue before letting any other devres de-allocations proceed.
>>
>> Reported-by: Linda Knippers <linda.knippers-ZPxbGqLxI0U@public.gmane.org>
>> Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
>> ---
>>
>> I was able to produce a reliable nfit_test crash failure by running the
>> tests on hardware *and* disabling all debug messages. That last detail
>> may be why I have been seeing much less frequent failures. With this
>> change, in addition to the previous fix [1], I was again able to
>> complete a successful run.
>
> It seems a bit better because I can sometimes get a test to complete
> but then I'll get a panic when I try again.

Some forward progress... let me go back and try your test script on my
bare metal config because this patch only addressed the reliable
failure I was seeing for a single run of "make check".

> The footprints are the same
> as before, sometimes when unloading the module but sometimes in a kfree
> or related function.
>
> I'd be interested in your .config file and exactly how you're building
> your bare metal kernel.

Here's the config and build + install steps I'm performing.

https://gist.github.com/djbw/73946ed4e8623aa1ded1b3615ba6d82b
