From: Xiaochun Lee <lixiaochun.2888-9Onoh4P/yGk@public.gmane.org>
Subject: [PATCH] ACPI/nfit: delete the function to_acpi_nfit_desc
Date: Sat,  5 Jan 2019 16:08:37 +0800
Message-ID: <1546675718-31174-1-git-send-email-lixiaochun.2888@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Cc: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Xiaochun Lee <lixc17-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>, zwisler-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

From: Xiaochun Lee <lixc17-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>

The function to_acpi_nfit_desc and function to_acpi_desc
do the same things,So delete the function to_acpi_nfit_desc,
and keep the inline function to_acpi_desc.

The calling function to_acpi_nfit_desc,have been changed 
to the calling function to_acpi_desc.

Xiaochun Lee (1):
  ACPI/nfit: delete the function to_acpi_nfit_desc

 drivers/acpi/nfit/core.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

-- 
1.8.3.1
