From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: EC Confusion
Date: Fri, 5 Aug 2005 10:58:29 +0800
Message-ID: <200508051058.29931.luming.yu@intel.com>
References: <BAY12-F14E24F58ABC78F00F10288A8C70@phx.gbl>
Reply-To: luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <BAY12-F14E24F58ABC78F00F10288A8C70-MsuGFMq8XAE@public.gmane.org>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Paulo Vitor Magacho da Silva <pvmagacho78-PkbjNfxxIARBDgjK7y7TUQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


On Friday 05 August 2005 09:57, Paulo Vitor Magacho da Silva wrote:
> Hello,
>
> I've tryed with this patch, but still doesn't work. I am sending the dmesg
> so you can take a look.
Yes, the log file is  pretty  good.  Everything seems to work.

> The kernel command line: ro root=LABEL=/ rhgb quiet acpi=on
> acpi_dbg_layer=0x100002 acpi_dbg_level=0xFFFFFFFF
Could you try acpi_dbg_layer=0x100006 acpi_dbg_level_0xFFFFFFFF?
reproduce the wrong behaviour, then capture dmesg and send to me.

>
> Thanks,
> Paulo

Thanks,
Luming

> >
> >  Please try debug patch filed at
> >http://bugzilla.kernel.org/show_bug.cgi?id=3851#c71
> >which is against linux-2.6.13-rc5.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
