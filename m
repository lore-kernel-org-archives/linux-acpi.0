From: Pavel Machek <pavel@suse.cz>
Subject: Re: s4bios: does anyone use it?
Date: Sat, 5 Mar 2005 22:32:36 +0100
Message-ID: <20050305213236.GH1424@elf.ucw.cz>
References: <20050305191405.GA1463@elf.ucw.cz> <422A1FB6.3000504@ens-lyon.org> <20050305211747.GF1424@elf.ucw.cz> <422A23FB.2010707@ens-lyon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <422A23FB.2010707@ens-lyon.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Brice Goglin <Brice.Goglin@ens-lyon.org>
Cc: kernel list <linux-kernel@vger.kernel.org>, ACPI mailing list <acpi-devel@lists.sourceforge.net>, seife@suse.de, Len Brown <len.brown@intel.com>
List-Id: linux-acpi@vger.kernel.org

Hi!

> >Can you try cat /proc/acpi/sleep? If there's no difference between S4
> >and S4bios, than you are probably just using plain S4...
> 
> puligny:~% cat /proc/acpi/sleep
> S0 S1 S3 S4 S4bios S5
> 
> Where am I suppose to see a difference between S4 and S4Bios here ?

Hmm, your system says it supports s4bios. But if you can see 

Writing data to swap (XXX pages)... XXX %

then you are definitely using swsusp. Strange.

								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
