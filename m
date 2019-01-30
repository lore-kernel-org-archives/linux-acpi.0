From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] nfit: acpi_nfit_ctl(): check out_obj->type in the right
 place
Date: Tue, 29 Jan 2019 22:21:36 -0800
Message-ID: <CAPcyv4hhzLsJK9La5C28A1tFc0p28SSLqp8W9XApgANoOcuWSQ@mail.gmail.com>
References: <PU1P153MB01694923DF3280E5828E2BE2BF900@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <PU1P153MB01694923DF3280E5828E2BE2BF900-7hHSCQUTt08p9lVGRpUb+2HfQuWdHs3hiGd9ebBGJoev3QGu/rdwKA@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: Dexuan Cui <decui-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>
Cc: Josh Poulson <jopoulso-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, "linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org" <linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>, Haiyang Zhang <haiyangz-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, "driverdev-devel-tBiZLqfeLfOHmIFyCCdPziST3g8Odh+X@public.gmane.org" <driverdev-devel-tBiZLqfeLfOHmIFyCCdPziST3g8Odh+X@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Michael Kelley <mikelley-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, Sasha Levin <Alexander.Levin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Ross Zwisler <zwisler-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Stephen Hemminger <sthemmin-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, KY Srinivasan <kys-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>, Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Jan 29, 2019 at 5:23 PM Dexuan Cui <decui-0li6OtcxBFHby3iVrkZq2A@public.gmane.org> wrote:
>
>
> In the case of ND_CMD_CALL, we should also check out_obj->type.
>
> The patch uses out_obj->type, which is a short alias to
> out_obj->package.type.
>
> Fixes: 31eca76ba2fc ("nfit, libnvdimm: limited/whitelisted dimm command marshaling mechanism")
> Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
> Signed-off-by: Dexuan Cui <decui-0li6OtcxBFHby3iVrkZq2A@public.gmane.org>

Looks good to me, applied.
