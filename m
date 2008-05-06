From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: [PATCH] bay: Exit if notify handler cannot be installed
Date: Tue, 6 May 2008 12:18:46 -0300
Message-ID: <20080506151846.GA22828@khazad-dum.debian.net>
References: <20080505202508.GA3690@homac> <20080506091522.GA4378@homac> <1210065811.12668.1.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763937AbYEFPTA@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1210065811.12668.1.camel@sli10-desk.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: Holger Macht <hmacht@suse.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, "Accardi, Kristen C" <kristen.c.accardi@intel.com>
List-Id: linux-acpi@vger.kernel.org

On Tue, 06 May 2008, Shaohua Li wrote:
> The bay driver is duplicated with libata, I thought we should delete it.
> See bug http://bugzilla.kernel.org/show_bug.cgi?id=9526

The bay driver is currently useless, BUT it should handle a lot of stuff
libata won't, such as bay batteries, bay floppies, and anything else in
a bay that is not a hard disk.

The fact that the driver currently looks only after disks is just a bug.
It should, in fact, bind to any ejectable device not already handled by
a different driver.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
