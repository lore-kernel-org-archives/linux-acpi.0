From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] ACPI / tables: table upgrade from built-in initrd
Date: Mon, 17 Dec 2018 10:31:44 +0100
Message-ID: <CAJZ5v0jWROTTSRT1FFQWXpWn2M=uMRw5SKbwu0doKaeMjSOEnA@mail.gmail.com>
References: <1545013184-2487-1-git-send-email-shunyong.yang@hxt-semitech.com>
 <CAJZ5v0gnmnP1UUisS-4L=gzu3KHbbK8y4Wh_4dqfgmm775=ZkQ@mail.gmail.com> <36fdf717ba5345e2956e48645f6667e6@HXTBJIDCEMVIW01.hxtcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <36fdf717ba5345e2956e48645f6667e6@HXTBJIDCEMVIW01.hxtcorp.net>
Sender: linux-kernel-owner@vger.kernel.org
To: shunyong.yang@hxt-semitech.com
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, yu.zheng@hxt-semitech.com
List-Id: linux-acpi@vger.kernel.org

On Mon, Dec 17, 2018 at 10:18 AM Yang, Shunyong
<shunyong.yang@hxt-semitech.com> wrote:
>
> Hi, Rafael,
>   I think "override" is more accurate. I just follow the existing
> description of "ACPI_TABLE_UPGRADE" in drivers/acpi/Kconfig.
>   Should I change all upgrade/UPGRADE to "override/OVERRIDE" in this patch?

I think that this would be better.

Also, there is some documentation regarding this feature in the kernel
tree.  Should it be updated by your patch?
