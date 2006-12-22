From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [patch 1/2] acpi: Remove procfs from bay
Date: Fri, 22 Dec 2006 11:43:55 +0000
Message-ID: <20061222114355.GB4268@ucw.cz>
References: <20061216223309.365745735@localhost.localdomain> <20061216144027.9765bdd1.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752461AbWLVLoM@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20061216144027.9765bdd1.kristen.c.accardi@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> Remove the procfs related code from the bay driver.
> 
> Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

This changes userland interface... how many apps will it break?

							Pavel

-- 
Thanks for all the (sleeping) penguins.
