From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bug 13865] New: Can only resume with HP_WMI selected on compaq nc6000 when 4c395bdd3f2ca8f7e8efad881e16071182c3b8ca is reverted
Date: Wed, 29 Jul 2009 22:57:40 +0200
Message-ID: <200907292257.41573.rjw@sisk.pl>
References: <bug-13865-10028@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752540AbZG2U7C@vger.kernel.org>
In-Reply-To: <bug-13865-10028@http.bugzilla.kernel.org/>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Frans Pop <elendil@planet.nl>
Cc: bugzilla-daemon@bugzilla.kernel.org, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday 29 July 2009, you wrote:
> http://bugzilla.kernel.org/show_bug.cgi?id=13865
> 
>            Summary: Can only resume with HP_WMI selected on compaq nc6000
>                     when 4c395bdd3f2ca8f7e8efad881e16071182c3b8ca is
>                     reverted
>            Product: Power Management
>            Version: 2.5
>     Kernel Version: 2.6.30
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Hibernation/Suspend
>         AssignedTo: power-management_other@kernel-bugs.osdl.org
>         ReportedBy: cedric@belbone.be
>         Regression: No
> 
> 
> Just for testing I enabled HP_WMI. But from then, I could not resume anymore.
> I just reverted the last git commit on the 'drivers/platform/x86/hp-wmi.c' code
> (4c395bdd3f2ca8f7e8efad881e16071182c3b8ca) and now I can resume.
> The problem still persists on .31-rc serie

Frans, that's something for you to take care of.

Best,
Rafael
