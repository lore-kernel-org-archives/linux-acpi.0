From: Borislav Petkov <bp@alien8.de>
Subject: Re: Look Ma, da kernel is b0rken
Date: Wed, 5 Dec 2012 22:46:12 +0100
Message-ID: <20121205214612.GA6222@liondog.tnic>
References: <20121205070901.GA12123@rhlx01.hs-esslingen.de>
 <20121205142935.GA12119@liondog.tnic>
 <20121205152756.5afec12c@pyramind.ukuu.org.uk>
 <20121205153121.GA28556@liondog.tnic>
 <20121205154749.2af4ef36@pyramind.ukuu.org.uk>
 <20121206075721.18c0c05aa767b330f47d77eb@canb.auug.org.au>
 <20121205211244.GA6239@liondog.tnic>
 <20121205214114.0bb545f1@pyramind.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20121205214114.0bb545f1@pyramind.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, Andreas Mohr <andi@lisas.de>, linux-kernel@vger.kernel.org, Li Shaohua <shaohua.li@intel.com>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Wed, Dec 05, 2012 at 09:41:14PM +0000, Alan Cox wrote:
> I was just talking about the always true/always false stuff !

That's -Wlogical-op and not on by default. You can enable it with -W=2.

-- 
Regards/Gruss,
    Boris.
