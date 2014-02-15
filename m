From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi-video: Filter the BCL table for duplicate brightness values
Date: Sun, 16 Feb 2014 00:12:02 +0100
Message-ID: <1740306.zxvGuJyJQX@vostro.rjw.lan>
References: <1392305571-4895-1-git-send-email-hdegoede@redhat.com> <1711359.oXonO7zNKI@vostro.rjw.lan> <20140215114641.GA4856@aaronlu.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58146 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750808AbaBOW5R (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 15 Feb 2014 17:57:17 -0500
In-Reply-To: <20140215114641.GA4856@aaronlu.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Saturday, February 15, 2014 07:46:41 PM Aaron Lu wrote:
> On Sat, Feb 15, 2014 at 02:00:50AM +0100, Rafael J. Wysocki wrote:
> > On Friday, February 14, 2014 10:53:47 PM Aaron Lu wrote:
> > > On 02/14/2014 05:05 PM, Hans de Goede wrote:
> > > > Hi,
> > > > 
> > > > On 02/14/2014 02:16 AM, Aaron Lu wrote:
> > > >> On 02/13/2014 11:32 PM, Hans de Goede wrote:
> > > >>> Some devices have duplicate entries in there brightness levels table, ie
> > > >>> on my Dell Latitude E6430 the table looks like this:
> > > >>
> > > >> For reference's purpose, can you please file a bug in kernel bugzilla
> > > >> under the ACPI/Power-Video category and attach the acpidump there? Thanks.
> > > > 
> > > > Done:
> > > > 
> > > > https://bugzilla.kernel.org/show_bug.cgi?id=70571
> > > 
> > > Thanks, and the patch looks good to me.
> > > Reviewed-by: Aaron Lu <aaron.lu@intel.com>
> > 
> > OK, thanks!
> > 
> > Is this stable material?  If so, which stable kernels should it go into?
> 
> Yes, all stables I think.

OK, thanks!  Queued up for the next PM/ACPI pull request.

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
