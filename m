From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 8190] New: ehci_hcd can't
 reinitialize scanner after suspend>resume
Date: Tue, 13 Mar 2007 01:00:57 -0800
Message-ID: <20070313010057.e998fb6e.akpm@linux-foundation.org>
References: <200703130751.l2D7pWks011303@fire-2.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-bounces@lists.sourceforge.net>
In-Reply-To: <200703130751.l2D7pWks011303@fire-2.osdl.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-usb-devel-bounces@lists.sourceforge.net
Errors-To: linux-usb-devel-bounces@lists.sourceforge.net
To: "bugme-daemon@kernel-bugs.osdl.org" <bugme-daemon@bugzilla.kernel.org>
Cc: linux-acpi@vger.kernel.org, bug-track@fisher-privat.net, linux-usb-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

> On Tue, 13 Mar 2007 00:51:32 -0700 bugme-daemon@bugzilla.kernel.org wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=8190
> 
>            Summary: ehci_hcd can't reinitialize scanner after suspend>resume
>     Kernel Version: 2.6.20, 2.6.21-rc3-gbe521466
>             Status: NEW
>           Severity: normal
>              Owner: acpi_power-sleep-wake@kernel-bugs.osdl.org
>          Submitter: bug-track@fisher-privat.net
> 
> 
> Most recent kernel where this bug did *NOT* occur:
> Distribution:gentoo 2006.1 i686-pc-linux-gnu
> Hardware Environment:scanner epson perfection 1670, 82801G (ICH7 Family) USB2
> EHCI Controller
> 
> Problem Description: with suspend to ram kernel will set scanner to the standby
> mode, but after resume kernel can't resume scanner _if_ ehci (module) is used.
> With this issue sane can't use the scanner you need replug it to make it use.
> 
> This issue not upper if kernel compiled without ehci support.
> 
> Steps to reproduce:
> 1. compile kernel with ehci (module or build-in) and restart
> 2. plugin scanner (sane is working)
> 3. echo mem > /sys/power/state && scanner will be set to standby mode too.
> 4. resume && scanner will stay in standby mode
> 5. replug the scanner to make it use.
> 

Is this an ACPI bug, or a USB bug?

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel
