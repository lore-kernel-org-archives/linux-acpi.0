From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/3] Fix backlight issues on some Windows 8 systems
Date: Mon, 10 Jun 2013 13:59:30 +0200
Message-ID: <1714928.Kf7sBtKE1o@vostro.rjw.lan>
References: <1370818899-8595-1-git-send-email-matthew.garrett@nebula.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1370818899-8595-1-git-send-email-matthew.garrett@nebula.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matthew Garrett <matthew.garrett@nebula.com>
Cc: linux-acpi@vger.kernel.org, seth.forshee@canonical.com, joeyli.kernel@gmail.com, daniel.vetter@ffwll.ch, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, lenb@kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Matthew,

On Sunday, June 09, 2013 07:01:36 PM Matthew Garrett wrote:
> Windows 8 introduced new policy for backlight control by pushing it out to
> graphics drivers. This appears to have coincided with a range of vendors
> adding Windows 8 checks to their backlight control code which trigger either
> awkward behaviour (Lenovo) or complete brokenness (some Dells). The simplest
> thing to do would be to just disable ACPI backlight control entirely if the
> firmware indicates Windows 8 support, but it's entirely possible that
> individual graphics drivers might still make use of the ACPI functionality in
> preference to native control.
> 
> The first two patches in this series are picked from other patchesets aimed at
> solving similar problems. The last simply unregisters ACPI backlight control
> on Windows 8 systems when using an Intel GPU. Similar code could be added to
> other drivers, but I'm reluctant to do so without further investigation as
> to the behaviour of the vendor drivers under Windows.

I happen to know that alternative solution to this problem is being worked on,
so I'm going to wait until it is submitted and then we'll decide what to merge.

I'm slightly concerned about unregistering ACPI backlight control for all
systems declaring win8 support, even though it may actually work for them.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
