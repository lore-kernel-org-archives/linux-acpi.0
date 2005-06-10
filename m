From: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
Subject: Re: Sony Vaio PCG-C1VRX/K Picturebook, Suspend to Ram
	works, but has a strange effect on the idle display
Date: Sat, 11 Jun 2005 00:08:37 +0100
Message-ID: <1118444918.6648.438.camel@tyrosine>
References: <200506102038.31928.linux@celifornia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200506102038.31928.linux-mmCHBaZtUya2oZ/6fjIToQ@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Fri, 2005-06-10 at 20:38 +0200, Benedek Frank wrote:

> Now, I can suspend and resume with the script I wrote for it, but even while 
> suspended, the screen wont turn 100% off. If I tilt in in a way, about 
> 160degree angle, I can see some text on the screen. Of course I can barely 
> see it, but I can for Christ`s sake, while it should be off. For an 
> "untrained" eye it seems the screen is black of course, but I got suspicious 
> after a few days of being able to suspend, as the laptop wasnt 100% quiet. 
> The screen is making a little, very very little scratching noise, that I 
> cannot really describe its more like an "electric" noise. Its bugging me, as 
> it must be using some of my battery, while it should not be using anything 
> other than what the RAM needs to not loose its stored memory.

If you don't have a PCI driver bound to your video device, the kernel
will not actually power it down. This is probably a deficiency in the
kernel, but still. On most machines the BIOS will power it down anyway,
but this isn't always the case.

-- 
Matthew Garrett | mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
