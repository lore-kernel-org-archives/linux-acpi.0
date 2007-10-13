From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 9155] New: No fan control with ATI Radeon
 display support on HP nx6125.
Date: Sat, 13 Oct 2007 10:53:15 -0700
Message-ID: <20071013105315.accef6aa.akpm@linux-foundation.org>
References: <bug-9155-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:35048 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756843AbXJMRxd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 13 Oct 2007 13:53:33 -0400
In-Reply-To: <bug-9155-10286@http.bugzilla.kernel.org/>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: bugme-daemon@bugzilla.kernel.org, daniel.wuerfel@gmx.net

On Sat, 13 Oct 2007 02:37:35 -0700 (PDT) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=9155
> 
>            Summary: No fan control with ATI Radeon display support on HP
>                     nx6125.
>            Product: Drivers
>            Version: 2.5
>      KernelVersion: 2.6.22, 2.6.23
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: low
>           Priority: P1
>          Component: Video(Other)
>         AssignedTo: drivers_video-other@kernel-bugs.osdl.org
>         ReportedBy: daniel.wuerfel@gmx.net
> 
> 
> Most recent kernel where this bug did not occur:2.6.21
> Distribution:gentoo
> Hardware Environment:HP nx6125 BIOS version F.11
> Software Environment:Gnome 2.18, ati-driver 8.40.4
> Problem Description:If you enable "support for frame buffer devices", "Vesa vga
> graphics support" and "ati radeon display support" under "graphics support" so
> you lost fan cantrol on your hp nx6125, that means the fan doens't stop
> working.
> 
> Steps to reproduce:Enable "support for frame buffer devices", "Vesa vga
> graphics support" and "ati radeon display support" under "graphics support" on
> your hp nx6125 and after the next boot the fan will not switched off.
> 

Does anyone know whether this is likely to be a radeon driver bug or an
acpi bug or something else??
