From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: smp/swsusp done right
Date: Wed, 30 Mar 2005 14:13:46 -0700 (MST)
Message-ID: <Pine.LNX.4.61.0503301413050.12965@montezuma.fsmlabs.com>
References: <20050323204019.GA11616@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261862AbVC3VQO@vger.kernel.org>
In-Reply-To: <20050323204019.GA11616@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, seife@suse.de, ACPI mailing list <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

On Wed, 23 Mar 2005, Pavel Machek wrote:

> This is against -mm kernel; it is smp swsusp done right, and it
> actually works for me. Unlike previous hacks, it uses cpu hotplug
> infrastructure. Disable CONFIG_MTRR before you try this...
> 
> Test this if you can, and report any problems. If not enough people
> scream, this is going to -mm.

Yay! Thanks for getting that done Pavel =)

	Zwane
