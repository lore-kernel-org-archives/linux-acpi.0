From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 20/27] ACPICA: Tables: Fix invalid pointer accesses in acpi_tb_parse_root_table().
Date: Tue, 06 May 2014 02:43:44 +0200
Message-ID: <6913597.VSrPZ98ePF@vostro.rjw.lan>
References: <cover.1398817612.git.lv.zheng@intel.com> <1AE640813FDE7649BE1B193DEA596E8802559B1C@SHSMSX101.ccr.corp.intel.com> <CA+5PVA58527N76yJ8yNZPAbOz6YepR3RHXtjaV6t0i1nCYwcXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+5PVA58527N76yJ8yNZPAbOz6YepR3RHXtjaV6t0i1nCYwcXg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Josh Boyer <jwboyer@fedoraproject.org>
Cc: "Zheng, Lv" <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>, "Brown, Len" <len.brown@intel.com>, "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Monday, May 05, 2014 08:42:46 AM Josh Boyer wrote:
> On Mon, May 5, 2014 at 12:23 AM, Zheng, Lv <lv.zheng@intel.com> wrote:
> > Hi, Rafael
> >
> >> From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-owner@vger.kernel.org] On Behalf Of Rafael J. Wysocki
> >> Sent: Monday, May 05, 2014 8:43 AM
> >>
> >> On Saturday, May 03, 2014 08:59:14 AM Josh Boyer wrote:
> >> > On Tue, Apr 29, 2014 at 10:05 PM, Lv Zheng <lv.zheng@intel.com> wrote:
> >> > > The commit of back porting Linux XSDT validation mechanism has introduced
> >> > > a regreession:
> >> > >   Commit: 671cc68dc61f029d44b43a681356078e02d8dab8
> >> > >   Subject: ACPICA: Back port and refine validation of the XSDT root table.
> >> > > There is a pointer still accessed after unmapping.
> >> > >
> >> > > This patch fixes this issue.  Lv Zheng.
> >> > >
> >> > > Buglink: https://bugzilla.kernel.org/show_bug.cgi?id=73911
> >> > > Buglink: https://bugs.archlinux.org/task/39811
> >> > > Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> >> > > Reported-and-tested-by: Bruce Chiarelli <mano155@gmail.com>
> >> > > Reported-and-tested-by: Spyros Stathopoulos <spystath@gmail.com>
> >> > > Signed-off-by: Bob Moore <robert.moore@intel.com>
> >> > > Cc: <stable@vger.kernel.org> # 3.14.x: 671cc68: ACPICA: Back port and refine validation of the XSDT root table.
> >> >
> >> > This patch should get into 3.15-rcX soon.  It fixes a known regression
> >> > that prevents booting on machines with AMI firmware, and that is
> >> > present in 3.14 so we need it for stable as well.  Rafael?
> >>
> >> Lv, is it safe to take this patch alone into 3.15-rc?
> >
> > Yes, it's safe to only take this patch to be a regression fix.
> 
> FWIW, Fedora is carrying this on top of 3.14.2 already, and people
> with the impacted machines say it's working for them.  So I agree it
> should be safe.
> 
> Thanks to the both of you.

OK, queued up for 3.15, thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
