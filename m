From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/5] Teach EDAC about non-volatile DIMMs and add partial
 support to skx_edac
Date: Wed, 28 Feb 2018 05:59:25 -0800
Message-ID: <CAPcyv4iHr9nUAS0SiFeqqDkU8NXZ_x=rkD3YS010Dy-nbHJXmA@mail.gmail.com>
References: <20180222195811.27237-1-tony.luck@intel.com>
 <20180228130410.GC3769@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20180228130410.GC3769-fF5Pk5pvG8Y@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: Jean Delvare <jdelvare-IBi9RG/b67k@public.gmane.org>, linux-nvdimm <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>, Aristeu Rozanski <aris-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Qiuxu Zhuo <qiuxu.zhuo-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Linux ACPI <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lv Zheng <lv.zheng-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mauro Carvalho Chehab <mchehab-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, Feb 28, 2018 at 5:04 AM, Borislav Petkov <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org> wrote:
> On Thu, Feb 22, 2018 at 11:58:06AM -0800, Tony Luck wrote:
>> This series was posted as RFC and got some review back in December:
>>
>>    https://marc.info/?l=linux-edac&m=151257213825419&w=2
>>
>> It couldn't go upstream back then because I was waiting for some updates
>> to the ACPICA headers for NFIT support.  Those patches are complete now,
>> so here is the series again.
>>
>> The "partial support" part is that the changes here only do the detection of
>> the non-volatile DIMMs. Coming later will be another patch/series to teach
>> skx_edac how to decode system addresses to NVDIMM addresses. But this part
>> stands on its own and is a useful first step.
>>
>> Tony Luck (5):
>>   EDAC: Drop duplicated array of strings for memory type names
>>   edac: Add new memory type for non-volatile DIMMs
>>   acpi, nfit: Add function to look up nvdimm device and provide SMBIOS
>>     handle
>>   firmware: dmi: Add function to look up a handle and return DIMM size
>>   EDAC, skx_edac: Detect non-volatile DIMMs
>>
>>  drivers/acpi/nfit/core.c     | 27 ++++++++++++++++++
>>  drivers/edac/Kconfig         |  5 +++-
>>  drivers/edac/edac_mc.c       | 41 +++++++++++++-------------
>>  drivers/edac/edac_mc_sysfs.c | 26 ++---------------
>>  drivers/edac/skx_edac.c      | 68 ++++++++++++++++++++++++++++++++++++++++----
>>  drivers/firmware/dmi_scan.c  | 31 ++++++++++++++++++++
>>  include/acpi/nfit.h          | 26 +++++++++++++++++
>>  include/linux/dmi.h          |  2 ++
>>  include/linux/edac.h         |  3 ++
>>  9 files changed, 178 insertions(+), 51 deletions(-)
>>  create mode 100644 include/acpi/nfit.h
>
> Series looks ok to me.
>
> Dan, I could route patch 3 through the EDAC tree if you'd prefer.

Yes, please, and you can add:

Acked-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
