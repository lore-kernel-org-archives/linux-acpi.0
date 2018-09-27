From: Keith Busch <keith.busch-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH 0/3] acpi, nfit: Add dirty shutdown count to sysfs
Date: Thu, 27 Sep 2018 09:21:40 -0600
Message-ID: <20180927152140.GA19589@localhost.localdomain>
References: <153802226065.833068.11943510429252969385.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180927071135.GB6959@linux-x5ow.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180927071135.GB6959-qw2SdCWA0PpjqqEj2zc+bA@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Johannes Thumshirn <jthumshirn-l3A5Bk7waGM@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Thu, Sep 27, 2018 at 09:11:35AM +0200, Johannes Thumshirn wrote:
> On Wed, Sep 26, 2018 at 09:24:20PM -0700, Dan Williams wrote:
> > The Intel NVDIMM command specification publishes a dirty-shutdown-count
> > in addition to the dirty-shutdown / flush-failed indication that comes
> > from the ACPI NFIT. This is expected to be a common property of NVDIMMs
> > and is a static hardware health detail to be cached / exported via
> > sysfs.
> > 
> > Add plumbing for retrieving this data at driver load time, publish the
> > count, and use the dynamically retrieved dirty-shutdown indicator to
> > augment the existing 'flush_failed' flag.
> 
> Is this the same thing as the LSS Latch stuff that went into ndctl?

On a related note, the ndctl latch implementation doesn't satisfy all
the needs, so I expect it'll be reverted

  https://lists.01.org/pipermail/linux-nvdimm/2018-September/017892.html
