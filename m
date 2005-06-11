From: Benedek Frank <linux-mmCHBaZtUya2oZ/6fjIToQ@public.gmane.org>
Subject: Re: Sony Vaio PCG-C1VRX/K Picturebook, Suspend to Ram works, but has a strange effect on the idle display
Date: Sat, 11 Jun 2005 14:43:44 +0200
Message-ID: <200506111443.45333.linux@celifornia.com>
References: <200506111039.30250.linux@celifornia.com> <1118480967.6648.445.camel@tyrosine>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1118480967.6648.445.camel@tyrosine>
Content-Disposition: inline
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

On Saturday 11 June 2005 11:09, Matthew Garrett wrote:
> On Sat, 2005-06-11 at 10:39 +0200, Benedek Frank wrote:
> > So it means there isnt a way I can make it work? How can I tell the BIOS
> > to shut the screen? Do I need to enable that dusty APMD to do it for me?
>
> You need a driver that will power down the PCI device.
>
> > And the screen is almos shut, so it is definetally dimmed to the extent
> > where it cannot be seen, except with suspicious eyes. And when I resume,
> > which is open the display and hit a key, I can see that the display turns
> > off for a second, and then on again. And when I suspend without that boot
> > time parameter, the screen is off when I do the suspend, just there is no
> > way to wake it up again.
>
> That boot parameter has nothing to do with suspend (the only code path
> it's involved with is run on resume), so I doubt that.
>
> > So my new question is, isnt there a tool, that wakes up
> > Video for a Ati Mobility P/M card? I also have a Dell 700m, with an Intel
> > onboard card, that comes with the centrinos, and there is a tool, that
> > need to be run upon awakening, and the video will post.
>
> If the s3_bios option works, then vbetool will probably work as well.
>
> We need some sort of solution for this. It would be easy enough to write
> a PCI driver that binds to any video device and puts it into D3 on
> suspend.

Thanks. I am unfortunately very far from writing anything that complex. Do you 
know who might be able to write this? Or maybe somebody already wrote it 
before.?

Thanks

Ben


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
