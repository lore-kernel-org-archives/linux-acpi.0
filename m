From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] acpi_system_write_wakeup_device(): fix error check for unsigned variable.
Date: Thu, 22 Nov 2012 01:23:24 +0100
Message-ID: <1645783.2WuR77RKxS@vostro.rjw.lan>
References: <1353117263-6957-1-git-send-email-tipecaml@gmail.com> <1732852.VDXGV3Ao2T@vostro.rjw.lan> <50AD6C4A.4030809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <50AD6C4A.4030809@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Cyril Roelandt <tipecaml@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, lenb@kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thursday, November 22, 2012 01:05:30 AM Cyril Roelandt wrote:
> On 11/21/2012 01:44 AM, Rafael J. Wysocki wrote:
> > On Saturday, November 17, 2012 02:54:23 AM Cyril Roelandt wrote:
> >> The LEN variable is unsigned, therefore checking whether it is less than 0 is
> >> useless.
> >>
> >> Signed-off-by: Cyril Roelandt<tipecaml@gmail.com>
> >> ---
> >>   drivers/acpi/proc.c |    2 --
> >>   1 file changed, 2 deletions(-)
> >>
> >> diff --git a/drivers/acpi/proc.c b/drivers/acpi/proc.c
> >> index 27adb09..37871a7 100644
> >> --- a/drivers/acpi/proc.c
> >> +++ b/drivers/acpi/proc.c
> >> @@ -366,8 +366,6 @@ acpi_system_write_wakeup_device(struct file *file,
> >>
> >>   	if (len>  4)
> >>   		len = 4;
> >> -	if (len<  0)
> >> -		return -EFAULT;
> >
> > I would prefer to check if count<  0 instead.
> >
> 
> 
> count has type size_t, so it is also an unsigned variable. I think that 
> acpi_system_write_wakeup_device really cannot be called with a "count" 
> parameter that is less than 0.

OK

So I suppose we can just drop len entirely and replace it with count, right?
[And drop the < 0 check too.]

Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
