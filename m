From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH v5 1/3] gpio: designware: convert device node to fwnode
Date: Tue, 22 Mar 2016 17:55:15 +0200
Message-ID: <20160322155515.GD2099@lahna.fi.intel.com>
References: <1457077474-124064-1-git-send-email-qiujiang@huawei.com>
 <1457077474-124064-2-git-send-email-qiujiang@huawei.com>
 <CACRpkdYb8HYXta3yHB4-n-KtSAhyrREUGJJMOUbt3ZXvSUbn6Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACRpkdYb8HYXta3yHB4-n-KtSAhyrREUGJJMOUbt3ZXvSUbn6Q@mail.gmail.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: qiujiang <qiujiang@huawei.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Lee Jones <lee.jones@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linuxarm <linuxarm@huawei.com>, haifeng.wei@huawei.com, charles.chenxin@huawei.com
List-Id: linux-acpi@vger.kernel.org

On Tue, Mar 22, 2016 at 11:38:26AM +0100, Linus Walleij wrote:
> On Fri, Mar 4, 2016 at 8:44 AM, qiujiang <qiujiang@huawei.com> wrote:
> 
> > This patch converts device node to fwnode in
> > dwapb_port_property for designware gpio driver,
> > so as to provide a unified data structure for DT
> > and ACPI bindings.
> >
> > Acked-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Signed-off-by: qiujiang <qiujiang@huawei.com>
> 
> I need Mika's and maybe also Rafael's ACKs on this before
> I merge any of the series.

Hmm, I thought I already acked the ACPI GPIO signaled event patch? It
still looks fine to me.
