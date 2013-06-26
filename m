From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH v2 5/9] ACPI: introduce three helper functions
Date: Thu, 27 Jun 2013 01:46:33 +0200
Message-ID: <57192011.2AdLNpNKNS@vostro.rjw.lan>
References: <1372264261-17442-1-git-send-email-liuj97@gmail.com> <1372264261-17442-6-git-send-email-liuj97@gmail.com> <1769605.QbZVOi8JUg@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1769605.QbZVOi8JUg@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiang Liu <liuj97@gmail.com>
Cc: Jiang Liu <jiang.liu@huawei.com>, Yijing Wang <wangyijing@huawei.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, June 26, 2013 08:49:21 PM Rafael J. Wysocki wrote:
> On Thursday, June 27, 2013 12:30:57 AM Jiang Liu wrote:
> > From: Jiang Liu <jiang.liu@huawei.com>
> > 
> > Introduce three helper functions, which will be used to simplify code.
> 
> First, please introduce acpi_has_method() and use it everywhere where
> applicable (at least under drivers/acpi/)

Well, except for drivers/acpi/acpica/.  And even that might be too much ...

Please just move the definition of acpi_has_method() and all of the
simplifications you've done using it into one separate patch.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
