From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 0/5] Laptop driver documentation changes for 2.6.25
Date: Fri, 8 Feb 2008 20:09:16 -0800
Message-ID: <20080208200916.52d73c7f.randy.dunlap@oracle.com>
References: <20080209013157.4895.70128.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from agminet01.oracle.com ([141.146.126.228]:34440 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752930AbYBIELS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 8 Feb 2008 23:11:18 -0500
In-Reply-To: <20080209013157.4895.70128.stgit@pacifica>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Mattia Dongili <malattia@linux.it>

On Sat, 09 Feb 2008 01:31:57 +0000 Carlos Corbacho wrote:

> The following series implements the proposed creation of Documentation/laptops,
> and the movement of all the laptop driver documentation to this directory. I've
> also taken the opportunity to tack on the acer-wmi documentation in the final
> patch of this series.
> 
> Because all the drivers in question go through the ACPI tree anyway, it's
> probably easiest if this change goes through the ACPI tree as well.
> 
> This should all be 2.6.25 material, since there is no code change here, just
> rearranging the Documentation files, and updating Kconfig entries where
> required. I've also tested this series against Linus' latest git tree, with no
> problems applying it there.
> 
> -Carlos
> ---
> 
> Carlos Corbacho (5):
>       acer-wmi - Add documentation
>       sonypi - Move sonypi.txt to Documentation/laptops
>       sony-laptop - Move sony-laptop.txt to Documentation/laptops
>       thinkpad-acpi - Move thinkpad-acpi.txt to Documentation/laptops
>       Documentation - Create laptops sub-directory

for_each:
Acked-by: Randy Dunlap <randy.dunlap@oracle.com.

Oh.  If any of these are purely moved files (from one location to
another), then that should show up in the git-diff diffstat.
(I'm sure that Len knows about this.)
Ah, I finally found Linus's email on this.  He says:

Please use "git diff -M --stat --summary" to generate the diffstat: the -M 
enables rename detection, and the summary enables a summary of new/deleted 
or renamed files.

Thanks.

>  Documentation/00-INDEX                  |    8 
>  Documentation/laptops/00-INDEX          |   10 
>  Documentation/laptops/acer-wmi.txt      |  202 +++++
>  Documentation/laptops/sony-laptop.txt   |  117 +++
>  Documentation/laptops/sonypi.txt        |  152 +++
>  Documentation/laptops/thinkpad-acpi.txt | 1365 +++++++++++++++++++++++++++++++
>  Documentation/sony-laptop.txt           |  117 ---
>  Documentation/sonypi.txt                |  152 ---
>  Documentation/thinkpad-acpi.txt         | 1365 -------------------------------
>  drivers/char/Kconfig                    |    2 
>  drivers/misc/Kconfig                    |   10 
>  11 files changed, 1856 insertions(+), 1644 deletions(-)
>  create mode 100644 Documentation/laptops/00-INDEX
>  create mode 100644 Documentation/laptops/acer-wmi.txt
>  create mode 100644 Documentation/laptops/sony-laptop.txt
>  create mode 100644 Documentation/laptops/sonypi.txt
>  create mode 100644 Documentation/laptops/thinkpad-acpi.txt
>  delete mode 100644 Documentation/sony-laptop.txt
>  delete mode 100644 Documentation/sonypi.txt
>  delete mode 100644 Documentation/thinkpad-acpi.txt

---
~Randy
