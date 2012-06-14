From: Mattia Dongili <malattia@linux.it>
Subject: no brightness with acpi video since 3.3 [was Re: Issues with the
 sony-platform module]
Date: Fri, 15 Jun 2012 05:39:15 +0900
Message-ID: <20120614203914.GA2645@kamineko.org>
References: <4FDA2051.3050108@babioch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4FDA2051.3050108@babioch.de>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Karol Babioch <karol@babioch.de>
Cc: platform-driver-x86@vger.kernel.org, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Thu, Jun 14, 2012 at 07:33:05PM +0200, Karol Babioch wrote:
> Hi,
> 
> I'm a user of the Sony VAIO VPCS12C5E and as such have always struggled
> with the Linux support of my laptop basically forever. Until now I've
> used the patch provided here [1], which worked quite well for some time.
> However since kernel version 3.3 I couldn't change the brightness of my
> screen anymore.

This is not an issue with the platform driver but with the acpi video
driver.

You can boot with acpi_backlight=vendor and get brightness control back
but the issue with acpi_video remains.

...
> So, I've uploaded a dmesg log when loading the module with the debug
> option enabled and trying to change the brightness with the fn keys here
> [2]. Maybe this is already enough to nail the issue down. Otherwise just
> let me know what you would like to have.

please provide your laptop's DSDT table as well.

> [1] https://code.google.com/p/vaio-f11-linux/wiki/KernelSupport
> [2] http://pastebin.com/GRrtp024

Thanks
-- 
mattia
:wq!
