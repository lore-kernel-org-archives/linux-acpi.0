From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: PROBLEM: [Toshiba Portege Z835] Brightness control lost after
 suspend
Date: Thu, 31 Jul 2014 16:09:48 +0800
Message-ID: <20140731080947.GD20462@aaronlu.sh.intel.com>
References: <CACiopZBtRcixrXhHLB-6fc_Fvg5rhv+rqJjeSxkxDYBf0uu+kw@mail.gmail.com>
 <53D7AF8F.7060401@intel.com>
 <CACiopZCQpGeBw6V7qFpcV6u22stOQC8X9Aiwya3wE_cBZzL+PQ@mail.gmail.com>
 <20140730083248.GA31763@aaronlu.sh.intel.com>
 <CACiopZA=5wHsjjzOKrC7aqCp13g8vLwnegcdFrySoS-_kD60Aw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:44613 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756077AbaGaIJv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 Jul 2014 04:09:51 -0400
Content-Disposition: inline
In-Reply-To: <CACiopZA=5wHsjjzOKrC7aqCp13g8vLwnegcdFrySoS-_kD60Aw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: John Marsden <john.d.marsden@gmail.com>
Cc: linux-acpi@vger.kernel.org

On Wed, Jul 30, 2014 at 06:11:02PM +0100, John Marsden wrote:
> On 30 July 2014 09:32, Aaron Lu <aaron.lu@intel.com> wrote:
> > Does the other interface work after resume? I mean the intel_backlight
> > and the toshiba one?
> 
> The intel-backlight interface works but the toshiba one does not work.

Please add acpi_backlight=vendor to kernel cmdline and see if that makes
the backlight work. What it does is to tell ACPI video module not to
create the acpi_videoX sysfs interface and let's see if X server will
pick up the intel_backlight one.

Best wishes,
Aaron
