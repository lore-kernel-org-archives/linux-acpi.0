From: Mario Limonciello <mario_limonciello@dell.com>
Subject: Re: [PATCH] ACPI: Adjust the return value of _REV on x86
Date: Tue, 24 Mar 2015 14:53:24 -0500
Message-ID: <5511C0B4.1000304@dell.com>
References: <1426150247-18309-1-git-send-email-matthew.garrett@nebula.com> <1426363131-14530-1-git-send-email-jason.ekstrand@intel.com> <CAOFGe95CiLcHtzD3Vv-KJoCXfeHCyGa55OBkzHSZMWwdOyLnfg@mail.gmail.com> <20150323120331.GA3007@codeblueprint.co.uk> <5510FB37.6030808@dell.com> <20150324152412.GA4706@codeblueprint.co.uk> <55119D4A.5050809@dell.com> <20150324180156.GA14658@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150324180156.GA14658@srcf.ucam.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Matt Fleming <matt@codeblueprint.co.uk>, Jason Ekstrand <jason@jlekstrand.net>, LKML <linux-kernel@vger.kernel.org>, Bard Liao <bardliao@realtek.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "lenb@kernel.org" <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-acpi@vger.kernel.org


On 03/24/2015 01:01 PM, Matthew Garrett wrote:
> On Tue, Mar 24, 2015 at 12:22:18PM -0500, Mario Limonciello wrote:
>
> Since we don't expose any way for the platform to detect that it's
> running Linux, yes.
>
> Will it? You haven't shipped the firmware that changes this behaviour
> yet.
>
This was posted a few days ago.  BIOS A02, it resolves the broken behavior introduced in A01 and Linux.

It can be flashed in the BIOS F12 boot menu, no Windows or DOS necessary.

http://www.dell.com/support/home/us/en/04/Drivers/DriversDetails?driverId=F2PRR&fileId=3442501672&osCode=WB64A&productCode=xps-13-9343-laptop&languageCode=EN&categoryId=BI

Anything bought from now forward will have that BIOS version (or something newer).
