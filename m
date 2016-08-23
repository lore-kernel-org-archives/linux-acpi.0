From: Vishal Verma <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/3] acpi, nfit: nvdimm notification support + tests
Date: Tue, 23 Aug 2016 16:39:57 -0600
Message-ID: <20160823223957.GC7799@omniknight.lm.intel.com>
References: <147198925154.3136.14739108342311837939.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <147198925154.3136.14739108342311837939.stgit-p8uTFz9XbKj2zm6wflaqv1nYeNYlB/vhral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 08/23, Dan Williams wrote:
> ACPI 6.1 added an "NFIT Health Event Notification" for nvdimm devices.
> When this fires, system software is expected to issue a DSM to retrieve
> the latest health values.  For the NFIT driver this notification
> arrives as an event on the sysfs 'flags' attribute for an nfit/nvdimm
> device.  The 'flags' attribute reflects the "NVDIMM State Flags" of the
> "5.2.25.3 NVDIMM Region Mapping Structure", and when read indicates if
> the platform supports sending health events.
> 
> ---
> 
> Dan Williams (3):
>       tools/testing/nvdimm: unit test for acpi_nfit_notify()
>       acpi, nfit: add dimm device notification support
>       tools/testing/nvdimm: unit test for acpi_nvdimm_notify()
> 
> 
>  drivers/acpi/nfit/core.c          |  112 ++++++++++++++++++++++++++++++++-----
>  drivers/acpi/nfit/nfit.h          |    7 ++
>  drivers/nvdimm/dimm_devs.c        |    6 ++
>  include/linux/libnvdimm.h         |    1 
>  tools/testing/nvdimm/Kbuild       |    1 
>  tools/testing/nvdimm/test/iomap.c |   17 ++++++
>  tools/testing/nvdimm/test/nfit.c  |   64 +++++++++++++++++++--
>  7 files changed, 188 insertions(+), 20 deletions(-)

Looks good to me. For the series,

Reviewed-by: Vishal Verma <vishal.l.verma-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
