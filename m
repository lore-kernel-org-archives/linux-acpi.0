From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Suspend-to-RAM on ThinkPad R51
Date: Tue, 29 Mar 2005 10:38:23 +0200
Message-ID: <20050329083823.GA3897@elf.ucw.cz>
References: <200503261534.44710.barr.156@osu.edu> <20050328203751.GB3695@openzaurus.ucw.cz> <200503282114.15289.barr.156@osu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200503282114.15289.barr.156-ZbGKxL/pcrQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andrew Barr <barr.156-ZbGKxL/pcrQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Po 28-03-05 21:14:15, Andrew Barr wrote:
> On Monday 28 March 2005 03:37 pm, Pavel Machek wrote:
> > Try rmmod input (and related) modules before suspend and insmoding
> > them after resume...
> 
> I tried removing psmouse, usbhid, and evdev. It still freezes on resume, 
> although I can now say it freezes shortly after resume--the caps lock key 
> reacts for a brief second on resume. My kernel config file is 
> attached--anything else I should be modularizing and removing?

I'd like 

CONFIG_SERIO=y
CONFIG_SERIO_I8042=y

...to be done in modules. You'll probably need to modularize whole
input to achieve that.
								Pavel

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
