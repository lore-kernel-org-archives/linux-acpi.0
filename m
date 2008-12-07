From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Unexcepted shutdown in 2.6.28-rc5
Date: Sun, 7 Dec 2008 22:17:03 +0100
Message-ID: <200812072217.04150.rjw@sisk.pl>
References: <4925EF01.2070405@gmail.com> <1227229754.15014.280.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:34693 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751202AbYLGVR6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 7 Dec 2008 16:17:58 -0500
In-Reply-To: <1227229754.15014.280.camel@rzhang-dt>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>
Cc: Maxime Poncet <maxime.poncet@gmail.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Zhao Yakui <yakui.zhao@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>, Len Brown <lenb@kernel.org>

On Friday, 21 of November 2008, Zhang Rui wrote:
> On Fri, 2008-11-21 at 07:13 +0800, Maxime Poncet wrote:
> > Hi,
> > 
> > I have the same problem in 2.6.28-rc5 and 2.6.27.x :
> > my laptop shutdown automatically while working on it.
> > 
> > That problem doesn't appear in 2.6.28-rc3.
> > 
> there are not many ACPI changes between 2.6.28-rc3 and -rc5.
> it would be great if you can use git-bisect to find out
> which commit introduces this regression.
> 
> thanks,
> rui
> 
> > This terminal output show well the problem
> > $uname -a
> > 2.6.28-rc5
> > $while true;
> > do cat /proc/acpi/thermal_zone/THRM/temperature;
> > sleep 1;
> > done
> > 
> > ...
> > temperature:             51 C
> > temperature:             51 C
> > temperature:             144 C
> > 
> > And then it shutdowns because critical temperature was reached
> > 
> > Another thing that might be important : the output of dmesg
> > Every 5 seconds this message appears (not in 2.6.28-rc3):
> > 
> > ACPI: Transitioning device [FAN] to D3
> > ACPI: Unable to turn cooling device [ffff81007fb656d0] 'off'
> > 
> > Hope it will help you.

I wonder why _may_ be the reason of this.  Alex?

Rafael
