From: =?ISO-8859-15?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
Subject: Re: [PATCH 4/5]ACPI PNP driver
Date: Thu, 21 Oct 2004 09:01:26 +0300
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <417750B6.7000409@kolumbus.fi>
References: <1098327568.6132.226.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S268652AbUJUGCI@vger.kernel.org>
In-Reply-To: <1098327568.6132.226.camel@sli10-desk.sh.intel.com>
To: Li Shaohua <shaohua.li@intel.com>
Cc: ACPI-DEV <acpi-devel@lists.sourceforge.net>, lkml <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Adam Belay <ambx1@neo.rr.com>, Matthieu <castet.matthieu@free.fr>, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: linux-acpi@vger.kernel.org



Li Shaohua wrote:

>Hi,
>This patch provides an ACPI based PNP driver. It is based on Matthieu
>Castet's original work. With this patch, legacy device drivers (floppy
>ACPI driver, COM ACPI driver, and ACPI motherboard driver) which
>directly use ACPI can be removed, since now we have unified PNP
>interface for legacy devices.
>
>Thanks,
>Shaohua
>
>Signed-off-by: Li Shaohua <shaohua.li@intel.com>
>
>The patch depends on previous 3 patches.
>
>--- 2.6/drivers/pnp/isapnp/Kconfig.stg3	2004-10-18 17:34:17.591712040
>+0800
>+++ 2.6/drivers/pnp/isapnp/Kconfig	2004-10-18 17:36:19.173228840 +0800
>  
>
Are you supposed to list here _every_ device to which not to bind? Is 
this feasible? Maybe take another approach and bind to the "default" 
acpi pnp driver if no specific driver found ?

+static char excluded_id_list[] =
+	"PNP0C0A," /* Battery */
+	"PNP0C0C,PNP0C0E,PNP0C0D," /* Button */
+	"PNP0C09," /* EC */
+	"PNP0C0B," /* Fan */
+	"PNP0A03," /* PCI root */
+	"PNP0C0F," /* Link device */
+	"PNP0000," /* PIC */
+	"PNP0100," /* Timer */
+	;



---Mika
