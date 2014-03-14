From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: next-20140312 - build error in drivers/acpi/sleep.c
Date: Fri, 14 Mar 2014 08:08:13 +0800
Message-ID: <20140314000813.GA8649@localhost>
References: <22429.1394736511@turing-police.cc.vt.edu>
 <1431943.FB4azhDoEG@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:5776 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754623AbaCNAIb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Mar 2014 20:08:31 -0400
Content-Disposition: inline
In-Reply-To: <1431943.FB4azhDoEG@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, Mar 13, 2014 at 10:23:51PM +0100, Rafael J. Wysocki wrote:
> On Thursday, March 13, 2014 02:48:31 PM Valdis Kletnieks wrote:
> > Seen in the most recent linux-next with a CONFIG_SUSPEND=n .config:
> > 
> >   CC      drivers/acpi/sleep.o
> > drivers/acpi/sleep.c: In function 'acpi_sleep_init':
> > drivers/acpi/sleep.c:808:2: error: implicit declaration of function 'acpi_sleep_state_supported' [-Werror=implicit-function-declaration]
> >   if (acpi_sleep_state_supported(ACPI_STATE_S5)) {
> >   ^
> > cc1: some warnings being treated as errors
> > make[2]: *** [drivers/acpi/sleep.o] Error 1
> > make[1]: *** [drivers/acpi] Error 2
> > make: *** [drivers] Error 2
> > 
> > Function is defined inside a #ifdef CONFIG_SUSPEND, but used outside of
> > one in acpi_sleep_init().
> 
> This isn't caught by the build test robot.  Care to submit that .config to
> Fengguang so that you don't have to report such failures again?

Sorry about that! It's because the build test robot skips compilation
for many trees due to a newly introduced bug. Have been fixed now.

Cheers,
Fengguang
