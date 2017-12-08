From: Mika Westerberg <mika.westerberg@intel.com>
Subject: Re: Backporting patches that fix TBT at bootup
Date: Fri, 8 Dec 2017 09:11:43 +0200
Message-ID: <20171208071143.GZ22431@lahna.fi.intel.com>
References: <6677505e9b3347468bf639b7b14de11a@ausx13mpc120.AMER.DELL.COM>
 <CAJZ5v0h4kcLz2owSBkLUAu_RT-FLqBbySKKhj7y=8A5GLo0yAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:31013 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751109AbdLHHLr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 8 Dec 2017 02:11:47 -0500
Content-Disposition: inline
In-Reply-To: <CAJZ5v0h4kcLz2owSBkLUAu_RT-FLqBbySKKhj7y=8A5GLo0yAw@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mario Limonciello <Mario.Limonciello@dell.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Fri, Dec 08, 2017 at 12:32:19AM +0100, Rafael J. Wysocki wrote:
> Hi,
> 
> On Fri, Dec 8, 2017 at 12:23 AM,  <Mario.Limonciello@dell.com> wrote:
> > Hi,
> >
> > During kernel 4.14 some issues were fixed for Thunderbolt enumeration at bootup.
> > They were referenced in an issue
> > (https://github.com/01org/thunderbolt-software-user-space/issues/24#issuecomment-328011428)
> > There are 3 patches that Mika mentioned would be evaluated to be backported back to 4.13.
> >
> > As 4.14 has come and gone now, I wanted to see if there was any other thoughts about
> > bringing those back to stable now on 4.13 (or did they come back and I just didn't know?)
> >
> > ecc1165b8b74 ACPICA: Dispatch active GPEs at init time
> > 1312b7e0caca ACPICA: Make it possible to enable runtime GPEs earlier
> > eb7f43c4adb4 ACPI / scan: Enable GPEs before scanning the namespace
> 
> I'm not aware of anything else needed at that point.
> 
> Mika, should the three commits above be sufficient?

Yup, those should be all that is needed and they are included in
stable v4.13.13.
