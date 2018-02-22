From: Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH] acpi: add NFIT and HMAT to the initrd override list
Date: Thu, 22 Feb 2018 14:12:24 -0700
Message-ID: <20180222211224.GA29462@linux.intel.com>
References: <151275056532.8020.17160155121603376532.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20171218195405.GA18900@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171218195405.GA18900-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
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
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Dec 18, 2017 at 12:54:05PM -0700, Ross Zwisler wrote:
> On Fri, Dec 08, 2017 at 08:29:25AM -0800, Dan Williams wrote:
> > These tables, NFIT and HMAT, are essential for describing
> > next-generation platform memory topologies and performance
> > characteristics. Allow them to be overridden for debug and test and
> > purposes.
> > 
> > Cc: Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> 
> Yes please!  This works in my test setup for inserting custom HMAT tables, and
> I would really like to have this for testing my HMAT series:
> 
> https://lists.01.org/pipermail/linux-nvdimm/2017-December/013571.html
> 
> Reviewed-by: Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> 
> > Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

Ping on this patch - can we get this merged?
