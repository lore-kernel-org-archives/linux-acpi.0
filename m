From: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: Re: acpi dock test-drive
Date: Fri, 09 Jun 2006 09:45:38 -0700
Message-ID: <1149871538.4542.7.camel@whizzy>
References: <20060609144326.GA6093@hermes.uziel.local>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:8312 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030291AbWFIQdW (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Jun 2006 12:33:22 -0400
In-Reply-To: <20060609144326.GA6093@hermes.uziel.local>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Christian Trefzer <ctrefzer@gmx.de>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 2006-06-09 at 16:43 +0200, Christian Trefzer wrote:
> Hi Kristen,
> 
> finally I had the chance to try out the fruit of your work on my Dell
> Latitude CPiA. First of all, congratulations for the ACPI part, which
> seems to work pretty well so far: the second PCI bridge is detected
> after a hot-dock. However, the PCI devices behind that bridge are not
> yet discovered. Pushing the undock request button on the docking station
> itself results in the PCI bridge being removed again - so far, so good : )
> 
> On the other hand, the undock request caused a reproducible Oops at the
> first time, and kacpid exit the second time. After that, pushing the
> button has no further effect ; )
> 

Hi Christian,
What you are describing sounds like the bug I just fixed :).  Can you
please try 2.6.17-rc6-mm1 to see if this works any better?  I believe it
should resolve both the oops and the fact that your devices behind the
pci bridge are not found.  Thanks very much for continuing to test the
patches.

Kristen
