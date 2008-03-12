From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] doc/power: move power-related files to Documentation/power/
Date: Wed, 12 Mar 2008 02:47:27 -0400
Message-ID: <200803120247.27649.lenb@kernel.org>
References: <20080304134837.dcfed6dd.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36931 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751059AbYCLGs1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 12 Mar 2008 02:48:27 -0400
In-Reply-To: <20080304134837.dcfed6dd.randy.dunlap@oracle.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org, len.brown@intel.com, cbou@mail.ru, dwmw2@infradead.org

On Tuesday 04 March 2008, Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> Move power-related files to Documentation/power/.
> 
> Move 00-INDEX entries to power/00-INDEX (and add entry for
> pm_qos_interface.txt).
> 
> Update references to moved filenames.
> 
> Fix some trailing whitespace.
> 
> Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
> ---
>  Documentation/00-INDEX                     |    4 
>  Documentation/kernel-parameters.txt        |    2 
>  Documentation/pm.txt                       |  257 -------------------
>  Documentation/pm_qos_interface.txt         |   59 ----
>  Documentation/power/00-INDEX               |    6 
>  Documentation/power/pm.txt                 |  257 +++++++++++++++++++
>  Documentation/power/pm_qos_interface.txt   |   59 ++++
>  Documentation/power/power_supply_class.txt |  169 ++++++++++++
>  Documentation/power_supply_class.txt       |  169 ------------
>  arch/x86/Kconfig                           |    2 
>  kernel/power/Kconfig                       |    2 
>  11 files changed, 494 insertions(+), 492 deletions(-)

Randy,
This one doesn't apply any more.
somebody already remove the power_supply_class.txt file?

-Len
