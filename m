From: Pavel Machek <pavel@suse.cz>
Subject: Re: [2.6 patch] i386/x86_64: acpi/sleep.c: kill unused acpi_save_state_disk
Date: Sun, 16 Jan 2005 19:53:51 +0100
Message-ID: <20050116185351.GA2757@elf.ucw.cz>
References: <20050116073927.GU4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262567AbVAPSyq@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20050116073927.GU4274@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Bunk <bunk@stusta.de>
Cc: len.brown@intel.com, acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, ak@suse.de, discuss@x86-64.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> acpi_save_state_disk does nothing and is completely unused.
> 
> Unless some usage is planned in the near future, I'm therefore proposing 
> the patch below to kill it.

Good idea.
									Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
