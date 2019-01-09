From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] ACPI/nfit: delete the function to_acpi_nfit_desc
Date: Tue, 8 Jan 2019 22:23:34 -0800
Message-ID: <CAPcyv4hsAi-1+kxVMA7hwG0Siy+Scat_vJC8WBY177M_hKpOxw@mail.gmail.com>
References: <1546675718-31174-1-git-send-email-lixiaochun.2888@163.com>
 <1546675718-31174-2-git-send-email-lixiaochun.2888@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <1546675718-31174-2-git-send-email-lixiaochun.2888-9Onoh4P/yGk@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Xiaochun Lee <lixiaochun.2888-9Onoh4P/yGk@public.gmane.org>
Cc: linux-nvdimm <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Xiaochun Lee <lixc17-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>, Linux ACPI <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ross Zwisler <zwisler-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Jan 5, 2019 at 12:09 AM Xiaochun Lee <lixiaochun.2888-9Onoh4P/yGk@public.gmane.org> wrote:
>
> From: Xiaochun Lee <lixc17-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>
>
> The function to_acpi_nfit_desc and function to_acpi_desc
> do the same things,delete the function to_acpi_nfit_desc,
> and keep the inline function to_acpi_desc.
>
> Signed-off-by: Xiaochun Lee <lixc17-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>

Good catch, thanks, applied.
